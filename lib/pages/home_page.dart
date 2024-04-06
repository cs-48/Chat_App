// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_app_demo/components/my_drawer.dart';
import 'package:chat_app_demo/services/auth/auth_service.dart';
import 'package:chat_app_demo/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import '../components/user_tile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //chat and auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void logout() {
    //get auth service
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        title: Padding(
          padding: const EdgeInsets.only(left: 104.0),
          child: const Text("Home"),
        ),
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  //build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text("Error");
          }

          //loading..
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading..");
          }

          //return list view
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  //build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all users except current user
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          //tapped on a user --> go to chat page
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  recieverEmail: userData["email"],
                  recieverID: userData["uid"],
                ),
              ));
        },
      );
    } else {
      return Container();
    }
  }
}
