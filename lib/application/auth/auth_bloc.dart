import 'package:bloc/bloc.dart';
import 'package:boilerplate/domain/repo/i_auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _repo;
  AuthBloc(this._repo) : super(_Initial()) {
    on<AuthEvent>((event, emit) async {
      await event.when(started: () async {
        await Permission.location.request().then((value) async {
          if (value.isGranted) {
            await Future.delayed(const Duration(seconds: 3));
            final resp = await _repo.checkAuth();

            emit(
              resp.fold(
                (l) => const AuthState.unauthenticated(),
                (r) => const AuthState.authenticated(),
              ),
            );
          }
          
          if(value.isPermanentlyDenied){
            openAppSettings();
          }

          if(value.isDenied){
            openAppSettings();
          }
        });
        // }
      });
    });
  }
}
