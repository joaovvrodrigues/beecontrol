import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';
import 'package:beecontrol/core/app_text_style.dart';
import 'package:beecontrol/shared/circular_button.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      onTap: _launchURL,
      child: Container(
        height: 280,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(
                image,
              ),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            )),
        child: Column(
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
                            icon: Icons.share_rounded,
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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
