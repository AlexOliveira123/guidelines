import 'package:guidelines/app/modules/login/pages/recover_page.dart';
import 'login_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'login_page.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => LoginPage()),
        Router('/recover', child: (_, args) => RecoverPage()),
      ];

  static Inject get to => Inject<LoginModule>.of();
}
