class SignUpWithEmailAndPasswordExceptions {
  final String message;
  const SignUpWithEmailAndPasswordExceptions(
      [this.message = "An Unknown error occured"]);

  factory SignUpWithEmailAndPasswordExceptions.code(String code) {
    switch (code) {
      case "invalid-email":
        return const SignUpWithEmailAndPasswordExceptions(
            "Invalid email address.");
      case "user-not-found":
        return const SignUpWithEmailAndPasswordExceptions("User not found.");
      case "wrong-password":
        return const SignUpWithEmailAndPasswordExceptions("Invalid password.");
      case "email-already-in-use":
        return const SignUpWithEmailAndPasswordExceptions(
            "Email is already in use.");
      case "weak-password":
        return const SignUpWithEmailAndPasswordExceptions(
            "Password is too weak.");
      // Add more cases as needed
      default:
        return SignUpWithEmailAndPasswordExceptions("An error occurred: $code");
    }
  }
}
