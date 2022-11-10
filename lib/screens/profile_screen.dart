import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_project/provider/profile_info_provider.dart';
import 'package:navigation_project/services/auth_service.dart';
import 'package:navigation_project/utils/responsive/scale_config.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final String imgURL;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    ScaleConfig().init(context);
  }

  @override
  Widget build(BuildContext context) {
    ProfileInfoProvider profileinfo = context.read<ProfileInfoProvider>();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(
            ScaleConfig().scaleHeight(10),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: ScaleConfig().scaleHeight(50),
                    backgroundImage: profileinfo.displayImg,
                  ),
                  SizedBox(
                    height: ScaleConfig().scaleHeight(15),
                  ),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Colors.blue,
                    leading: const Icon(Icons.mood_outlined),
                    title: Text(profileinfo.status!),
                  ),
                  SizedBox(
                    height: ScaleConfig().scaleHeight(5),
                  ),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Colors.green,
                    leading: const Icon(Icons.work),
                    title: const Text("Software Developer"),
                  ),
                  SizedBox(
                    height: ScaleConfig().scaleHeight(5),
                  ),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Colors.amber,
                    leading: const Icon(Icons.phone),
                    title: const Text("+12 345678912"),
                  ),
                  SizedBox(
                    height: ScaleConfig().scaleHeight(5),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await AuthService(FirebaseAuth.instance)
                          .signOut(context: context);
                      context.goNamed("login");
                    },
                    child: const Text("Logout"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
