import 'package:flutter/material.dart';


class InviteFriends extends StatefulWidget {
  const InviteFriends({super.key});

  @override
  State<InviteFriends> createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
        'Feature Not available',
        style: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontFamily: 'inter',
        fontWeight: FontWeight.w600,
        height: 0,
        ),
      )
      ),
    );
  }
}
