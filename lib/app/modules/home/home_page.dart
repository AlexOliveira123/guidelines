import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guidelines/app/core/widgets/uds_logo.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(10, 3, 3, 3),
              child: UDSLogo(),
            ),
            title: Text('UDS Guidelines'),
            centerTitle: true,
          ),
          body: controller.selectedDestination,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex,
            backgroundColor: Colors.grey[100],
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            onTap: controller.setSelectedIndex,
            showSelectedLabels: true,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.speaker_notes
                ),
                title: Text('Pautas'),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.note_add
                ),
                title: Text('Incluir pauta')
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle
                ),
                title: Text('Perfil')
              ),
            ],
          ),
        );
      }
    );
  }
}
