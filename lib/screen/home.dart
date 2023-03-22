import 'dart:typed_data';
import 'package:doan_mini_flutter/model/network_request.dart';
import 'package:doan_mini_flutter/screen/infor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/User.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<User> userData = [];

  @override
  void initState() {
    super.initState();
    NetworkRequest.fetchUser().then((dataFromSever) {
      setState(() {
        userData = dataFromSever;
      });
    });
  }

  Future<Uint8List> getImageFromUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    return bytes.buffer.asUint8List();
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
        title: const Text(
          'Home',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 32,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: userData.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InforPage(user: userData[index]),
                    ),
                  );
                },
                leading: CircleAvatar(
                  radius: 30,
                  child: ClipOval(
                    child: FutureBuilder<Uint8List>(
                      future: getImageFromUrl('${userData[index].avatar}'),
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
                  '${userData[index].name}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: Text('${userData[index].email}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () async {
                    bool response = await NetworkRequest.deleteUser(
                        '${userData[index].id}');
                    if (response == true) {
                      final filtered = userData
                          .where((element) => element.id != userData[index].id)
                          .toList();
                      setState(() {
                        userData = filtered;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Success to delete.'),
                          ),
                        );
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to delete.'),
                        ),
                      );
                    }
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
