import 'package:jaguar_serializer/jaguar_serializer.dart';

class SanitizeUrlProcessor implements FieldProcessor<String, String> {
  const SanitizeUrlProcessor();
  @override
  String serialize(String value) {
    return value;
  }

  @override
  String deserialize(String value) {
    if (value.isEmpty) return value;

    final uri = Uri.parse(value);
    if (uri.host.isEmpty) {
      print('Url was invalid!');
      return '';
    }

    return value;
  }
}
