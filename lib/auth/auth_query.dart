class AuthQuery {
  static String addUser =
      r"""mutation addUser( $user_id: String!, $name: String!, $email: String!, $image_path: String!) {
  insert_users_one(object: { user_id: $user_id, name: $name, email: $email, image_path: $image_path}) {
    id
    user_id
    name
    email
    image_path
  }
}""";

//   static String userQuery = r"""query UserDetails{
//   users{
//     id
//     name
//     city
//     region
//   }
// }""";
}
