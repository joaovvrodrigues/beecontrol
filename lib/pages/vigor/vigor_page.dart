// 📦 Package imports:

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import '../../core/app_text_style.dart';
import '../../core/app_theme.dart';
import '../../models/recognition.dart';
import '../../models/user_model.dart';
import 'vigor_result_page.dart';

class VigorPage extends StatefulWidget {
  const VigorPage({Key? key}) : super(key: key);

  @override
  _VigorPageState createState() => _VigorPageState();
}

class _VigorPageState extends State<VigorPage> {
  XFile? xfile;
  final ImagePicker _picker = ImagePicker();
  Recognition recognition = Recognition();
  final formKey = GlobalKey<FormState>();
  var user = UserModel();
  bool isDetecting = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
            child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(55.0),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          SizedBox(width: 35, height: 35),
                          Text('Vigor da abelha', style: AppTextStyle.boldTitle),
                          SizedBox(width: 35, height: 35)
                        ],
                      )),
                ),
                body: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: AnimationLimiter(
                        child: Column(
                      children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 375),
                          childAnimationBuilder: (widget) => SlideAnimation(
                                horizontalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: widget,
                                ),
                              ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: ElevatedButton(
                                onPressed: () async {
                                  xfile = await _picker.pickImage(source: ImageSource.gallery);
                                  if (xfile != null) {
                                    await Tflite.runModelOnImage(
                                            path: xfile!.path, // required
                                            imageMean: 117.0, // defaults to 117.0
                                            imageStd: 1.0, // defaults to 1.0
                                            numResults: 1, // defaults to 5
                                            threshold: 0.1, // defaults to 0.1
                                            asynch: true // defaults to true
                                            )
                                        .then((recognitions) {
                                      setRecognitions(recognitions!);
                                    });
                                  }
                                },
                                child: const Text('Enviar imagem'),
                                style: AppTheme.elevatedButtonStyle,
                              ),
                            ),
                          ]),
                    ))))),
        if (isDetecting)
          const ColoredBox(
            color: Colors.black45,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }

  setRecognitions(List recognitions) {
    if (recognitions.isNotEmpty) {
      recognition = Recognition.fromJson(Map<String, dynamic>.from(recognitions.first));
      setState(() {
        isDetecting = false;
      });
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => VigorResultPage(recognition: recognition)));
    }
  }
}
