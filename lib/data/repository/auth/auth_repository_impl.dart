import 'dart:convert';

import 'package:education_app/common/constants/constants.dart';
import 'package:education_app/common/error/failure.dart';
import 'package:education_app/data/local/shared_preference.dart';
import 'package:education_app/data/network/payload/auth/login_be_payload.dart';
import 'package:education_app/data/network/payload/auth/sign_up_payload.dart';
import 'package:education_app/data/network/response/auth/tokens_response.dart';
import 'package:education_app/data/network/retrofit_api.dart';
import 'package:education_app/domain/model/user/user.dart';
import 'package:education_app/domain/repository/auth/auth_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient supabase;
  final RestClient api;
  final MySharedPreference sp;
  AuthRepositoryImpl({
    required this.supabase,
    required this.api,
    required this.sp,
  });

  @override
  Future<void> signOut() async {
    await supabase.auth.signOut();
    sp.clearData(Constants.sharedPreferencesKey.user);
    sp.clearData(Constants.sharedPreferencesKey.accessToken);
    sp.clearData(Constants.sharedPreferencesKey.refreshToken);
    sp.clearData(Constants.sharedPreferencesKey.courseProgress);
  }

  @override
  Future<Either<Failure, UserModel>> createUserWithEmailPassword(
      {required String email, required String password}) async {
    final fullName = email.split("@").first;
    final AuthResponse res =
        await supabase.auth.signUp(email: email, password: password, data: {
      'fullName': fullName,
      'profileImageUrl': '',
    });
    User? user = res.user;
    if (user == null) {
      return left(Failure('Failed to register'));
    }

    // Pass to backend
    final signUpPayload =
        SignUpPayload(id: user.id, email: user.email ?? "", fullName: fullName);
    final tokens = await api.signUp(signUpPayload);
    await _saveTokens(tokens);
    final userModel = UserModel(
      id: user.id,
      fullName: fullName,
      email: email,
      isOnboardingCompleted: false,
    );
    _cacheUser(userModel);
    return right(userModel);
  }

  @override
  Future<Either<Failure, UserModel>> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      User? user = res.user;
      if (user == null) {
        return left(Failure("Failed to login"));
      }
      final UserModelWithAccessToken userRes =
          await api.signIn(LoginBEPayload(userId: user.id));
      _cacheUser(userRes.toUserModel());
      final tokens = TokensResponse(
          accessToken: userRes.accessToken, refreshToken: userRes.refreshToken);
      await _saveTokens(tokens);

      return right(userRes.toUserModel());
    } on AuthException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  _cacheUser(UserModel user) async {
    await sp.saveData(
        key: Constants.sharedPreferencesKey.user, data: jsonEncode(user));
  }

  _saveTokens(TokensResponse tokens) async {
    sp.saveData(
      key: Constants.sharedPreferencesKey.accessToken,
      data: tokens.accessToken,
    );
    sp.saveData(
      key: Constants.sharedPreferencesKey.refreshToken,
      data: tokens.refreshToken,
    );
  }
}
