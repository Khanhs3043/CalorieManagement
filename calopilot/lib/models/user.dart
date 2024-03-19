class mUser{
  String id;
  String? name;
  String? email;
  String? password;
  int? weight;
  int? height;
  int? age;
  String? gender;

  mUser({
    required this.id,
    this.password,
    this.name,
    this.gender,
    this.email,
    this.age,
    this.height,
    this.weight
  });
}