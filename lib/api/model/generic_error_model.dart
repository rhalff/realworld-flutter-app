import 'package:jaguar_serializer/jaguar_serializer.dart';
import 'package:realworld_flutter/api/model/generic_error_model_errors.dart';

part 'generic_error_model.jser.dart';

class GenericErrorModel {
  @Alias('errors', isNullable: false)
  final GenericErrorModelErrors errors;

  GenericErrorModel({
    this.errors,
  });

  @override
  String toString() {
    return 'GenericErrorModel[errors=$errors]';
  }
}

@GenSerializer(nullableFields: true)
class GenericErrorModelSerializer extends Serializer<GenericErrorModel>
    with _$GenericErrorModelSerializer {}
