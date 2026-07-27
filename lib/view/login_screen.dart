import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:tempod/model/login_model.dart';
import 'package:tempod/provider/register_provider.dart';
import 'package:tempod/view/home_screen.dart';
import 'package:tempod/view/widget/bottom_navBar.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(registerProvider);

    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          children: [
            TextFormField(
              controller: emailCtrl,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: passwordCtrl,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: state.isLoading
                  ? null
                  : () async {
                      final user = LoginModel(
                        email: emailCtrl.text,
                        password: passwordCtrl.text,
                      );

                      await ref.read(registerProvider.notifier).loginUser(user);

                      if (state.hasError) {
                        Get.snackbar('Failed', 'Login Failed');
                        print(state.error);
                      } else {
                        Get.snackbar('Success', 'LoginSuccessFull');
                        Get.to(() => MyBottomNavbar());
                      }
                    },
              child: state.isLoading ? CircularProgressIndicator() : Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
