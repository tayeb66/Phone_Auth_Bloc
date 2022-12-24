import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_bloc1/Cubits/phone_auth_cubit.dart';
import 'package:phone_auth_bloc1/Cubits/phone_auth_state.dart';
import 'package:phone_auth_bloc1/views/verify_page.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignInPage"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                ///
                keyboardType: TextInputType.phone,
                controller: phoneController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Phone Number"),
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
                      String? phoneNumber = "+880" + phoneController.text;
                      BlocProvider.of<PhoneAuthCubit>(context)
                          .codeSent(phoneNumber);
                      phoneController.clear();
                    },
                    child: Text(
                      "SignIn",
                      textScaleFactor: 1.3,
                    ),
                  );
                },
                listener: (context, state) {
                  if(state is CodeSentState){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => VerifyPage()));
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
