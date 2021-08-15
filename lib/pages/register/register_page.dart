import 'package:beecontrol/core/app_images.dart';
import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/core/app_theme.dart';
import 'package:beecontrol/models/user_model.dart';
import 'package:beecontrol/shared/custom_dropdown_field.dart';
import 'package:beecontrol/shared/custom_text_field.dart';
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
            //   preferredSize: Size.fromHeight(80.0),
            //   child: Padding(
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           CircularButton(onTap: () {}, icon: Icons.menu_rounded),
            //           Text('Página Inicial', style: AppTextStyle.boldTitle),
            //           CircularButton(onTap: () {}, icon: Icons.search_rounded)
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
                                height: 150,
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
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Ionicons.home,
                                        size: 15, color: AppTheme.eclipse),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'End. Residencial:',
                                      style: AppTextStyle.boldText,
                                    ),
                                  ),
                                ],
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
                                      child: CustomDropDownField(
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
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: Column(
                                children: [
                                  CheckboxListTile(
                                    value: true,
                                    onChanged: (value) {},
                                    title: Text('Manter conectado'),
                                    checkColor: AppTheme.eclipse,
                                  ),
                                  CheckboxListTile(
                                    value: true,
                                    onChanged: (value) {},
                                    title: Text(
                                        'Desejo receber notícias pelo e-mail'),
                                    checkColor: AppTheme.eclipse,
                                  ),
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
                                  print(user.toString());
                                },
                                child: Text('Criar Conta'),
                                style: AppTheme.elevatedButtonStyle,
                              ),
                            ),
                          ]),
                    ))))));
  }
}
