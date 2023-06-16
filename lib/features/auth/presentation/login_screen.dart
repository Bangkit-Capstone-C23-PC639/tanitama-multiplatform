import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tanitama/core/commons/constants.dart';
import 'package:tanitama/core/presentation/widgets/custom_button.dart';
import 'package:tanitama/core/presentation/widgets/cutom_text_field.dart';
import 'package:tanitama/features/auth/domain/entities/user.dart';
import 'package:tanitama/features/auth/presentation/cubit/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(largePadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text('Masuk',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: primaryColor, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: largePadding,
                ),
                CustomTextField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: largePadding,
                ),
                CustomTextField(
                  label: 'Password',
                  controller: _passwordController,
                  obsecureText: true,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: largePadding,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final data = User(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );

                          BlocProvider.of<AuthCubit>(context).login(data);
                        }
                      },
                      label: 'Masuk',
                    )),
                const Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    spacing: 5,
                    children: [
                      Text(
                        'Belum punya akun ?',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            registerRoute,
                          );
                        },
                        child: Text(
                          'Daftar',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
