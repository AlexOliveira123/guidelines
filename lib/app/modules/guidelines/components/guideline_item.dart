import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:guidelines/app/core/enums/guideline_status.dart';
import 'package:guidelines/app/core/models/guideline_model.dart';
import 'package:guidelines/app/modules/guidelines/guidelines_controller.dart';

class GuidelineItem extends StatelessWidget {
  final Guideline guideline;

  const GuidelineItem({
    Key key,
    this.guideline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Modular.get<GuidelinesController>();
    return Card(
      elevation: 4,
      child: Container(
        margin: EdgeInsets.all(20),
        color: Colors.white,
        child: ExpansionTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              //title
              Text(
                guideline?.title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500],
                ),
              ),
              
              //brief description
              Text(
                guideline?.briefDescription,
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Descrição:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  
                  //Complete description
                  Text(
                    guideline?.description,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey[500],
                    ),
                  ),

                  SizedBox(height: 10),

                  //Name user
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      guideline?.nameUser,
                      style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Reopen and finish button
            //according the status
            Observer(
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    controller.isChanging
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          width: 150,
                          child: RaisedButton(
                            child: Text(guideline.status == GuidelineStatus.Open ? 'Finalizar pauta' : 'Reabrir pauta'),
                            onPressed: () async {
                              guideline.status = guideline.status == GuidelineStatus.Open ? GuidelineStatus.Finished : GuidelineStatus.Open;
                              await controller.updateGuideline(guideline);
                              controller.isChanging = false;
                            },
                          ),
                        ),
                  ],
                );
              }
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
