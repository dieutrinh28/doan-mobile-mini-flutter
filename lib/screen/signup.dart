import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../model/network_request.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  File? imageFile;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUp() async {
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

  Future<void> openGallery() async {
    List<Asset> resultList = [];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: resultList,
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: const MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Select Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      print(e.toString());
    }

    if (!mounted) return;

    setState(() {
      if (resultList.isNotEmpty) {
        Asset asset = resultList[0];
        asset.getByteData().then((byteData) {
          imageFile = File.fromRawPath(byteData.buffer.asUint8List());
        });
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> openCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> saveImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/image.png';
    await image.copy(imagePath);
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
              // const SizedBox(height: 24),
              // const Text(
              //   "Images",
              //   style: TextStyle(
              //     fontWeight: FontWeight.w600,
              //     fontSize: 14,
              //     color: Color(0xFF333232),
              //   ),
              // ),
              // const SizedBox(height: 8),
              // Center(
              //   child: imageFile == null
              //       ? const Text('No image selected.')
              //       : Image.file(
              //           imageFile!,
              //           fit: BoxFit.cover,
              //         ),
              // ),
              // Center(
              //   child: IconButton(
              //     onPressed: () {
              //       showModalBottomSheet(
              //         context: context,
              //         builder: (BuildContext context) {
              //           return Wrap(
              //             children: [
              //               ListTile(
              //                 leading: const Icon(Icons.camera_alt),
              //                 title: const Text('Take a photo'),
              //                 onTap: () {
              //                   Navigator.of(context).pop();
              //                   openCamera();
              //                 },
              //               ),
              //               ListTile(
              //                 leading: const Icon(Icons.image),
              //                 title: const Text('Choose from gallery'),
              //                 onTap: () {
              //                   Navigator.of(context).pop();
              //                   openGallery();
              //                 },
              //               ),
              //             ],
              //           );
              //         },
              //       );
              //     },
              //     icon: const Icon(
              //       Icons.add_a_photo,
              //     ),
              //   ),
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
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Failed to signup. Please try again later.'),
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
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
            // color: Color(0xFF333232),
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
