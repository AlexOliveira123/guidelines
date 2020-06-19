import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guidelines/app/core/interfaces/auth_repository_interface.dart';
import 'package:guidelines/app/core/interfaces/data_user_repository_interface.dart';
import 'package:guidelines/app/core/repositories/auth_repository.dart';
import 'package:guidelines/app/core/repositories/data_user_repository.dart';
import 'package:guidelines/app/core/stores/auth/auth_store.dart';
import 'package:guidelines/app/core/stores/data_user/data_user_store.dart';
import 'package:guidelines/app/modules/login/login_module.dart';
import 'package:guidelines/app/modules/register/register_module.dart';

import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:guidelines/app/app_widget.dart';

import 'modules/guidelines/guidelines_module.dart';
import 'modules/home/home_module.dart';
import 'modules/profile/profile_module.dart';
import '../app/splash/splash_page.dart';
import '../app/modules/login/pages/recover_page.dart';
import 'modules/profile/pages/info_page.dart';
import 'modules/profile/pages/my_data_page.dart';
import '../app/core/interfaces/data_user_repository_interface.dart';
import '../app/core/repositories/data_user_repository.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => AuthStore(i.get())),
        Bind((i) => DataUserStore(i.get())),
        Bind<IAuthRepository>((i) => AuthRepository(FirebaseAuth.instance)),
        Bind<IDataUserRepository>((i) => DataUserRepository(Firestore.instance)),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => SplashPage()),
        Router('/login', module: LoginModule(), transition: TransitionType.noTransition),
        Router('/recover', child: (_, args) => RecoverPage()),
        Router('/home', module: HomeModule()),
        Router('/guidelines', module: GuidelinesModule(0)),
        Router('/profile', module: ProfileModule()),
        Router('/register', module: RegisterModule()),
        Router('/my-data', child: (_, args) => MyDataPage()),
        Router('/info', child: (_, args) => InfoPage()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
