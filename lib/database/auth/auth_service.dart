import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  //NOTE: Sign in with email and password
  Future<AuthResponse> signInWithEmailAndPassword(
      String email, String password) async {
    return await _supabase.auth
        .signInWithPassword(email: email, password: password);
  }

  //NOTE: Sign up with email and password
  Future<AuthResponse> signUpWithEmailAndPassword(
      String email, String password, String username) async {
    return await _supabase.auth
        .signUp(email: email, password: password, data: {'username': username});
  }

  //NOTE: Sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  //NOTE: Get user email
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}
