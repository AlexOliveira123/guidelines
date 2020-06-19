import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guidelines/app/core/utils/validators.dart';
import 'register_controller.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends ModularState<RegisterPage, RegisterController> {
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Criar uma conta',
        ),
        centerTitle: true,
      ),
      body: Observer(builder: (_) {
        //A Loader when the data is being sent to the cloud
        if (controller.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 12),

                  Text(
                    'Dados pessoais:',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),

                  SizedBox(height: 12),

                  //Input user name
                  TextFormField(
                    initialValue: controller.user?.name ?? '',
                    validator: (value) => Validators.multiValidators([
                      Validators.isRequired(value, 'Campo obrigatório'),
                      Validators.hasMinLen(value, 'O nome deve conter no mínimo 3 dígitos', 3)
                    ]),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                    onChanged: (name) => controller.setUserData(name: name),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      prefixIcon: Icon(
                        Icons.person_outline, 
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                  
                  //Input e-mail
                  TextFormField(
                    initialValue: controller.user?.email ?? '',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                    validator: (value) => Validators.multiValidators([
                      Validators.isRequired(value, 'Campo obrigatório'),
                      Validators.isEmail(value, 'E-mail inválido')
                    ]),
                    onChanged: (email) => controller.setUserData(email: email),
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'E-mail', 
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 16),

                  //Input password
                  Observer(builder: (_) {
                    return TextFormField(
                      initialValue: controller.user?.password ?? '',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                      validator: (value) => Validators.multiValidators([
                        Validators.isRequired(value, 'Campo obrigatório'),
                        Validators.hasMinLen(value, 'A senha deve conter pelos menos 8 dígitos', 8),
                        Validators.hasSpecialCharacter(value, 'A senha deve pelo menos 1 caracter especial (Ex: @,# \$ % &).')
                      ]),
                      keyboardType: TextInputType.text,
                      onChanged: (password) => controller.setUserData(password: password),
                      textCapitalization: TextCapitalization.words,
                      obscureText: controller.passwordObscure,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).primaryColor),
                        suffixIcon: InkWell(
                          child: Icon(
                            controller.passwordObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey[500],
                          ),
                          onTap: controller.setPasswordObscure,
                        ),
                        labelText: 'Senha',
                        helperText: 'A senha deve conter pelo menos 8 dígitos e ao menos 1 caracter especial (Ex: @,# \$ % &).',
                        helperMaxLines: 3,
                      ),
                    );
                  }),

                  SizedBox(height: 26),

                  //Register button
                  RaisedButton(
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        var res = await controller.createUser();
                        controller.isLoading = false;

                        if (res is bool) {
                          //success message
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Sucesso'),
                                  content: Text('Cadastro realizado com sucesso!'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('OK'),
                                      onPressed: () => Modular.to.pushNamedAndRemoveUntil('/login', (route) => false),
                                    )
                                  ],
                                );
                              });
                        } else {
                          var msg;
                          
                          //handling errors
                          switch (res) {
                            case 'ERROR_EMAIL_ALREADY_IN_USE':
                              msg =  'O endereço de email já está sendo usado por outra conta.';
                              break;
                            case 'ERROR_NETWORK_REQUEST_FAILED':
                              msg = 'Sem conexão com a internet.';
                              break;
                            default:
                              msg =  'Não foi possível realizar o cadastro. Contate o administrador!';
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
        );
      }),
    );
  }
}
