class User {
  int? id;
  String? name;
  String? emaid;
  String? password;
  String? image;
  String? background;

  User(
      {this.id,
        this.name,
        this.emaid,
        this.password,
        this.image,
        this.background});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emaid = json['emaid'];
    password = json['password'];
    image = json['image'];
    background = json['background'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['emaid'] = this.emaid;
    data['password'] = this.password;
    data['image'] = this.image;
    data['background'] = this.background;
    return data;
  }
}
