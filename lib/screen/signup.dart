import 'package:doan_mini_flutter/model/network_request.dart';
import 'package:flutter/material.dart';

import '../model/User.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUp() async {
    final user = User(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      avatar: "https://phunugioi.com/wp-content/uploads/2020/10/anh-dai-dien-avt-anime-1.jpg",
      background: "https://thuthuatnhanh.com/wp-content/uploads/2022/06/Hinh-nen-iPad-4K.jpg",
    );
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final avatar = "https://static2.yan.vn/YanNews/2167221/202102/facebook-cap-nhat-avatar-doi-voi-tai-khoan-khong-su-dung-anh-dai-dien-e4abd14d.jpg";
    final background = "https://thuthuatnhanh.com/wp-content/uploads/2022/06/Hinh-nen-iPad-4K.jpg";
    final response =
        await NetworkRequest.addUser(name, email, password, avatar, background);



    if (response == true) {
      setState(() {
        nameController.text = '';
        emailController.text = '';
        passwordController.text = '';
      });
    } else {
      throw Exception("Create Fail");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(
            color: Color.fromRGBO(102, 102, 102, 0.08),
          ),
        ),
        leading: IconButton(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 0,
          ),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 24,
          ),
          onPressed: () {},
        ),
        title: const Text(
          'Signup',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 0,
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildItem(
                name: 'Full Name',
                controller: nameController,
              ),
              buildItem(
                name: 'Email',
                controller: emailController,
              ),
              buildItem(
                name: 'Password',
                controller: passwordController,
              ),
              // buildItem(
              //   name: 'Avatar',
              //   controller: avatarController,
              // ),
              // buildItem(
              //   name: 'cover',
              //   controller: coverController,
              // ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  child: const Text('Signup'),
                  onPressed: () {
                    if (formKey.currentState?.validate != null) {
                      signUp();
                    } else {}
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem({
    required String name,
    required TextEditingController controller,
    VoidCallback? validation,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF333232),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFE1E0E0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF2A9D8F),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFCA2E55),
              ),
            ),
            errorStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Color(0xFFCA2E55),
            ),
          ),
        )
      ],
    );
  }
}
