import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class UserStorege {
  static const String cloudName = "dev61pyjy";
  static const String uploadPreset = "TON_UNSIGNED_PRESET";

  Future<Map<String, dynamic>> uploadImageToCloudinary(
    Uint8List image, {
    required String folder,
    required String publicId,
  }) async {
    final uri = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");

    final request = http.MultipartRequest("POST", uri)
      ..fields["upload_preset"] = uploadPreset
      ..fields["folder"] = folder
      ..fields["public_id"] = publicId
      ..files.add(
        http.MultipartFile.fromBytes(
          "file",
          image,
          filename: "$publicId.jpg",
        ),
      );

    final response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Cloudinary upload failed: ${response.statusCode} $body");
    }

    return jsonDecode(body) as Map<String, dynamic>;
  }
}