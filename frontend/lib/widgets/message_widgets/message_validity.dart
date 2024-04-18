import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/* ********************************************************
        Check validity of message using Gemini API
******************************************************** */
// Future<Map<String, dynamic>> checkMessageValidity(
Future<Map<String, dynamic>> checkMessageValidity(
    String message, String role) async {
  await dotenv.load();
  print(role);
  String? geminiApiKey = dotenv.env['GEMINI_API_KEY'];

  if (geminiApiKey == null) {
    // Handle the null case here, such as providing a default value, throwing an error, or logging a message
    // For example:
    throw Exception('GEMINI_API_KEY is not set');
  }

  // remove safety settings
  final safetySettings = [
    SafetySetting(
      HarmCategory.dangerousContent,
      HarmBlockThreshold.none,
    ),
    SafetySetting(
      HarmCategory.harassment,
      HarmBlockThreshold.none,
    ),
    SafetySetting(
      HarmCategory.sexuallyExplicit,
      HarmBlockThreshold.none,
    ),
    SafetySetting(
      HarmCategory.hateSpeech,
      HarmBlockThreshold.none,
    ),
  ];

  final model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: geminiApiKey,
    safetySettings: safetySettings,
  );
  // Proceed with using the API key

  // set rules for each rule
  const teacherRules = '''These are the teacher's rules:\n
    1. Order or demand students to do something.\n
    2. Can be rude sometimes.''';

  const studentRules = '''These are the student's rules:\n
    1. Be polite to the teacher.\n
    2. Can be straightforward sometimes but not in a way that it becomes too rude.''';

  final prompt =
      '''We are making a chat app for easy communication between students and teachers. Consider that all student teacher relations are friendly. You have to tell me if the message is not aggressive, abusive or hateful. It should also not be an unacceptable relation, like romantic relations. It is ok if the message is neutral or contains emojis that don't violate the rule. Symbols and characters like '.' ',' '#' are acceptable until they are not getting used to make an unacceptable image or text. Period (.) is acceptable.\n
  $teacherRules\n $studentRules\n
  Respond only with a yes or no and then the reason in next line.
  The role field tells who is sending the message. So if role is student, then the receiever is teacher and vice versa.
  \nmessage: "$message" \nrole: $role"? \n
  The response format should be: \n
  <yes/no>\n<reason>''';

  // get response
  try {
    final result = await model.generateContent([Content.text(prompt)]);
    final response = result.text;
    final parts = response?.split(RegExp(r'\n|,|\.'));
    final isValid = parts?[0].trim().toLowerCase();
    final reason = parts!.length > 1 ? parts.sublist(1).join(' ') : '';

    if (isValid == 'no') {
      return {'message': reason, 'status': false};
    } else {
      return {'status': true};
    }
  } catch (error) {
    print('Error validating message:- \n$error');
    return {'message': 'Error checking for message validity', 'status': false};
  }
}

class MessageRule {
  final String text;

  MessageRule(this.text);
}
