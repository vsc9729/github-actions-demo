import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navigation_project/provider/profile_info_provider.dart';
import 'package:navigation_project/services/auth_service.dart';
import 'package:navigation_project/services/cloud_storage.dart';
import 'package:navigation_project/utils/responsive/scale_config.dart';
import 'package:navigation_project/utils/widgets/show_snack_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final imageStorage = GetStorage();
  final CloudStoragService storage = CloudStoragService();
  ImageProvider? displayImg;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    ScaleConfig().init(context);
    String? url = await storage.getURL(
      "userImage(${FirebaseAuth.instance.currentUser!.email})",
    );
    if (url != null) {
      await imageStorage.write(
        "userImage(${FirebaseAuth.instance.currentUser!.email})",
        url,
      );
      displayImg = NetworkImage(url);
      // ignore: use_build_context_synchronously
      context.read<ProfileInfoProvider>().setDisplayImg(displayImg!);
      setState(() {});
    }
    super.didChangeDependencies();
  }

  TextEditingController statusController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to the home screen",
            ),
            displayImg == null
                ? IconButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      try {
                        XFile? selectedImage =
                            await picker.pickImage(source: ImageSource.gallery);
                        await storage.uploadFile(
                          File(selectedImage!.path),
                          "userImage(${FirebaseAuth.instance.currentUser!.email})",
                        );
                        context.read<ProfileInfoProvider>().setDisplayImg(
                              FileImage(
                                File(selectedImage.path),
                              ),
                            );
                        setState(() {
                          displayImg = FileImage(File(selectedImage.path));
                        });
                      } catch (e) {
                        showSnackBar(
                          context,
                          e.toString(),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.add_a_photo,
                    ),
                  )
                : Container(),
            SizedBox(
              height: ScaleConfig().scaleHeight(10),
            ),
            displayImg != null
                ? Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: displayImg!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.only(
                left: ScaleConfig().scaleWidth(40),
                right: ScaleConfig().scaleWidth(40),
              ),
              child: TextField(
                controller: statusController,
              ),
            ),
            TextButton(
              onPressed: () {
                context
                    .read<ProfileInfoProvider>()
                    .setStatus(statusController.text);
                context.pushNamed(
                  "profile",
                );
              },
              child: const Text(
                "Go to your profile",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await AuthService(FirebaseAuth.instance)
                    .signOut(context: context);
                context.goNamed("login");
              },
              child: const Text("Logout"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  displayImg = null;
                });
              },
              child: const Text("Remove Image"),
            ),
          ],
        ),
      ),
    );
  }
}
