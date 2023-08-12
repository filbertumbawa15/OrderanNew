import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:tasorderan/bloc/user/register/register_user_bloc.dart';
import 'package:tasorderan/components/components.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  // bool? _isButtonDisabled;
  ValueNotifier<bool>? _isButtonDisabled;
  bool? _passwordVisible;
  final registerFormState = GlobalKey<FormState>();
  SimpleFontelicoProgressDialog? _dialog;
  final components = Tools();

  @override
  void initState() {
    _isButtonDisabled = ValueNotifier<bool>(true);
    super.initState();
    _passwordVisible = true;
    // _isButtonDisabled = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade50,
      body: BlocProvider(
        create: (context) => RegisterUserBloc(),
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/imgs/bg-login.jpg'),
            fit: BoxFit.cover,
          )),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: registerFormState,
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
                          'Register',
                          style: TextStyle(
                              fontSize: 28.0, fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          'Buat Akun Baru',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Nama",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: TextFormField(
                                  controller: _controllerName,
                                  decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        color: Color(0xFF938D8D)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    hintText: "Masukkan Nama",
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
                                  onChanged: (val) {
                                    if (val.isNotEmpty &&
                                        _controllerPhone.text.isNotEmpty &&
                                        _controllerEmail.text.isNotEmpty &&
                                        _controllerPassword.text.isNotEmpty) {
                                      _isButtonDisabled!.value = false;
                                    } else {
                                      _isButtonDisabled!.value = true;
                                    }
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "No. Telepon",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: TextFormField(
                                  controller: _controllerPhone,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(13),
                                  ],
                                  decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        color: Color(0xFF938D8D)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    hintText: "Masukkan Nomor Telepon",
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
                                  onChanged: (val) {
                                    if (val.isNotEmpty &&
                                        _controllerName.text.isNotEmpty &&
                                        _controllerEmail.text.isNotEmpty &&
                                        _controllerPassword.text.isNotEmpty) {
                                      _isButtonDisabled!.value = false;
                                    } else {
                                      _isButtonDisabled!.value = true;
                                    }
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
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
                                controller: _controllerEmail,
                                decoration: InputDecoration(
                                  hintStyle:
                                      const TextStyle(color: Color(0xFF938D8D)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  hintText: "Masukkan Email",
                                  filled: true,
                                  fillColor:
                                      const Color(0xFFAEAEAE).withOpacity(0.65),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    borderSide:
                                        BorderSide(color: Color(0xFFAEAEAE)),
                                  ),
                                ),
                                onChanged: (val) {
                                  if (val.isNotEmpty &&
                                      _controllerName.text.isNotEmpty &&
                                      _controllerEmail.text.isNotEmpty &&
                                      _controllerPassword.text.isNotEmpty) {
                                    _isButtonDisabled!.value = false;
                                  } else {
                                    _isButtonDisabled!.value = true;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
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
                              child: TextFormField(
                                  controller: _controllerPassword,
                                  decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        color: Color(0xFF938D8D)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    hintText: "Masukkan Password",
                                    filled: true,
                                    fillColor: const Color(0xFFAEAEAE)
                                        .withOpacity(0.65),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      borderSide:
                                          BorderSide(color: Color(0xFFAEAEAE)),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _passwordVisible!
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: const Color(0xFF938D8D),
                                        size: 20.0,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _passwordVisible = !_passwordVisible!;
                                        });
                                      },
                                    ),
                                  ),
                                  obscureText: _passwordVisible!,
                                  onChanged: (val) {
                                    if (val.isNotEmpty &&
                                        _controllerName.text.isNotEmpty &&
                                        _controllerEmail.text.isNotEmpty &&
                                        _controllerPassword.text.isNotEmpty) {
                                      _isButtonDisabled!.value = false;
                                    } else {
                                      _isButtonDisabled!.value = true;
                                    }
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: BlocConsumer<RegisterUserBloc,
                                RegisterUserState>(
                              listener: (context, state) async {
                                if (state is RegisterUserSuccess) {
                                  _dialog!.hide();
                                  await Navigator.pushReplacementNamed(
                                      context, '/otp_verification');
                                }
                              },
                              builder: (context, state) {
                                if (state is RegisterUserLoading) {
                                  Future.delayed(const Duration(seconds: 0),
                                      () {
                                    _showDialog(
                                        context,
                                        SimpleFontelicoProgressDialogType
                                            .normal,
                                        'Normal');
                                  });
                                } else if (state is RegisterUserError) {
                                  _dialog!.hide();
                                  final value = state.response.errors!.values
                                      .elementAt(0)[0];
                                  Future.delayed(const Duration(seconds: 0),
                                      () {
                                    components.alert(context, value);
                                  });
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
                                                context
                                                    .read<RegisterUserBloc>()
                                                    .add(CreateUserEvent(
                                                      name: _controllerName.text
                                                          .toString(),
                                                      phone: _controllerPhone
                                                          .text
                                                          .toString(),
                                                      email: _controllerEmail
                                                          .text
                                                          .toString(),
                                                      password:
                                                          _controllerPassword
                                                              .text
                                                              .toString(),
                                                      sendOTPVia: 'email',
                                                    ));
                                              },
                                        child: const Text(
                                          'Register',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    });
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
                                "Sudah punya akun? ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                child: const Text(
                                  "login",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xFF5599E9),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
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

  void _showDialog(BuildContext context, SimpleFontelicoProgressDialogType type,
      String text) async {
    _dialog ??= SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);
    // _dialog == null
    //     ? _dialog = SimpleFontelicoProgressDialog(
    //         context: context, barrierDimisable: false)
    //     : null;
    if (type == SimpleFontelicoProgressDialogType.custom) {
      _dialog!.show(
          message: text,
          type: type,
          width: 150.0,
          height: 75.0,
          loadingIndicator: const Text(
            'C',
            style: TextStyle(fontSize: 24.0),
          ));
    } else {
      _dialog!.show(
          message: text,
          type: type,
          horizontal: true,
          width: 150.0,
          height: 75.0,
          hideText: true,
          indicatorColor: Colors.blue);
    }
  }
}
