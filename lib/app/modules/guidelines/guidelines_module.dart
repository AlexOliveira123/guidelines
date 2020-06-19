import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:guidelines/app/modules/guidelines/new_guideline_page.dart';
import 'package:guidelines/app/modules/guidelines/guidelines_repository.dart';
import 'package:guidelines/app/modules/guidelines/guidelines_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'guidelines_controller.dart';
import 'open_guidelines_page.dart';

class GuidelinesModule extends WidgetModule {
  final int guidelinePageIdx;

  GuidelinesModule(this.guidelinePageIdx);

  @override
  List<Bind> get binds => [
        Bind((i) => GuidelinesController()),
        Bind<IGuidelineRepository>((i) => GuidelinesRepository(Firestore.instance)),
      ];

  @override
  List<Router> get routers => [
        Router('/open-guidelines', child: (_, args) => OpenGuidelinesPage()),
        Router('/new-guideline', child: (_, args) => NewGuidelinePage())
      ];

  static Inject get to => Inject<GuidelinesModule>.of();

  @override
  Widget get view => this.guidelinePageIdx == 0 ? OpenGuidelinesPage() : NewGuidelinePage();
}
