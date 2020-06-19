import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guidelines/app/core/enums/guideline_status.dart';
import 'components/guideline_item.dart';
import 'guidelines_controller.dart';

class OpenGuidelinesPage extends StatefulWidget {
  @override
  _OpenGuidelinesPageState createState() => _OpenGuidelinesPageState();
}

class _OpenGuidelinesPageState extends ModularState<OpenGuidelinesPage, GuidelinesController> with SingleTickerProviderStateMixin {
  var _tabController;
  var expansionTile = GlobalKey();


  @override
  void initState() {
    controller.getGuidelines();
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Material(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                indicatorColor: Colors.grey[200],
                tabs: [
                  Tab(child: Text('Abertas')),
                  Tab(child: Text('Finalizadas')),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Observer(
                    builder: (_) {
                      
                      //While the guidelines aren't loaded, will show a loader.
                      if (controller.guidelines == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      
                      //Filtering the guidelines to bring only
                      //with open status
                      var listOpenGuidelines = controller.guidelines
                          .where((guideline) => guideline.status == GuidelineStatus.Open)
                          .toList();
                      
                      //If there is no guidelines with open status,
                      //will show this message.
                      if (listOpenGuidelines.length == 0) {
                        return Center(
                          child: Text(
                            'Não há pautas abertas.',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 17,
                            ),
                          ),
                        );
                      }

                      //If there, it will load
                      //the list
                      return ListView.builder(
                        itemCount: listOpenGuidelines.length,
                        key: Key(controller.expanded.toString()),
                        itemBuilder: (_, idx) {
                          var guideline = listOpenGuidelines[idx];
                          return GuidelineItem(guideline: guideline);
                        },
                      );
                    },
                  ),
                  Observer(builder: (_) {
                    //While the guidelines aren't loaded, will show a loader.
                    if (controller.guidelines == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    //Filtering the guidelines to bring only
                    //with Finished status
                    var listFinishedGuidelines = controller.guidelines
                          .where((guideline) => guideline.status == GuidelineStatus.Finished)
                          .toList();

                    //If there is no guidelines with Finished status,
                    //will show this message.
                    if (listFinishedGuidelines.length == 0) {
                      return Center(
                        child: Text(
                          'Não há pautas finalizadas.',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 17,
                          ),
                        ),
                      );
                    }

                    //If there, it will load
                    //the list
                    return ListView.builder(
                      key: Key(controller.expanded.toString()),
                      itemCount: listFinishedGuidelines.length,
                      itemBuilder: (_, idx) {
                        var guideline = listFinishedGuidelines[idx];
                        return GuidelineItem(guideline: guideline);
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
