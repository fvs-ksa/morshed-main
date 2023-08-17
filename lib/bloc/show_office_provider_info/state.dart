abstract class ShowOfficesAndProviderInfoState{}
class InitialShowDataState extends ShowOfficesAndProviderInfoState{}
class ChangeTabBarState extends ShowOfficesAndProviderInfoState{}
class GetAllOfficesDataSuccessState extends ShowOfficesAndProviderInfoState{}
class GetAllOfficesDataLoadingState extends ShowOfficesAndProviderInfoState{}
class GetAllOfficesDataErrorState extends ShowOfficesAndProviderInfoState{
  final String error;
  GetAllOfficesDataErrorState({required this.error});
}

class FullMarkListState extends ShowOfficesAndProviderInfoState{}
class ChangeTabbedMarkerState extends ShowOfficesAndProviderInfoState{}



class GetAllProvidersDataSuccessState extends ShowOfficesAndProviderInfoState{}
class GetAllProvidersDataLoadingState extends ShowOfficesAndProviderInfoState{}
class GetAllProvidersDataErrorState extends ShowOfficesAndProviderInfoState{
  final String error;
  GetAllProvidersDataErrorState({required this.error});
}
class SearchOfficesLoadingState extends ShowOfficesAndProviderInfoState{}
class SearchOfficesSuccessState extends ShowOfficesAndProviderInfoState{}
class SearchOfficesErrorState extends ShowOfficesAndProviderInfoState{
  final String error;
  SearchOfficesErrorState({required this.error});
}