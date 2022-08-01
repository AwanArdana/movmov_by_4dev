// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:movmov/constants.dart';
//
// class PlayerDetail extends StatelessWidget{
//   const PlayerDetail({
//     Key key,
//     this.url,
//     this.size,
//   }) : super(key: key);
//
//   final String url;
//   final Size size;
//   bool status;
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: size.height * 0.3,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               offset: Offset(0, 20),
//               blurRadius: 50,
//               color: kPrimaryColor.withOpacity(0.33),
//             )
//           ]
//       ),
//       child: Expanded(
//         child: InAppWebView(
//           initialUrlRequest: URLRequest(
//               url: Uri.parse(Url)
//           ),
//           initialOptions: _options,
//           onWebViewCreated: (InAppWebViewController controller){
//             webView = controller;
//           },
//           onLoadStart: (InAppWebViewController controller, Url){
//             status = false;
//           },
//           onLoadStop: (InAppWebViewController controller, Url){
//             status = true;
//           },
//         ),
//       ),
//     ),
//   }}