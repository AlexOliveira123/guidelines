import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'profile_controller.dart';
import 'components/item_profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ModularState<ProfilePage, ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: <Widget>[
            ItemProfile(
              icon: Icons.person_outline,
              text: 'Meus Dados',
              onTap: () => Modular.to.pushNamed('/my-data'),
            ),
            ItemProfile(
              icon: Icons.info_outline,
              text: 'Informações Gerais',
              onTap: () => Modular.to.pushNamed('/info'),
            ),
            Divider(),
            ItemProfile(
              icon: Icons.exit_to_app,
              text: 'Sair',
              onTap: () => controller.logOut().whenComplete(() => Modular.to.pushReplacementNamed('/login')),
            ),
          ],
        ),
      ),
    );
  }
}
