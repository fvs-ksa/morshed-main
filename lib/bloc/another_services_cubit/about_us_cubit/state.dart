abstract class AboutUsState{}
class InitialAboutUsState extends AboutUsState{}
class GetAboutInfoLoadingState extends AboutUsState{}
class GetAboutInfoSuccessState extends AboutUsState{}
class GetAboutInfoErrorState extends AboutUsState{
  final String error;
GetAboutInfoErrorState({required this.error});
}