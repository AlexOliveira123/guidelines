import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guidelines/app/core/utils/validators.dart';
import 'package:guidelines/app/modules/login/login_controller.dart';
import '../../../core/widgets/uds_logo.dart';

class RecoverPage extends StatefulWidget {
  @override
  _RecoverPageState createState() => _RecoverPageState();
}

class _RecoverPageState extends ModularState<RecoverPage, LoginController> {
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Recuperar senha'),
      ),
      body: Observer(builder: (_) {

        //A loader when is sending the data
        if (controller.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),

                    UDSLogo(),

                    SizedBox(height: 40),

                    //Input e-mail to send e-mail
                    //for the user
                    TextFormField(
                      onChanged: controller.onChangedEmail,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w300,
                      ),
                      validator: (value) => Validators.multiValidators([
                        Validators.isRequired(value, 'E-mail é obrigatório'),
                        Validators.isEmail(value, 'E-mail inválido')
                      ]),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          color: Color(0xff008CFF),
                        ),
                        labelText: 'Informe seu E-mail',
                        labelStyle: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    //confirm button
                    RaisedButton(
                      child: Text(
                        'Confirmar',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (_formKey.currentState.validate()) {
                          var res = await controller.resetPassword();
                          controller.isLoading = false;

                          if (res is bool) {
                            //success message
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Sucesso'),
                                  content: Text('Enviamos para seu e-mail as instruções para redefinir sua senha!'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('OK'),
                                      onPressed: () => Modular.to.pushNamedAndRemoveUntil('/login', (route) => false),
                                    )
                                  ],
                                );
                              },
                            );
                          } else {
                            var msg;

                            //handling errors
                            switch (res) {
                              case 'ERROR_USER_NOT_FOUND':
                                msg = 'Usuário não encontrado. Verifique se o e-mail digitado está correto.';
                                break;
                              case 'ERROR_NETWORK_REQUEST_FAILED':
                                msg = 'Sem conexão com a internet.';
                                break;
                              default:
                                msg = 'Ocorreu um erro ao tentar resetar a sua senha. Contate o administrador!';
                                break;
                            }
                            
                            //error message
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Erro'),
                                  content: Text(msg),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('OK'),
                                      onPressed: () => Modular.to.pop(),
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
