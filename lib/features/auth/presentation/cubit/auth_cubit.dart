import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tanitama/features/auth/domain/entities/user.dart';
import 'package:tanitama/features/auth/domain/usecases/auth_login.dart';
import 'package:tanitama/features/auth/domain/usecases/auth_logout.dart';
import 'package:tanitama/features/auth/domain/usecases/auth_register.dart';
import 'package:tanitama/features/auth/domain/usecases/get_token.dart';
import 'package:tanitama/features/auth/domain/usecases/save_token.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
      {required this.authLogin,
      required this.authRegister,
      required this.authLogout,
      required this.getToken,
      required this.saveToken})
      : super(UnlogedState());

  final AuthLogin authLogin;
  final AuthRegister authRegister;
  final AuthLogout authLogout;
  final GetToken getToken;
  final SaveToken saveToken;

  void login(User user) async {
    emit(LoadingAuthState());

    final result = await authLogin.execute(user);
    result.fold((failure) {
      emit(AuthErrorState(failure.message));
    }, (data) async {
      await saveToken.execute(data);
      emit(LogedState());
    });
  }

  void register(User user) async {
    emit(LoadingAuthState());

    final result = await authRegister.execute(user);

    print(result);

    result.fold((failure) {
      emit(AuthErrorState(failure.message));
    }, (data) async {
      await saveToken.execute(data);
      emit(LogedState());
    });
  }

  void logout() async {
    emit(LoadingLogoutState());

    final result = await authLogout.execute();

    result.fold((failure) {
      emit(AuthErrorState(failure.message));
    }, (data) async {
      await authLogout.execute();
      emit(UnlogedState());
    });
  }

  void checkLoginState() async {
    final result = await getToken.execute();

    if (result != null) {
      emit(LogedState());
    } else {
      emit(UnlogedState());
    }
  }
}
