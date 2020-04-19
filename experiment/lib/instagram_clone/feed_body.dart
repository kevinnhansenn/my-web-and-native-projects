import 'package:flutter/material.dart';
import './top-profile.dart';
import './feed.dart';
import './image_slider.dart';
// import './video_feed.dart';

List<Map<String, String>> topProfile = [
  {'name': 'person1', 'url': 'asset/photos/person1.jpg'},
  {'name': 'person2', 'url': 'asset/photos/person2.jpg'},
  {'name': 'person3', 'url': 'asset/photos/person3.jpg'},
  {'name': 'person4', 'url': 'asset/photos/person4.jpg'},
  {'name': 'person5', 'url': 'asset/photos/person5.jpg'},
  {'name': 'person7', 'url': 'asset/photos/person7.jpg'},
];

List<String> dashboard = [
  'asset/photos/dashboard1.jpg',
  'asset/photos/dashboard2.jpg'
];

List<Widget> listOfWidges = [
  ImageSlider(dashboard),
  ImageSlider(dashboard),
  // VideoFeed(),
];

class FeedBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
          height: 100,
          padding: EdgeInsets.only(left: 6, top: 11),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              TopProfile('Your Story', 'asset/photos/YourStory.jpg', true),
              ...topProfile.map((data) {
                return TopProfile(data['name'], data['url'], false);
              })
            ],
          ),
        ),
        ...listOfWidges.map((widget) {
          return Feed(widget);
        })
        // Feed(),
      ],
    );
  }
}
