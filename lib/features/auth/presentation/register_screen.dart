import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tanitama/core/commons/constants.dart';
import 'package:tanitama/core/presentation/widgets/custom_button.dart';
import 'package:tanitama/core/presentation/widgets/cutom_text_field.dart';
import 'package:tanitama/features/auth/domain/entities/auth.dart';
import 'package:tanitama/features/auth/domain/entities/user.dart';
import 'package:tanitama/features/auth/presentation/cubit/auth_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoadingAuthState) {
            EasyLoading.show(status: 'Tunggu sebentar...');
          } else if (state is AuthErrorState) {
            EasyLoading.showError(state.message);
          } else if (state is LogedState) {
            EasyLoading.dismiss();
            Navigator.pushReplacementNamed(context, homeRoute);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(largePadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text('Daftar',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: primaryColor,
                              fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: largePadding,
                  ),
                  CustomTextField(
                    label: 'Nama',
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                  ),
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
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(
                    height: largePadding,
                  ),
                  CustomTextField(
                    label: 'Konfirmasi Password',
                    controller: _passwordConfirmationController,
                    obsecureText: true,
                    textInputAction: TextInputAction.done,
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
                                name: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                passwordConfirmation:
                                    _passwordConfirmationController.text);

                            BlocProvider.of<AuthCubit>(context).register(data);
                          }
                        },
                        label: 'Daftar',
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
                          'Sudah punya akun ?',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              loginRoute,
                            );
                          },
                          child: Text(
                            'Masuk',
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
      ),
    );
  }
}
