import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quotes_flutter/business_logic/business_logic.dart';
import 'package:share/share.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({super.key});

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  final BusinessLogicController controller = Get.put(BusinessLogicController());

  @override
  void initState() {
    super.initState();
    controller.loadQuote(); // Load the initial quote
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFD3D3D3), // startColor
              Color(0xFF0B0B0B), // endColor
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Obx(() {
                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.9,
                        maxHeight: MediaQuery.of(context).size.height * 0.7,
                        minHeight: 200,
                        minWidth: MediaQuery.of(context).size.width * 0.8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.format_quote,
                                size: 50,
                                color: Colors.black54,
                              ),
                              widgetCustom(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            Container(
              width: 200,
              padding: const EdgeInsets.all(16.0),
              child:GestureDetector(
                onTap: controller.loadQuote,
                child: const Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                       Text('NEXT', style: TextStyle(color: Colors.white)),
                      const SizedBox(width: 10),
                       Icon(Icons.arrow_forward_ios_sharp, color: Colors.white),

                    ],
                  ),
              ),
            ),
            SizedBox(height: 40)
          ],
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       ElevatedButton(
      //         onPressed: controller.loadQuote,
      //         child: Text('NEXT'),
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: Colors.black54, // Background color
      //           // : Colors.white, // Text color
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(8.0),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget widgetCustom() {
    if (controller.isLoading.value) {
      return Container(
        alignment: Alignment.center,
        height: 200,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: 100, width: 100, child: CircularProgressIndicator()),
          ],
        ),
      );
    } else if (controller.errorMessage.value.isNotEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error, size: 50, color: Colors.red),
          SizedBox(height: 20),
          Text(
            '${controller.errorMessage.value}',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),

        ],
      );
    } else if (controller.quote.value.isEmpty) {
      return const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error, size: 50, color: Colors.red),
          SizedBox(height: 20),
          Text(
            'No quote available',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.quote.value,
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 20),
        Text('${controller.author.value}',
            style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  Share.share(
                      '${controller.quote.value} - ${controller.author.value}');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
