import 'package:demo_project/components/repository/authentication_repository/authentication/exceptions/signup_email_password_failure.dart';
import 'package:demo_project/screens/pages/homepage/home_screen.dart';
import 'package:demo_project/screens/sign_in/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //variable related to firebase
  final _auth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const SignIn())
        : Get.offAll(() => const HomeScreen());
  }

  //Firebase Func
  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar("Error", 'The provide number is not valid');
        } else {
          Get.snackbar('Error', 'Something went wrong.Please try Again!');
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
      PhoneAuthProvider.credential(
          verificationId: this.verificationId.value, smsCode: otp),
    );
    return credentials.user != null? true : false;
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //firebaseUser.value !=null ? Get.offAll(() => const HomeScreen()) : Get.to(() => const SignIn());
      if (firebaseUser.value != null) {
        Get.offAll(() => const HomeScreen());
        return 'User created successfully'; // Return a success message
      } else {
        Get.to(() => const SignIn());
        return 'User creation failed'; // Return a failure message
      }
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print("FIREBASE AUTH EXCEPTION - ${ex.message}");
      throw ex;
    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print("EXCEPTION - ${ex.message}");
      throw ex;
    }
  }

  Future<String> loginWithEmailAndPassword(
      String email, String password) async {
    // try{
    //   await _auth.signInWithEmailAndPassword(email: email, password: password);
    // } on FirebaseAuthException catch(e){

    // }catch (_){}
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'Login successful'; // Return a success message
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException if needed
      // For example, you might want to handle different error codes
      return 'Login failed: ${e.message}'; // Return a failure message
    } catch (_) {
      // Handle other exceptions if needed
      return 'Login failed'; // Return a generic failure message
    }
  }
  

  


Future<UserCredential?> signInWithGoogle() async {
  try {
    // Trigger the authentication flow
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut(); // Sign out the current user if any

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      // User cancelled sign-in process
      return null;
    }
  } catch (error) {
    print('Error signing in with Google: $error');
    // Handle error or display a message to the user.
    return null;
  }
}


Future<void> signOutFromGoogle() async {
    try {
      await  _auth.signOut();
      // After signing out, you may want to navigate the user to the sign-in screen or perform any other necessary actions.
    } catch (error) {
      print('Error signing out from Google: $error');
      // Handle error or display a message to the user.
    }
}

  Future<void> signOut() async {
  try {
    await _auth.signOut();
    // After signing out, you may want to navigate the user to the sign-in screen or perform any other necessary actions.
  } catch (error) {
    print('Error signing out: $error');
    // Handle error or display a message to the user.
  }
}
}
