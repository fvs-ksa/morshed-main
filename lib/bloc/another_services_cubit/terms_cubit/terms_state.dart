abstract class TermsState{}
class InitialTermsState extends TermsState{}
class GetTermsLoadingState extends TermsState{}
class GetTermsSuccessState extends TermsState{}
class GetTermsErrorState extends TermsState{
  final String error;
  GetTermsErrorState({required this.error});

}