import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guidelines/app/modules/profile/profile_controller.dart';

class MyDataPage extends StatefulWidget {
  @override
  _MyDataPageState createState() => _MyDataPageState();
}

class _MyDataPageState extends ModularState<MyDataPage, ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Dados'),
        centerTitle: true,
      ),
      body: Observer(
        builder: (_) {
          if (controller.user == null) {
            return Center(child: CircularProgressIndicator(),);
          }

          return Container(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Dados:',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                SizedBox(height: 12),
                TextFormField(
                  initialValue: controller.user?.name,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                  enabled: false,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  initialValue: controller.user?.email,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                  enabled: false,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
