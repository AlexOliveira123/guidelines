import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guidelines/app/modules/guidelines/guidelines_controller.dart';
import 'package:guidelines/app/modules/home/home_controller.dart';

class NewGuidelinePage extends StatefulWidget {
  @override
  _NewGuidelinePageState createState() => _NewGuidelinePageState();
}

class _NewGuidelinePageState extends ModularState<NewGuidelinePage, GuidelinesController> {
  HomeController homeController = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Observer(builder: (_) {
          //A loader, when data is being sent
          //to the cloud 
          if (controller.isLoading) {
            return CircularProgressIndicator();
          }

          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //Image background
                  Image.asset('assets/images/open_guidelines.png'),

                  SizedBox(
                    height: 24,
                  ),

                  //Input title
                  TextFormField(
                    initialValue: controller.guideline?.title,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Título',
                    ),
                    onChanged: (title) => controller.setGuideline(title: title),
                  ),

                  SizedBox(height: 12),

                  //Input brief description
                  TextFormField(
                    initialValue: controller.guideline?.briefDescription,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Breve descrição',
                    ),
                    onChanged: (briefDescription) => controller.setGuideline(briefDescription: briefDescription),
                  ),


                  SizedBox(height: 12),

                  //Input complete description
                  TextFormField(
                    initialValue: controller.guideline?.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: 'Descrição completa',
                    ),
                    onChanged: (description) =>
                        controller.setGuideline(description: description),
                  ),

                  SizedBox(
                    height: 24,
                  ),
                  
                  //Button finish guideline
                  RaisedButton(
                    onPressed: controller.buttonEnabled
                        ? () async {
                            FocusScope.of(context).requestFocus(FocusNode());

                            var res = await controller.saveGuideline();
                            controller.isLoading = false;

                            if (res is String) {
                              //show message
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Sucesso'),
                                      content: Text('Pauta aberta!'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Modular.to.pop();
                                            homeController.setSelectedIndex(0);
                                          },
                                        )
                                      ],
                                    );
                                  });
                            } else {
                              //error message
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Erro'),
                                    content: Text('Ocorreu um erro ao incluir a pauta. Contate o administrador.'),
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
                        : null,
                    child: Text('Finalizar'),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
