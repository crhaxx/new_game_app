import { serve } from "https://deno.land/std@0.168.0/http/server.ts"; // Import serve

serve(async (req) => {
  const serviceRoleKey = Deno.env.get('SERVICE_ROLE_KEY');  // Získej Service Role Key z environment variable
  const supabaseUrl = Deno.env.get('SUPABASE_URL');  // Získej Supabase URL z environment variable

  if (!serviceRoleKey || !supabaseUrl) {
    console.error("Missing environment variables");
    return new Response('Missing environment variables', { status: 500 });
  }

  // Odeslání požadavku na získání seznamu uživatelů
  const response = await fetch(`${supabaseUrl}/auth/v1/users`, {
    headers: {
      apikey: serviceRoleKey,            // API klíč v hlavičce
      Authorization: `Bearer ${serviceRoleKey}`,  // Authorization Bearer token
    },
  });

  const responseText = await response.text();
  console.log("API Response (raw):", responseText);  // Log odpovědi pro debug

  try {
    const users = JSON.parse(responseText); 
    console.log("Parsed users:", users);
    return new Response(JSON.stringify(users), {
      headers: { 'Content-Type': 'application/json' },
      status: response.status,
    });
  } catch (parseError) {
    console.error("Error parsing JSON:", parseError.message);
    return new Response('Error parsing JSON: ' + parseError.message, { status: 500 });
  }
});
