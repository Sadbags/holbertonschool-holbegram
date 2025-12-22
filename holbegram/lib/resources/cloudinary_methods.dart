import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class CloudinaryMethods {
  static const String cloudName = "dev61pyjy";

  static const String uploadPreset = "holbegram_unsigned";

  Future<String> uploadPostImage(Uint8List bytes) async {
    final uri = Uri.parse(
      "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
    );

    final request = http.MultipartRequest("POST", uri)
      ..fields["upload_preset"] = uploadPreset
      ..fields["folder"] = "holbegram/posts"
      ..files.add(
        http.MultipartFile.fromBytes(
          "file",
          bytes,
          filename: "post.jpg",
        ),
      );

    final response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Cloudinary upload failed: ${response.statusCode} $body");
    }

    final data = jsonDecode(body);
    return data["secure_url"] as String;
  }
}
