import 'package:doan_mini_flutter/model/network_request.dart';
import 'package:flutter/material.dart';

import '../model/User.dart';

class InforPage extends StatefulWidget {
  final User user;
  const InforPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<InforPage> createState() => InforPageState();
}

class InforPageState extends State<InforPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  NetworkRequest repository = NetworkRequest();


  @override
  void initState() {
    super.initState();
    final user = widget.user;
    if (user != null) {
      nameController.text = widget.user.name!;
      emailController.text = widget.user.email!;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 224,
              child: Stack(
                children: [
                  SizedBox(
                    height: 160,
                    width: double.infinity,
                    child: Image.network(
                      widget.user.background!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 132,
                    left: 16,
                    child: Container(
                      height: 92,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.white,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          widget.user.avatar!,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  TextField(
                    controller: nameController,
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: emailController,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 0,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    bool response = await NetworkRequest.updateUser(
                      widget.user.id.toString(),
                      nameController.text,
                      emailController.text,
                      widget.user.password.toString(),
                      widget.user.avatar.toString(),
                      widget.user.background.toString(),
                    );
                    if (response == true) {
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Success to update.'),
                          ),
                        );
                        Navigator.pop(context);
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to update.'),
                        ),
                      );
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
