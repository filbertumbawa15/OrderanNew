import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasorderan/bloc/user/forgotpassword/forgotpassword_bloc.dart';
import 'package:tasorderan/components/components.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _selectedalamatemail = TextEditingController();
  final forgotPasswordstate = GlobalKey<FormState>();
  ValueNotifier<bool>? _isButtonDisabled;
  final components = Tools();

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = ValueNotifier<bool>(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ForgotpasswordBloc(),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/imgs/bg-login.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: forgotPasswordstate,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Lupa Password",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Masukkan Email Anda",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: TextFormField(
                            controller: _selectedalamatemail,
                            decoration: InputDecoration(
                              hintStyle:
                                  const TextStyle(color: Color(0xFF938D8D)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              hintText: "Email",
                              filled: true,
                              fillColor:
                                  const Color(0xFFAEAEAE).withOpacity(0.65),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0.0)),
                                borderSide:
                                    BorderSide(color: Color(0xFFAEAEAE)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Masukkan Email";
                              }
                              return null;
                            },
                            onChanged: (val) {
                              if (val.isNotEmpty) {
                                setState(() {
                                  _isButtonDisabled!.value = false;
                                });
                              } else {
                                setState(() {
                                  _isButtonDisabled!.value = true;
                                });
                              }
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.height / 2.15,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 15),
                      child:
                          BlocConsumer<ForgotpasswordBloc, ForgotpasswordState>(
                        listener: (context, state) {
                          if (state is ForgotpasswordSuccess) {
                            Navigator.pushReplacementNamed(
                                context, '/email_verification');
                          }
                        },
                        builder: (context, state) {
                          if (state is ForgotpasswordLoading) {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              components.showDia();
                            });
                          } else if (state is ForgotpasswordFailed) {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              components.dia!.hide();
                              final value = state.message;
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(value),
                              ));
                            });
                          }
                          return ValueListenableBuilder(
                            valueListenable: _isButtonDisabled!,
                            builder: (context, value, child) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  backgroundColor: const Color(0xFF5599E9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                ),
                                onPressed: _isButtonDisabled!.value
                                    ? null
                                    : () async {
                                        if (forgotPasswordstate.currentState!
                                            .validate()) {
                                          context
                                              .read<ForgotpasswordBloc>()
                                              .add(ForgotPassEvent(
                                                  email: _selectedalamatemail
                                                      .text));
                                        }
                                      },
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 16.0,
                                      right: 16.0,
                                      top: 12,
                                      bottom: 12),
                                  child: Text(
                                    "Kirim Email",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
