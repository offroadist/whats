import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class OffroadistWhatsAppFirebaseUser {
  OffroadistWhatsAppFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

OffroadistWhatsAppFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<OffroadistWhatsAppFirebaseUser> offroadistWhatsAppFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<OffroadistWhatsAppFirebaseUser>(
            (user) => currentUser = OffroadistWhatsAppFirebaseUser(user));
