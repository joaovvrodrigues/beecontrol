import 'package:beecontrol/pages/apiary_report/apiary_page.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:beecontrol/models/apiary.dart';

class ApiariesCard extends StatelessWidget {
  const ApiariesCard({
    Key? key,
    required this.apiary,
  }) : super(key: key);

  final Apiary apiary;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        // Apiary api = context.read<Apiary>();
        // api.updateProvider(apiary);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ApiaryPage(id: apiary.id)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: apiary.image ??
                    'https://thumbs.dreamstime.com/b/hives-bees-apiaries-outskirts-forest-hives-bees-apiaries-outskirts-forest-126420117.jpg',
                fit: BoxFit.cover,
                height: 50,
                width: 50,
                // alignment: Alignment.topCenter,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      apiary.name,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text('${apiary.city}, ${apiary.uf}'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Ionicons.chevron_forward_outline,
                size: 12,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Text('#${apiary.id}'),
            // )
          ],
        ),
      ),
    );
  }
}
