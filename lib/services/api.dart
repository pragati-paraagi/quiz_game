import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:quiz_assignment/models/ques_model.dart';

const baseUrl = "https://api.jsonserve.com/";

class ApiServices {
  Future<List<Question>> getQues() async {
    String endpoint = "Uw5CrX";
    final url = "$baseUrl$endpoint";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success: Fetched questions");

      // Print the response to debug the structure
      // log(response.body);

      // Decode the response as a Map<String, dynamic>
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      // Extract the list of questions from the "questions" field
      List<dynamic> questionsJson = jsonResponse['questions'];

      // Map the questions to Question model
      List<Question> questions = questionsJson.map((data) {
        return Question.fromJson(data);
      }).toList();

      return questions;
    } else {
      throw Exception("Failed to load questions");
    }
  }
}
