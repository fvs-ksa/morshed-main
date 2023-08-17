import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshed/bloc/profile_cubit/cubit.dart';
import 'package:morshed/bloc/profile_cubit/state.dart';
import '../../component/animation_component.dart';
import '../../component/guide_escorts_component.dart';
import '../../tranlations/locale_keys.g.dart';

class MyCardScreen extends StatelessWidget {
  const MyCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileCubit=ProfileCubit.get(context);
    return BlocConsumer<ProfileCubit,ProfileState>(
      listener: (context,state){},
      builder: (context,state) {
        return Scaffold(
          appBar: headerOfTechnicalSupport(
              context: context, title: LocaleKeys.myCard.tr()),
          body:state is GetProfileLoadingState?Center(child: CircularProgressIndicator(),): Column(
            children: [
              cardIdWidget(model: profileCubit.profileModel, context: context),
            ],
          ),
        );
      }
    );
  }
}
