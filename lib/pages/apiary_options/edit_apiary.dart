import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/core/app_theme.dart';
import 'package:beecontrol/models/apiary.dart';
import 'package:beecontrol/shared/guide_title.dart';
import 'package:beecontrol/shared/circular_button.dart';
import 'package:beecontrol/shared/custom_dropdown_field.dart';
import 'package:beecontrol/shared/custom_text_field.dart';
import 'package:provider/provider.dart';

class EditApiaryPage extends StatefulWidget {
  const EditApiaryPage({
    Key? key,
  }) : super(key: key);
  @override
  _EditApiaryPageState createState() => _EditApiaryPageState();
}

class _EditApiaryPageState extends State<EditApiaryPage> {
  final formKey = GlobalKey<FormState>();
  var apiary = Apiary(hives: [], reports: []);

  @override
  void initState() {
    apiary = context.read<Apiary>();
    // apiary = widget.apiary.copyWith();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55.0),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            print(apiary.toString());
                            Navigator.of(context).pop();
                          }
                        },
                        icon: Ionicons.chevron_back_outline),
                    Text('Editar Apiário', style: AppTextStyle.boldTitle),
                    const SizedBox(width: 35, height: 35)
                  ],
                )),
          ),
          body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
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
                      // apiary name input
                      GuideTitle(
                          icon: Ionicons.cube_outline,
                          title: 'Nome do apiário:'),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: CustomFormField(
                          hintText: 'Nome',
                          initialValue: apiary.name,
                          icon: Ionicons.cube_outline,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          onSaved: (text) =>
                              apiary = apiary.copyWith(name: text),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Este campo é obrigatório';
                            }
                            if (text.length < 3) {
                              return 'Este campo deve conter mais de 3 caracteres';
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 10),

                      // apiary address input
                      GuideTitle(
                          icon: Ionicons.business_outline,
                          title: 'Endereço do Apiário:'),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, right: 5),
                              child: CustomFormField(
                                hintText: 'Cidade',
                                initialValue: apiary.city,
                                icon: Ionicons.business_outline,
                                textCapitalization: TextCapitalization.words,
                                onSaved: (text) =>
                                    apiary = apiary.copyWith(city: text),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Este campo é obrigatório';
                                  }
                                  if (text.length < 3) {
                                    return 'Este campo deve conter mais de 3 caracteres';
                                  }
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 5, left: 5),
                                child: CustomDropDownField(
                                  onSaved: (text) =>
                                      apiary = apiary.copyWith(uf: text),
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Este campo é obrigatório';
                                    }
                                  },
                                  initialValue: apiary.uf,
                                  hintText: 'UF',
                                  // icon: Ionicons.business_outline,
                                  items: Estados.listaEstadosSigla
                                      .map((String uf) {
                                    return DropdownMenuItem(
                                      value: uf,
                                      child: Text(uf),
                                    );
                                  }).toList(),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      // apiary image input
                      GuideTitle(
                          icon: Ionicons.image_outline,
                          title: 'Adicione uma foto:'),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image:
                              'https://thumbs.dreamstime.com/b/hives-bees-apiaries-outskirts-forest-hives-bees-apiaries-outskirts-forest-126420117.jpg',
                          fit: BoxFit.cover,
                          height: 150,
                          width: double.infinity,
                          // alignment: Alignment.topCenter,
                        ),
                      ),
                      SizedBox(height: 10),

                      // register button
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: ElevatedButton(
                          onPressed: () {
                            print('Excluir');
                          },
                          child: Text('Excluir Apiário'),
                          style: AppTheme.elevatedButtonStyle.copyWith(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppTheme.monalisa)),
                        ),
                      ),
                    ],
                  ),
                )),
              ))),
    );
  }
}
