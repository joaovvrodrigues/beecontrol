import 'package:beecontrol/models/apiary.dart';
import 'package:beecontrol/models/hive.dart';
import 'package:beecontrol/models/report.dart';

List<String> manejo = [
    'Alimentação',
    'Limpeza',
    'Colheita de Mel',
    'Colheita de Própolis',
    'Divisão de Enxame',
    'Instalar Suportes',
    'Outro'
  ];



  List<Apiary> apiaries = [
    Apiary(
        city: 'Bambuí',
        uf: 'MG',
        numHives: 0,
        name: 'Apiário Santa Clara',
        hives: [],
        reports: []),
    Apiary(
        city: 'Bambuí',
        uf: 'MG',
        numHives: 3,
        name: 'Apiário Lagoinha',
        lastVisit: DateTime.now(),
        orphanBoxes: 1,
        visits: 3,
        reports: [
          Report(
              date: DateTime(2021, 11, 12, 10, 30),
              numHives: 5,
              orphanBoxes: 2,
              resume: ['Alimentação', 'Colheita de Mel', 'Colheita de Própolis'],
              name: 'Ficha de Controle 1'),
          Report(
              date: DateTime(2021, 12, 10, 10, 30),
              numHives: 6,
              orphanBoxes: 1,
              resume: ['Limpeza', 'Instalar Suportes', 'Colheita de Mel'],
              name: 'Ficha de Controle 2'),
          Report(
              date: DateTime.now(),
              numHives: 5,
              orphanBoxes: 0,
              resume: ['Divisão de Enxame', 'Colheita de Mel'],
              name: 'Ficha de Controle 3'),
        ],
        hives: [
          Hive(
              name: 'Colméia 1',
              situation: ['Alimentar', 'Coletar Mel'],
              production: ['Instalar Suporte']),
          Hive(
              name: 'Colméia 2',
              situation: [],
              production: ['Instalar Suporte'],
              orphan: true,
              motherHive: 1,
              dateOrphan: DateTime(2021, 02, 12, 12, 30)),
          Hive(
              name: 'Colméia 3',
              situation: ['Alimentar', 'Coletar Mel'],
              production: ['Instalar Suporte']),
        ])
  ];



  List<Report> reports = [
      Report(
              date: DateTime(2021, 11, 12, 10, 30),
              numHives: 5,
              orphanBoxes: 2,
              resume: ['Alimentação', 'Colheita de Mel', 'Colheita de Própolis'],
              name: 'Ficha de Controle 1'),
          Report(
              date: DateTime(2021, 12, 10, 10, 30),
              numHives: 6,
              orphanBoxes: 1,
              resume: ['Limpeza', 'Instalar Suportes', 'Colheita de Mel'],
              name: 'Ficha de Controle 2'),
          Report(
              date: DateTime.now(),
              numHives: 5,
              orphanBoxes: 0,
              resume: ['Divisão de Enxame', 'Colheita de Mel'],
              name: 'Ficha de Controle 3'),
  ];

  List<Hive> hives = [
    Hive(
        name: 'Colméia 1',
        situation: ['Alimentar', 'Coletar Mel'],
        production: ['Instalar Suporte']),
    Hive(
        name: 'Colméia 2',
        situation: [],
        production: ['Instalar Suporte'],
        orphan: true,
        motherHive: 1,
        dateOrphan: DateTime(2021, 02, 12, 12, 30))
  ];