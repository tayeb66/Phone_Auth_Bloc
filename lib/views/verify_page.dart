import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_bloc1/Cubits/phone_auth_cubit.dart';
import 'package:phone_auth_bloc1/Cubits/phone_auth_state.dart';
import 'package:phone_auth_bloc1/views/home_page.dart';

class VerifyPage extends StatelessWidget {
  VerifyPage({Key? key}) : super(key: key);

  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("VerifyPage"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                controller: numberController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "6-digit number"),
              ),
              SizedBox(
                height: 10,
              ),
              BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width / 1.3, 50)),
                    onPressed: () {
                      BlocProvider.of<PhoneAuthCubit>(context)
                          .verifyCode(numberController.text);
                    },
                    child: Text(
                      "SignIn",
                      textScaleFactor: 1.3,
                    ),
                  );
                },
                listener: (context, state) {
                  if (state is AuthLoginState) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  } else if (state is AuthErrorState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                        SnackBar(
                            content: Text("${state.errorMessage}"),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 1),
                        ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
