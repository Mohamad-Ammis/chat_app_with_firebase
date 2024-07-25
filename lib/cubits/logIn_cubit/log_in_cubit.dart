import 'package:bloc/bloc.dart';
import 'package:chatapp/cubits/logIn_cubit/log_in_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial());
  Future<void> logInUser(
      {required String email, required String password}) async {
    emit(LogInLoading());
    try {
      // ignore: unused_local_variable
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LogInSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LogInFailure(errMsg: 'user-not-found'));
      } else if (e.code == 'wrong-password') {
        emit(LogInFailure(errMsg: 'wrong-password'));
      }
    } catch (e) {
      emit(LogInFailure(errMsg: "Something Went Wrong"));
    }
  }
}
// listener: (context, state) {
//         if(state is LogInLoading){
//           isLoading=true;
//         }
//         else if(state is LogInSuccess){
//           Navigator.pushNamed(context,ChatPage.id);
//         }
//         else if(state is LogInFailure){
//           showSnackBar(context, 'message');
//         }
//       },
  //   Navigator.pushNamed(context, ChatPage.id,
                        //       arguments: email);
                        //   showSnackBar(context, 'logIn Success');
                        // } on FirebaseAuthException catch (e) {
                        //   if (e.code == 'user-not-found') {
                        //     showSnackBar(context, 'User Not Found');
                        //   } else if (e.code == 'wrong-password') {
                        //     showSnackBar(context, "Wrong password");
                        //   }
                        // } catch (e) {
                        //   showSnackBar(context, e.toString());
                        // }
                        // isLoading = false;