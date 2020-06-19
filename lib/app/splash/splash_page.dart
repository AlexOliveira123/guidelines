import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guidelines/app/core/enums/auth_status.dart';
import 'package:guidelines/app/core/stores/auth/auth_store.dart';
import 'package:guidelines/app/core/stores/data_user/data_user_store.dart';
import 'package:mobx/mobx.dart';
import '../core/widgets/uds_logo.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var disposer;
  var auth = Modular.get<AuthStore>();

  @override
  void initState() {
    super.initState();
    disposer = autorun((_) {
      Future.delayed(Duration(milliseconds: 1500)).whenComplete(() {
        if (auth.authStatus == AuthStatus.Logged) {
          Modular.get<DataUserStore>();
          Modular.to.pushReplacementNamed('/home');
        } else if (auth.authStatus == AuthStatus.Disconnected) {
          Modular.to.pushReplacementNamed('/login');
        }
      });
    });
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: UDSLogo(),
      ),
    );
  }
}
