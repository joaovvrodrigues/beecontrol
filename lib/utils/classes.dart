import 'package:beecontrol/models/apiary.dart';
import 'package:beecontrol/models/bee_hive.dart';
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
      id: '0',
      city: 'Bambuí',
      uf: 'MG',
      name: 'Apiário Santa Clara',
      hives: [],
      reports: []),
  Apiary(
      id: '1',
      city: 'Bambuí',
      uf: 'MG',
      name: 'Apiário Lagoinha',
      lastVisit: DateTime.now(),
      orphanBoxes: 1,
      visits: 3,
      reports: [
        Report(
            date: DateTime(2021, 06, 12, 10, 30),
            numHives: 5,
            orphanBoxes: 2,
            resume: ['Alimentação', 'Colheita de Mel', 'Colheita de Própolis'],
            name: 'Ficha de Controle 1'),
        Report(
            beePasture: 0,
            date: DateTime(2021, 07, 10, 10, 30),
            numHives: 6,
            orphanBoxes: 1,
            resume: ['Limpeza', 'Instalar Suportes', 'Colheita de Mel'],
            name: 'Ficha de Controle 2'),
        Report(
            beePasture: 2,
            date: DateTime.now(),
            numHives: 5,
            orphanBoxes: 0,
            resume: ['Divisão de Enxame', 'Colheita de Mel'],
            name: 'Ficha de Controle 3',
            comments:
                "Do you see any Teletubbies in here? Do you see a slender plastic tag clipped to my shirt with my name printed on it? Do you see a little Asian child with a blank expression on his face sitting outside on a mechanical helicopter that shakes when you put quarters in it? No? Well, that's what you see at a toy store. And you must think you're in a toy store, because you're here shopping for an infant named Jeb."),
      ],
      hives: [
        BeeHive(
            name: 'Colméia 1',
            situation: ['Alimentar', 'Coletar Mel'],
            production: ['Instalar Suporte']),
        BeeHive(
            name: 'Colméia 2',
            situation: [],
            production: ['Instalar Suporte'],
            orphan: true,
            motherHive: 1,
            dateOrphan: DateTime(2021, 02, 12, 12, 30)),
        BeeHive(
            name: 'Colméia 3',
            situation: ['Alimentar', 'Coletar Mel'],
            production: ['Instalar Suporte']),
      ])
];

List<Report> reports = [
  Report(
      date: DateTime(2021, 06, 12, 10, 30),
      numHives: 5,
      orphanBoxes: 2,
      resume: ['Alimentação', 'Colheita de Mel', 'Colheita de Própolis'],
      name: 'Ficha de Controle 1'),
  Report(
      date: DateTime(2021, 07, 10, 10, 30),
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

List<BeeHive> hives = [
  BeeHive(
      name: 'Colméia 1',
      situation: ['Alimentar', 'Coletar Mel'],
      production: ['Instalar Suporte']),
  BeeHive(
      name: 'Colméia 2',
      situation: [],
      production: ['Instalar Suporte'],
      orphan: true,
      motherHive: 1,
      dateOrphan: DateTime(2021, 02, 12, 12, 30))
];
