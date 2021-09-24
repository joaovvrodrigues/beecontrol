// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:ionicons/ionicons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

// 🌎 Project imports:
import '../../../core/app_text_style.dart';
import '../../../shared/circular_button.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
    required this.image,
    required this.title,
    required this.date,
    required this.url,
  }) : super(key: key);
  final String image;
  final String title;
  final String date;
  final String url;

  void _launchURL() async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: _launchURL,
        child: Container(
          height: 280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: image,
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                  // alignment: Alignment.topCenter,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppTextStyle.boldTitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  date,
                                  style: AppTextStyle.boldText,
                                ),
                                CircularButton(
                                  onTap: () {
                                    Share.share('$title - $url');
                                  },
                                  icon: Ionicons.share_social_outline,
                                  iconSize: 20,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    width: double.infinity,
                    height: 125,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
