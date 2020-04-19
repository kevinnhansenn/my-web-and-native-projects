// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoFeed extends StatefulWidget {
//   @override
//   _VideoFeedState createState() => _VideoFeedState();
// }

// class _VideoFeedState extends State<VideoFeed> {
//   VideoPlayerController _controller;
//   Future<void> _initializeVideoPlayerFuture;

//   @override
//   void initState() {
//     _controller = VideoPlayerController.asset(
//       'asset/videos/dribbling.mp4',
//     );

//     // Initialize the controller and store the Future for later use.
//     _initializeVideoPlayerFuture = _controller.initialize();

//     // Use the controller to loop the video.
//     _controller.setLooping(true);

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: FutureBuilder(
//         future: _initializeVideoPlayerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             // If the VideoPlayerController has finished initialization, use
//             // the data it provides to limit the aspect ratio of the video.
//             return AspectRatio(
//               aspectRatio: _controller.value.aspectRatio,
//               // Use the VideoPlayer widget to display the video.
//               child: GestureDetector(
//                 child: VideoPlayer(_controller),
//                 onTap: () {
//                   if (_controller.value.isPlaying) {
//                     setState(() {
//                       _controller.pause();
//                       print('clicked');
//                     });
//                   } else {
//                     setState(() {
//                       _controller.play();
//                     });
//                   }
//                 },
//               ),
//             );
//           } else {
//             // If the VideoPlayerController is still initializing, show a
//             // loading spinner.
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
