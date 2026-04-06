import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentapp/presentations/cubits/auth/auth_cubit.dart';
import 'package:rentapp/presentations/widgets/my_text_form_field.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  bool _isLogin = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, authState) {
        if (authState.status == AuthStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(authState.errorMessage ?? 'Error'),
              backgroundColor: Colors.red,
            ),
          );
        }

        if (authState.status == AuthStatus.authenticated) {
          _emailController.clear();
          _passwordController.clear();
          _fullNameController.clear();
        }
      },
      child: Scaffold(
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 50,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        maxRadius: 80,
                        child: Icon(
                          size: 100,
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30),

                      if (!_isLogin) ...{
                        MyTextFormField(
                          controller: _fullNameController,
                          hintText: 'Full Name',
                          prefixIcon: Icons.person,
                        ),
                        SizedBox(height: 20),
                      },
                      // Full Name

                      // Email
                      MyTextFormField(
                        controller: _emailController,
                        hintText: 'Email',
                        prefixIcon: Icons.email,
                      ),
                      SizedBox(height: 20),

                      // Password
                      MyTextFormField(
                        controller: _passwordController,
                        hintText: 'Password',
                        prefixIcon: Icons.lock,
                        obscureText: true,
                      ),
                      SizedBox(height: 70),

                      if (authState.status == AuthStatus.loading)
                        Center(child: CircularProgressIndicator())
                      // Button
                      else
                        TextButton(
                          onPressed: () {
                            if (!_isLogin) {
                              context.read<AuthCubit>().register(
                                _fullNameController.text.trim(),
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );
                            } else {
                              context.read<AuthCubit>().login(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.black,
                            ),
                            fixedSize: WidgetStatePropertyAll(
                              Size(MediaQuery.sizeOf(context).width, 70),
                            ),
                          ),
                          child: Text(
                            _isLogin ? 'Login' : 'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      SizedBox(height: 30),

                      //
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(
                          !_isLogin
                              ? 'Already have an account?'
                              : 'Don\'t have an account?',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
