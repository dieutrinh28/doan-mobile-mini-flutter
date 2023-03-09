import 'package:flutter/material.dart';

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
          "https://i0.wp.com/thatnhucuocsong.com.vn/wp-content/uploads/2022/02/avatar-anime-nam.jpg?ssl=1"
    },
    {
      "id": 5,
      "name": "Đỗ Diệu Trinh",
      "email": "dieutrinh@gmail.com",
      "password": "dieutrinh123",
      "avatar":
          "https://cdn.alongwalker.co/info/wp-content/uploads/2022/11/16190620/image-99-hinh-avatar-cute-ngau-ca-tinh-de-thuong-nhat-cho-nam-nu-178699bcb1cf6d58f3f17d3a1ee26472.jpg"
    }
  ];

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
          itemCount: 5,
          itemBuilder: (context, index) {
            final user = users[index] as Map;
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
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
