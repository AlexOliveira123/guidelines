import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guidelines/app/modules/register/register_repository.dart';
import 'package:guidelines/app/modules/register/register_repository_interface.dart';

import 'register_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'register_page.dart';

class RegisterModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => RegisterController()),
        Bind<IRegisterRepository>((i) => RegisterRepository(Firestore.instance)),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => RegisterPage()),
      ];

  static Inject get to => Inject<RegisterModule>.of();
}
