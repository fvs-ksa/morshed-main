import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshed/bloc/account_type_cubit/state.dart';

class AccountTypeCubit extends Cubit<AccountTypeState> {
  AccountTypeCubit() : super(InitialAccountTypeState());

  static AccountTypeCubit get(context) => BlocProvider.of(context);
  bool isUmrah = false;
  bool isHajji = false;

  changeMotamer({var value}) {
    if (isUmrah = true) {
      isUmrah = value;
    }
    isHajji = false;
    emit(ChangeAccountTypeUmrahState());
    print('UMRAH: $isUmrah');
    print('isHijji: $isHajji');
  }

  changeHajji({var value}) {
    if (isHajji = true) {
      isHajji = value;
    }
    isUmrah = false;
    emit(ChangeAccountTypeHajjiState());
    print('hijji: $isHajji');
    print('isUMRAH: $isUmrah');
  }
}
