import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quotes_flutter/constants/constants.dart';
import 'package:quotes_flutter/model/quotes_model.dart';
import 'dart:convert';

class BusinessLogicController extends GetxController {
  var quote = ''.obs;
  var author = ''.obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  void loadQuote() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await http.get(
          Uri.parse("https://api.quotable.io/random"));

          if (response.statusCode == 200)
      {
        final data = json.decode(response.body);
        final fetchedQuote = Quote.fromJson(data);
        quote.value = fetchedQuote.content;
        author.value = fetchedQuote.author;
        isLoading.value = false;
      } else {
    throw Exception('Failed to load quote');
    }
    } catch (e) {
    isLoading.value = false;
    errorMessage.value = 'An error occurred: $e';
    }
  }
}
