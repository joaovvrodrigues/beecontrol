import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/models/user_model.dart';
import 'package:beecontrol/shared/circular_button.dart';
import 'package:beecontrol/shared/custom_text_field.dart';
import 'package:beecontrol/shared/guide_title.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final formKey = GlobalKey<FormState>();
  var user = UserModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircularButton(onTap: () {}, icon: Icons.menu_rounded),
                      Text('Minhas Configurações',
                          style: AppTextStyle.boldTitle),
                      SizedBox(width: 35)
                    ],
                  )),
            ),
            body: Form(
                key: formKey,
                child: SingleChildScrollView(
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
                            GuideTitle(
                                icon: Ionicons.person_add,
                                title: 'Meus Dados:'),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: CustomFormField(
                                hintText: 'Nome',
                                readOnly: true,
                                initialValue: 'Hudson Teles Camilo',
                                icon: Ionicons.person_outline,
                                keyboardType: TextInputType.name,
                                textCapitalization: TextCapitalization.words,
                                onSaved: (text) =>
                                    user = user.copyWith(name: text),
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
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: CustomFormField(
                                hintText: 'Telefone',
                                initialValue: '(32) 99174-1331',
                                obscureText: true,
                                icon: Ionicons.call_outline,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  TelefoneInputFormatter(),
                                ],
                                readOnly: true,
                                onSaved: (text) =>
                                    user = user.copyWith(phone: text),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Este campo é obrigatório';
                                  }
                                  if (text.length != 15) {
                                    return 'Este campo deve conter 11 caracteres';
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: CustomFormField(
                                hintText: 'CPF',
                                readOnly: true,
                                initialValue: '126.271.446-00',
                                obscureText: true,
                                icon: Ionicons.lock_closed_outline,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CpfInputFormatter(),
                                ],
                                onSaved: (text) =>
                                    user = user.copyWith(cpf: text),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Este campo é obrigatório';
                                  }
                                  if (text.length != 14) {
                                    return 'Este campo deve conter 11 caracteres';
                                  }
                                  if (!CPFValidator.isValid(text)) {
                                    return 'Este CPF é inválido';
                                  }
                                },
                              ),
                            ),
                            GuideTitle(
                                icon: Ionicons.home,
                                title: 'End. Residencial:'),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: CustomFormField(
                                hintText: 'Rua',
                                initialValue: 'Rua Dr. Mario Campos',
                                readOnly: true,
                                icon: Ionicons.home_outline,
                                textCapitalization: TextCapitalization.words,
                                onSaved: (text) =>
                                    user = user.copyWith(street: text),
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
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: CustomFormField(
                                hintText: 'Bairro',
                                initialValue: 'Centro',
                                readOnly: true,
                                icon: Ionicons.home_outline,
                                textCapitalization: TextCapitalization.words,
                                onSaved: (text) =>
                                    user = user.copyWith(district: text),
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
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5, right: 5),
                                    child: CustomFormField(
                                      hintText: 'Número',
                                      initialValue: '69',
                                      readOnly: true,
                                      icon: Ionicons.home_outline,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onSaved: (text) => user = user.copyWith(
                                          number: int.parse(text!)),
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Este campo é obrigatório';
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5, left: 5),
                                    child: CustomFormField(
                                      hintText: 'UF',
                                      initialValue: 'MG',
                                      readOnly: true,
                                      icon: Ionicons.business_outline,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onSaved: (text) => user = user.copyWith(
                                          number: int.parse(text!)),
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'Este campo é obrigatório';
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: CustomFormField(
                                hintText: 'Cidade',
                                initialValue: 'Bambuí',
                                readOnly: true,
                                icon: Ionicons.business_outline,
                                textCapitalization: TextCapitalization.words,
                                onSaved: (text) =>
                                    user = user.copyWith(city: text),
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
                          ]),
                    ))))));
  }
}
