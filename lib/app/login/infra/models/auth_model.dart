import 'package:equatable/equatable.dart';

import '../../domain/entities/auth/auth.dart';
import '../../domain/entities/auth/auth_info.dart';

class AuthModel extends AuthEntity with EquatableMixin implements AuthInfo {
  AuthModel({
    required super.internalCode,
    required super.token,
    super.success,
  });

  @override
  List<Object?> get props => [internalCode, token, success];
}
