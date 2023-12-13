import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nd/data/repository/authen_repository.dart';
import 'package:flutter_nd/presentation/blocs/authen_bloc/authen_event.dart';
import 'package:flutter_nd/presentation/blocs/authen_bloc/authen_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(Unauthenticated()) {
    on<SignInRequested>((event, emit) async {
      try {
        await _authRepository.signIn(event.email, event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignUpRequested>((event, emit) async {
      try {
        await _authRepository.signUp(event.email, event.password, event.name, event.phone, event.country);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignOutRequested>((event, emit) async {
      await _authRepository.signOut();
      emit(Unauthenticated());
    });
  }
}