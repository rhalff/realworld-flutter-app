// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_error_model.dart';

// **************************************************************************
// JaguarSerializerGenerator
// **************************************************************************

abstract class _$GenericErrorModelSerializer
    implements Serializer<GenericErrorModel> {
  Serializer<GenericErrorModelErrors> __genericErrorModelErrorsSerializer;
  Serializer<GenericErrorModelErrors> get _genericErrorModelErrorsSerializer =>
      __genericErrorModelErrorsSerializer ??=
          GenericErrorModelErrorsSerializer();
  @override
  Map<String, dynamic> toMap(GenericErrorModel model) {
    if (model == null) return null;
    Map<String, dynamic> ret = <String, dynamic>{};
    setMapValueIfNotNull(
        ret, 'errors', _genericErrorModelErrorsSerializer.toMap(model.errors));
    return ret;
  }

  @override
  GenericErrorModel fromMap(Map map) {
    if (map == null) return null;
    final obj = GenericErrorModel(
        errors:
            _genericErrorModelErrorsSerializer.fromMap(map['errors'] as Map) ??
                getJserDefault('errors'));
    return obj;
  }
}
