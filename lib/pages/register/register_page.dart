import '../../core/app_images.dart';
import '../../core/app_text_style.dart';
import '../../core/app_theme.dart';
import '../../models/user_model.dart';
import '../../shared/custom_checkboxtile.dart';
import '../../shared/custom_dropdown_field.dart';
import '../../shared/custom_text_field.dart';
import '../../shared/guide_title.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  var user = UserModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            // appBar: PreferredSize(
            //   preferredSize: Size.fromHeight(55.0),
            //   child: Padding(
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 20),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           CircularButton(onTap: () {}, icon: Ionicons.reorder_two_outline),
            //           Text('Página Inicial', style: AppTextStyle.boldTitle),
            //           CircularButton(onTap: () {}, icon: Ionicons.search_outline)
            //         ],
            //       )),
            // ),
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
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                AppImages.logo,
                                height: 125,
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  'INFORME SEUS DADOS',
                                  style: AppTextStyle.boldTitle.copyWith(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            const GuideTitle(
                                icon: Ionicons.person_add,
                                title: 'Meus Dados:'),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: CustomFormField(
                                hintText: 'Nome',
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
                                icon: Ionicons.call_outline,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  TelefoneInputFormatter(),
                                ],
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
                            const GuideTitle(
                                icon: Ionicons.home,
                                title: 'End. Residencial:'),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5, right: 5),
                                    child: CustomFormField(
                                      hintText: 'Cidade',
                                      icon: Ionicons.business_outline,
                                      textCapitalization:
                                          TextCapitalization.words,
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
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5, left: 5),
                                      child: CustomDropDownField<String>(
                                        onSaved: (text) =>
                                            user = user.copyWith(uf: text),
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'Este campo é obrigatório';
                                          }
                                        },
                                        hintText: 'UF',
                                        icon: Ionicons.business_outline,
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
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: CustomFormField(
                                hintText: 'Rua',
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
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5, right: 5),
                                    child: CustomFormField(
                                      hintText: 'Bairro',
                                      icon: Ionicons.home_outline,
                                      textCapitalization:
                                          TextCapitalization.words,
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
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5, left: 5),
                                    child: CustomFormField(
                                      hintText: 'Número',
                                      // icon: Ionicons.home_outline,
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
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                children: [
                                  CustomCheckBox(
                                      contentPadding: const EdgeInsets.all(0),
                                      value: true,
                                      title: 'Manter conectado',
                                      onChanged: (value) {}),
                                  CustomCheckBox(
                                      contentPadding: const EdgeInsets.all(0),
                                      value: true,
                                      title:
                                          'Desejo receber notícias pelo e-mail',
                                      onChanged: (value) {})
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                  }
                                  // print(user.toString());
                                },
                                child: const Text('Criar Conta'),
                                style: AppTheme.elevatedButtonStyle,
                              ),
                            ),
                          ]),
                    ))))));
  }
}
