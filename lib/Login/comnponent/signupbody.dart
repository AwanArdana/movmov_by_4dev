import 'package:flutter/material.dart';
import 'package:movmov/constants.dart';
import 'package:http/http.dart' as http;

class SignUpBody extends StatelessWidget{
  // final Size size;


  // const SignUpBody({Key key, this.size}) : super(key: key);


  // TextEditingController controllerId = new TextEditingController();
  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  TextEditingController controllerPasswordConfirm = new TextEditingController();


  void RegisterData(){
    var url = "https://awanapp.000webhostapp.com/registerakun.php";

    http.post(url, body: {
      "username": controllerUsername.text,
      "password": controllerPassword.text,
      "kodeJenisAkun": "1"
    });
  }

  bool cekConfirmPassword(){
    if(controllerPassword.text == controllerPasswordConfirm.text){
      // RegisterData();
      return true;
    }else{
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(""),
      ),
      body: Container(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                "Create Your Account",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),

            Container(
              //username
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              // width: size.width * 0.8,
              decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(29),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  )
              ),
              child: TextFormField(
                controller: controllerUsername,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Username",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Icon(Icons.person, color: Colors.white,),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            Container(
              //password edittext
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              // width: size.width * 0.8,
              decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(29),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  )
              ),
              child: TextFormField(
                controller: controllerPassword,
                textInputAction: TextInputAction.done,
                obscureText: true,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Icon(Icons.lock, color: Colors.white,),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            Container(
              //password edittext
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              // width: size.width * 0.8,
              decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(29),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  )
              ),
              child: TextFormField(
                controller: controllerPasswordConfirm,
                textInputAction: TextInputAction.done,
                obscureText: true,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Password Confirm",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Icon(Icons.lock, color: Colors.white,),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            Container(
              //login button
                margin: EdgeInsets.only(top: 5),
                child: FlatButton(
                  minWidth: size.width * 0.8,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(29)
                  ),
                  color: kSecondaryColor,
                  onPressed: (){
                    // cekConfirmPassword();
                    // if(cekConfirmPassword()){
                    //   Navigator.pop(context);
                    // }
                    if(controllerUsername.text.isNotEmpty && controllerPassword.text.isNotEmpty && controllerPasswordConfirm.text.isNotEmpty){
                      if(controllerPassword.text == controllerPasswordConfirm.text){
                        RegisterData();
                        Navigator.pop(context);
                        // return true;
                      }else{
                        // return false;
                      }
                    }

                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

}