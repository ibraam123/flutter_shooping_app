import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shooping_app/cubits/auth_cubit.dart';
import 'package:flutter_shooping_app/routes.dart';
import 'package:flutter_shooping_app/view/home_view.dart';
import '../widgets/custom_text_form_field.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign In"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            if (state is AuthSuccess) {
              showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    title: const Text("Success"),
                    content: Text(state.message),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(); // close dialog
                          Navigator.of(context)
                              .pushReplacement(
                            AppRoutes.createFadeRoute(
                              const HomeView(),
                            )
                          );
                        },
                        child: const Text("Close"),
                      ),
                    ],
                  );
                },
              );
            }
            if (state is AuthLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Signing in...")),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: _emailController,
                      labelText: "Email",
                      hintText: "Enter your email",
                      prefixIcon: Icons.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        if (!value.contains("@")) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: _passwordController,
                      labelText: "Password",
                      hintText: "Enter your password",
                      prefixIcon: Icons.lock,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().signIn(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please fill in all fields"),
                            ),
                          );
                        }
                      },
                      child: const Text("Sign In"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
