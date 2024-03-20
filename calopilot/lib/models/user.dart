class mUser{
  String id;
  String? name;
  String? email;
  String? password;
  double? weight;
  double? height;
  int? age;
  String? gender;

  mUser({
    required this.id,
    this.password='',
    this.name,
    this.gender,
    this.email='',
    this.age,
    this.height,
    this.weight
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id ,
      'name': name,
      'email': email,
      'password': password,
      'weight': weight,
      'height': height,
      'age': age,
      'gender': gender,
    };
  }
}