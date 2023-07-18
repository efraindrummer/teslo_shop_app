
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';

import '../../../shared/infrastructure/services/key_value_storage_services.dart';
import '../../../shared/infrastructure/services/key_value_storage_services_impl.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {

  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();
  
  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService
  );
});

class AuthNotifier extends StateNotifier<AuthState> {

  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService
  }): super(AuthState());

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e){
      logout('Error no controlado');
    }
    //final user = await authRepository.login(email, password);
    //state = state.copyWth(user: user, authStatus: AuthStatus.authenticated)
  }

  void registerUser(String email, String password) async {
    
  }

  void chekAuthStatus() async {
    
  }

  void _setLoggedUser(User user) async {
    //save token
    await keyValueStorageService.setKeyValue('token', user.token);

    state = state.copyWth(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> logout([String? errorMessage]) async {
    //limpiar token
    await keyValueStorageService.removeKey('token');

    state = state.copyWth(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage
    );
  }
  
}

enum AuthStatus{ checking, authenticated, notAuthenticated }

class AuthState {

  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking, 
    this.user, 
    this.errorMessage = ''
  });

  AuthState copyWth({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage 
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage
  );
}