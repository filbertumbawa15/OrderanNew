import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:tasorderan/bloc/user/login/login_bloc.dart';
import 'package:tasorderan/components/components.dart';

class Login extends StatefulWidget {
  SimpleFontelicoProgressDialog? _dialog;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // bool loggedIn = false;
  ValueNotifier<bool>? _passwordVisible;
  ValueNotifier<bool>? _isButtonDisabled;
  final loginFormState = GlobalKey<FormState>();
  final components = Tools();

  // get prefs => null;

  @override
  void initState() {
    super.initState();
    _passwordVisible = ValueNotifier<bool>(true);
    _isButtonDisabled = ValueNotifier<bool>(true);
  }

  // _setPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.getString('user') != null) {
  //     await setState(() {
  //       loggedIn = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/imgs/bg-login.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: loginFormState,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Image.asset(
                            "assets/imgs/taslogo.png",
                            fit: BoxFit.contain,
                            width: 100,
                          ),
                        ),
                        const Text(
                          'Selamat Datang',
                          style: TextStyle(
                              fontSize: 28.0, fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          'Masuk ke Akun Anda',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        color: Color(0xFF938D8D)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    hintText: "Masukkan Email",
                                    filled: true,
                                    fillColor: const Color(0xFFAEAEAE)
                                        .withOpacity(0.65),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      borderSide:
                                          BorderSide(color: Color(0xFFAEAEAE)),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Masukkan Email";
                                    }
                                    if (!RegExp(r'\S+@\S+\.\S+')
                                        .hasMatch(value)) {
                                      return "Masukkan Email yang valid";
                                    }
                                    return null;
                                  },
                                  onChanged: (val) {
                                    if (val.isNotEmpty &&
                                        _passwordController.text.isNotEmpty) {
                                      _isButtonDisabled!.value = false;
                                    } else {
                                      _isButtonDisabled!.value = true;
                                    }
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: ValueListenableBuilder(
                                valueListenable: _passwordVisible!,
                                builder: (context, value, child) {
                                  return TextFormField(
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        hintStyle: const TextStyle(
                                            color: Color(0xFF938D8D)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 10.0),
                                        hintText: 'Masukkan Password',
                                        filled: true,
                                        fillColor: const Color(0xFFAEAEAE)
                                            .withOpacity(0.65),
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
                                          borderSide: BorderSide(
                                              color: Color(0xFFAEAEAE)),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            // Based on passwordVisible state choose the icon
                                            _passwordVisible!.value
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: const Color(0xFF938D8D),
                                            size: 20.0,
                                          ),
                                          onPressed: () {
                                            _passwordVisible!.value =
                                                !_passwordVisible!.value;
                                          },
                                        ),
                                      ),
                                      obscureText: _passwordVisible!.value,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Masukkan Password";
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        if (val.isNotEmpty &&
                                            _emailController.text.isNotEmpty) {
                                          _isButtonDisabled!.value = false;
                                        } else {
                                          _isButtonDisabled!.value = true;
                                        }
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: ValueListenableBuilder(
                              valueListenable: _isButtonDisabled!,
                              builder: (context, value, child) {
                                return BlocConsumer<LoginBloc, LoginState>(
                                  listener: (context, state) async {
                                    if (state is LoginSuccess) {
                                      await Navigator.pushReplacementNamed(
                                          context, '/home');
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is LoginLoading) {
                                      SchedulerBinding.instance
                                          .addPostFrameCallback((_) {
                                        components.showDia(
                                          context,
                                          SimpleFontelicoProgressDialogType
                                              .normal,
                                          'Normal',
                                        );
                                      });
                                    } else if (state is LoginError) {
                                      SchedulerBinding.instance
                                          .addPostFrameCallback((_) {
                                        components.dia!.hide();
                                        final value = state.response.message;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(value!),
                                        ));
                                      });
                                      // components.trySomething(context, value!);
                                    }
                                    return ValueListenableBuilder(
                                      valueListenable: _isButtonDisabled!,
                                      builder: (context, value, child) {
                                        return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF5599E9),
                                          ),
                                          onPressed: _isButtonDisabled!.value
                                              ? null
                                              : () async {
                                                  if (loginFormState
                                                      .currentState!
                                                      .validate()) {
                                                    context
                                                        .read<LoginBloc>()
                                                        .add(LoginUserEvent(
                                                          email:
                                                              _emailController
                                                                  .text
                                                                  .toString(),
                                                          password:
                                                              _passwordController
                                                                  .text
                                                                  .toString(),
                                                        ));
                                                  }
                                                },
                                          child: const Text(
                                            'Login',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Belum punya akun? ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xFF5599E9),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/register');
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: const Text(
                                  "Lupa Password",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xFF5599E9),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onTap: () {
                                  // Navigator.of(context).pushReplacement(
                                  //     globals.createRoute(ForgotPassword()));
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _showDialog(BuildContext context, SimpleFontelicoProgressDialogType type,
  //     String text) async {
  //   if (widget._dialog == null) {
  //     widget._dialog = SimpleFontelicoProgressDialog(
  //         context: context, barrierDimisable: false);
  //   }
  //   if (type == SimpleFontelicoProgressDialogType.custom) {
  //     widget._dialog.show(
  //         message: text,
  //         type: type,
  //         width: 150.0,
  //         height: 75.0,
  //         loadingIndicator: Text(
  //           'C',
  //           style: TextStyle(fontSize: 24.0),
  //         ));
  //   } else {
  //     widget._dialog.show(
  //         message: text,
  //         type: type,
  //         horizontal: true,
  //         width: 150.0,
  //         height: 75.0,
  //         hideText: true,
  //         indicatorColor: Colors.blue);
  //   }
  // }
}
