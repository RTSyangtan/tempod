import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:tempod/model/register_model.dart';
import 'package:tempod/provider/register_provider.dart';
import 'package:tempod/view/login_screen.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final avatarCtrl = TextEditingController();

    final state = ref.watch(registerProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Avatar',
              ),
            ),
            ElevatedButton(
              onPressed: state.isLoading
                  ? null
                  : () async {
                      final user = RegisterModel(
                        name: nameCtrl.text,
                        email: emailCtrl.text,
                        password: passwordCtrl.text,
                        avatar: avatarCtrl.text,
                      );

                      await ref
                          .read(registerProvider.notifier)
                          .registerUser(user);

                      if (state.hasError) {
                        print(state.error);
                        Get.snackbar('Failed', 'Registration failed');
                      } else {
                        Get.snackbar('Success', 'Registration successful');

                        Get.to(()=>LoginScreen());
                      }
                    },
              child: state.isLoading
                  ? CircularProgressIndicator()
                  : Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
