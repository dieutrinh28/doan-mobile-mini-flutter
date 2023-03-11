class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String? image;
  String? background;

  User(
      {this.id,
        this.name,
        this.email,
        this.password,
        this.image,
        this.background});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    image = json['image'];
    background = json['background'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['image'] = this.image;
    data['background'] = this.background;
    return data;
  }
}
