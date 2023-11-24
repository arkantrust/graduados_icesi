enum Membership { free, premium }

class User {
  final String id;
  final String email;
  final String password;
  final String name;
  final Membership membership;
  final String career;
  final String photo;

  User(
      {required this.id,
      required this.email,
      required this.password,
      required this.name,
      required this.membership,
      required this.career,
      required this.photo});

  const User.unknown({
    this.id = '',
    this.name = '',
    this.email = '',
    this.password = '',
    this.membership = Membership.free,
    this.career = '',
    this.photo = '',
  });

  bool isPremium() => membership == Membership.premium;
}
