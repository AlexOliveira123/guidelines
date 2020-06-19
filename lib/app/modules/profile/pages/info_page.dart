import 'package:flutter/material.dart';
import 'package:guidelines/app/core/widgets/uds_logo.dart';
import '../../../core/widgets/uds_logo.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações Gerais'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              UDSLogo(),
              Text(
                'Versão 1.0.0',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500]
                )
              ),
              Column(
                children: <Widget>[
                  Text(
                    'FALE CONOSCO',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    'contato@contato.com.br',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey[500],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
