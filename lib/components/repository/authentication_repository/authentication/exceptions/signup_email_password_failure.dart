
class SignUpWithEmailAndPasswordFailure {
  final String message;

  const SignUpWithEmailAndPasswordFailure([this.message = "An Unknown error occured"]);
  factory SignUpWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'weak-password' : 
        return const SignUpWithEmailAndPasswordFailure('Enter a Strong Password');
      case 'invalid-email' : 
        return const SignUpWithEmailAndPasswordFailure('Enter a Valid Email');
      case 'email-already in use' : 
        return const SignUpWithEmailAndPasswordFailure('Account already exists');
      case 'operation-not-allowed' : 
        return const SignUpWithEmailAndPasswordFailure('Operation is not allowed.Please contact support');
      case 'user-disabled' : 
        return const SignUpWithEmailAndPasswordFailure('This user has been disabled.Please contact support for help');
      default: 
        return const SignUpWithEmailAndPasswordFailure('');
    }
  }
}