import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guidelines/app/core/stores/data_user/data_user_store.dart';
import 'package:guidelines/app/core/utils/validators.dart';
import 'login_controller.dart';
import '../../core/widgets/uds_logo.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //Logo
                UDSLogo(),

                SizedBox(height: 30),
                
                //Animation with the forms
                _animation(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _animation() {
    return Observer(builder: (_) {
      //Animation on login
      return AnimatedCrossFade(
        firstChild: _firstChild(), // Form login
        secondChild: _secondChild(), // Loader
        crossFadeState: controller.isLoading
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 500),
      );
    });
  }

  // login form
  Widget _firstChild() {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: <Widget>[
            //Input e-mail
            TextFormField(
              validator: (value) => Validators.multiValidators([
                Validators.isRequired(value, 'Campo obrigatório'),
                Validators.isEmail(value, 'E-mail inválido'),
              ]),
              onChanged: controller.onChangedEmail,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w300,
              ),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.mail_outline,
                  color: Color(0xff008CFF),
                ),
                labelText: 'E-mail',
              ),
            ),

            SizedBox(
              height: 10,
            ),

            //Input password
            Observer(builder: (_) {
              return TextFormField(
                validator: (value) => Validators.isRequired(value, 'Campo obrigatório'),
                onChanged: controller.onChangedPassword,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w300,
                ),
                obscureText: controller.obscurePassword,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Color(0xff008CFF),
                  ),
                  suffixIcon: InkWell(
                    child: Icon(
                      controller.obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey[500],
                    ),
                    onTap: controller.setObscurePassword,
                  ),
                  labelText: 'Senha',
                ),
              );
            }),

            SizedBox(
              height: 30,
            ),
            
            //Button to access the app
            // with credentials
            RaisedButton(
              child: Text(
                'Acessar',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                if (_formKey.currentState.validate()) {
                  var res = await controller.logIn();
                  controller.isLoading = false;

                  if (res is FirebaseUser) {
                    Modular.get<DataUserStore>().getUserData();
                    Modular.to.pushReplacementNamed('/home');
                  } else {
                    var msg;

                    //handling errors
                    switch (res) {
                      case 'ERROR_USER_NOT_FOUND':
                        msg = 'Usuário não encontrado.';
                        break;
                      case 'ERROR_NETWORK_REQUEST_FAILED':
                        msg = 'Sem conexão com a internet.';
                        break;
                      case 'ERROR_WRONG_PASSWORD':
                        msg = 'Senha inválida.';
                        break;
                      case 'ERROR_TOO_MANY_REQUESTS':
                        msg = 'Acesso bloqueado. Muitas tentativas em sequência. Tente mais tarde.';
                        break;
                      default:
                        msg = 'Ocorreu um erro ao logar no app. Contate o administrador!';
                        break;  
                    }

                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text(
                        msg,
                      ),
                    ));
                  }
                }
              },
            ),

            SizedBox(height: 10),

            //Button to recover pwd
            RaisedButton(
              child: Text(
                'Recuperar senha',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              color: Colors.white,
              onPressed: () => Modular.to.pushNamed('/recover'),
            ),

            SizedBox(height: 20),

            //Create account text
            RichText(
              text: TextSpan(
                text: "Ainda não é registrado? ",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: "Crie sua conta!",
                    style: TextStyle(
                      color: Color(0xff008CFF),
                      fontWeight: FontWeight.w500,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Modular.to.pushNamed('/register'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //loader
  Widget _secondChild() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Center(
        child: SizedBox(
          width: 72,
          height: 72,
          child: CircularProgressIndicator(
            strokeWidth: 5,
          ),
        ),
      ),
    );
  }
}
