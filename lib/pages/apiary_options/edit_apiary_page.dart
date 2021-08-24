import 'package:beecontrol/models/apiary.dart';
import 'package:beecontrol/utils/constants.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/core/app_theme.dart';
import 'package:beecontrol/shared/guide_title.dart';
import 'package:beecontrol/shared/circular_button.dart';
import 'package:beecontrol/shared/custom_dropdown_field.dart';
import 'package:beecontrol/shared/custom_text_field.dart';
import 'package:provider/provider.dart';

import 'apiary_options_controller.dart';

class EditApiaryPage extends StatefulWidget {
  const EditApiaryPage({
    Key? key,
  }) : super(key: key);
  @override
  _EditApiaryPageState createState() => _EditApiaryPageState();
}

class _EditApiaryPageState extends State<EditApiaryPage> {
  final formKey = GlobalKey<FormState>();
  ApiaryOptionsController controller = ApiaryOptionsController();

  @override
  void initState() {
    controller.apiary = context.read<Apiary>();
    // controller.apiary = widget.controller.apiary.copyWith();
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
                        onTap: () => Navigator.of(context).pop(),
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
                          initialValue: controller.apiary.name,
                          icon: Ionicons.cube_outline,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          onSaved: (text) => controller.apiary =
                              controller.apiary.copyWith(name: text),
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
                                initialValue: controller.apiary.city,
                                icon: Ionicons.business_outline,
                                textCapitalization: TextCapitalization.words,
                                onSaved: (text) => controller.apiary =
                                    controller.apiary.copyWith(city: text),
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
                                child: CustomDropDownField<String>(
                                  onSaved: (text) => controller.apiary =
                                      controller.apiary.copyWith(uf: text),
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Este campo é obrigatório';
                                    }
                                  },
                                  initialValue: controller.apiary.uf,
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
                      SizedBox(height: 30),

                      // save button
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                Hive.box(CONSTANTS.box).deleteAt(controller.apiary.id);
                                // controller.update(controller.apiary);
                                // controller.apiaries = context.read<Apiaries>();
                                // controller.apiaries!.update(controller.apiary);
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text('Salvar Apiário'),
                            style: AppTheme.elevatedButtonStyle),
                      ),

                      // delete button
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            // controller.delete(controller.apiary);
                            // controller.apiaries = context.read<Apiaries>();
                            // controller.apiaries!.remove(controller.apiary.id!);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
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