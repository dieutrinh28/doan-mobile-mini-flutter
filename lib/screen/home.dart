import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List users = [
    {
      "id": 1,
      "name": "Trần Hoài Phương",
      "email": "hoaiphuong@gmail.com",
      "password": "hoaiphuong123",
      "avatar":
          "https://phunugioi.com/wp-content/uploads/2020/10/anh-dai-dien-avt-anime-1.jpg"
    },
    {
      "id": 2,
      "name": "Nguyễn Như Trung",
      "email": "nhutrung@gmail.com",
      "password": "nhutrung123",
      "avatar":
          "https://news.meeycdn.com/uploads/images/2023/01/04/avatar-anime-nam-3-1672817351.jpg"
    },
    {
      "id": 3,
      "name": "Nguyễn Hữu Lợi",
      "email": "huuloi@gmail.com",
      "password": "huuloi123",
      "avatar":
          "https://news.meeycdn.com/uploads/images/2023/01/04/avatar-anime-nam-1-1672817351.jpg"
    },
    {
      "id": 4,
      "name": "Đào Phạm Trung Tín",
      "email": "trungtin@gmail.com",
      "password": "trungtin123",
      "avatar":
          "https://i0.wp.com/thatnhucuocsong.com.vn/wp-content/uploads/2022/02/avatar-anime-nam.jpg"
    },
    {
      "id": 5,
      "name": "Đỗ Diệu Trinh",
      "email": "dieutrinh@gmail.com",
      "password": "dieutrinh123",
      "avatar":
          "https://news.meeycdn.com/uploads/images/2022/12/30/anh-anime-nu-70-1672391589.JPG"
    }
  ];

  Future<Uint8List> getImageFromUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    return bytes.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 0,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: ClipOval(
                    child: FutureBuilder<Uint8List>(
                      future: getImageFromUrl(user['avatar']),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ),
                title: Text(
                  user['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: Text(user['email']),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'edit') {
                      //editById(item);
                    } else if (value == 'delete') {
                      //deleteById(id);
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ];
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
