import 'package:bloc/bloc.dart';
import 'package:chatapp/cubits/register_cubit/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> registerUser({required String email,required  String password}) async {
    emit(RegisterLoading());
    try {
    // ignore: unused_local_variable
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
        emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errMsg:'weak-password' ));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(errMsg: 'email-already-in-use'));
      }
    } catch (e) {
     emit(RegisterFailure(errMsg: e.toString()));
      }
  }
}
