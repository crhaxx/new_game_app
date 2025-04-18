import { createClient } from 'npm:@supabase/supabase-js@2'
import { JWT } from 'npm:google-auth-library@9'

// Funkce pro získání přístupového tokenu
const getAccessToken = ({
  clientEmail,
  privateKey,
}: {
  clientEmail: string
  privateKey: string
}): Promise<string> => {
  return new Promise((resolve, reject) => {
    const jwtClient = new JWT({
      email: clientEmail,
      key: privateKey,
      scopes: ['https://www.googleapis.com/auth/firebase.messaging'],
    })
    jwtClient.authorize((err, tokens) => {
      if (err) {
        reject(err)
        return
      }
      resolve(tokens!.access_token!)
    })
  })
}

// Supabase klient
const supabase = createClient(
  Deno.env.get('SUPABASE_URL')!,
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
)

// Typ payloadu
interface WebhookPayload {
  type: 'INSERT'
  table: string
  record: {
    id: string
    creator_id: string
    name: string
    price: number
  }
  schema: 'public'
  old_record: null
}

Deno.serve(async (req) => {
  const payload = await req.json() as WebhookPayload

  console.log("Příchozí payload:", payload)

  // 1. Získání FCM tokenu podle profile_id
  const { data, error } = await supabase
    .from('profiles')
    .select('fcm_token')
    .eq('id', payload.record.creator_id)
    .single()

  if (error || !data) {
    console.error('Profile not found or Supabase error:', error)
    return new Response(
      JSON.stringify({ error: 'Profile not found or invalid profile_id.' }),
      { status: 404, headers: { "Content-Type": "application/json" } }
    )
  }

  const fcmToken = data.fcm_token as string

  // 2. Import service account credentials
  const { default: serviceAccount } = await import('../service_account.json', {
    with: { type: 'json' },
  })

  // 3. Získání přístupového tokenu pro FCM
  const accessToken = await getAccessToken({
    clientEmail: serviceAccount.client_email,
    privateKey: serviceAccount.private_key
  })

  // 4. Odeslání notifikace
  const res = await fetch(
    `https://fcm.googleapis.com/v1/projects/${serviceAccount.project_id}/messages:send`,
    {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${accessToken}`,
      },
      body: JSON.stringify({
        message: {
          token: fcmToken,
          notification: {
            title: `Order confirmation`,
            body: `${payload.record.game}`
          }
        }
      })
    }
  )

  const resData = await res.json()

  if (res.status < 200 || res.status > 299) {
    console.error('FCM error response:', resData)
    return new Response(
      JSON.stringify({ error: 'Failed to send FCM notification', details: resData }),
      { status: 500, headers: { "Content-Type": "application/json" } }
    )
  }

  console.log('Notification sent successfully.')
  return new Response(
    JSON.stringify(resData),
    { headers: { "Content-Type": "application/json" } }
  )
})
