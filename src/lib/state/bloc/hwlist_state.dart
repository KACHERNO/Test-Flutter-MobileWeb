part of 'hwlist_bloc.dart';



class HwlistStore {
    QueryResult<Object?>? result;
    //List?   _rows;
     int    loadcount = 0;
     int?   total;
  //String?   _errmsg;
  //
  bool         stateFilter = false;
  List<int>    stateIds    = [];
  bool         typeFilter  = false;
  List<int>    typeIds     = [];
  bool         deptFilter  = false;
  List<int>    deptIds     = [];
  bool         cfgiFilter  = false;
  List<int>    cfgiIds     = [];
  bool        searchFilter = false;
  String      searchstr    = '%';


  int          limit       = 10;
  int          offset      = 0;
  Map<String,String> order = {"hw_invnum":"asc"};
  FetchPolicy? fetchPolicy;

 TextEditingController searchController = TextEditingController();

  //GlobalKey<PaginatedDataTableState> tableKey = GlobalKey<PaginatedDataTableState>();
  int  tableRowIndex = 0;
  int tableSortColumn = 1;
  bool tableSortAsc = true;
  List<Map<String,String>> tableFields = [
    //{'api_col' : 'hw_id'      , 'label' : 'ID'         , 'state' : 'enabled' },
    {'api_col' : 'hw_invnum'  , 'label' : 'Инв. Номер' , 'state' : 'enabled' },
    {'api_col' : 'type_desc'  , 'label' : 'Тип актива' , 'state' : 'enabled' },
    {'api_col' : 'cfgi_desc'  , 'label' : 'Модель КЕ'  , 'state' : 'enabled' },
    {'api_col' : 'state_desc' , 'label' : 'Состояние'  , 'state' : 'enabled' },
    {'api_col' : 'dept_desc' , 'label' : 'Подразделение'  , 'state' : 'enabled' },
    ];

  List    get getRows      => result?.data!['hw_list_view']??[];
  //String? get getError     => _errmsg;
  int     get getRowsCount =>  getRows.length;
  int     get getTotal     =>  total ?? 0;
  //int     get getLoadcount =>  loadcount;
  bool    get isResultNull=>  result == null;



}


var storage = HwlistStore();


sealed class HwlistState {
//
//
//
  var store = storage;
  var _lastOperation = 0;
  String  _errmsg = '';
  String  get getError => _errmsg;
  int     get getLastOperation => _lastOperation;

}

final class HwlistInitial extends HwlistState {}
final class HwlistLoading extends HwlistState {}

//final class HwlistEndLoading extends HwlistState {}

final class HwlistFailure extends HwlistState {
    HwlistFailure(String errmsg) {
    super._errmsg = errmsg;
  }
}
final class HwlistLoaded extends HwlistState {
  //HwlistLoaded(List? rows, int total, Map<String, dynamic> vars) {
//
//


  HwlistLoaded(QueryResult<Object?> result, int total, Map<String, dynamic> vars , int lastOperation) {
    //super._rows  = rows;
    // super._result = result;
    // super._total  = total;
    // super._loadcount = loadcount;
    // super.stateFilter = vars['state_filter'];
    // super.stateIds    = vars['state_ids'];
    // super.typeFilter  = vars['type_filter'];
    // super.typeIds     = vars['type_ids'];
    // super.deptFilter  = vars['dept_filter'];
    // super.deptIds     = vars['dept_ids'];
    // super.cfgiFilter  = vars['cfgi_filter'];
    // super.cfgiIds     = vars['cfgi_ids'];
    // super.limit       = vars['limit'];
    // super.offset      = vars['offset'];



    super.store.result = result;
    super.store.total  = total;
    super._lastOperation  = lastOperation;

//    super.store.tableRowIndex = 0;

    //super.store.loadcount = loadcount;
    // super.store.stateFilter = vars['state_filter'];
    // super.store.stateIds    = vars['state_ids'];
    // super.store.typeFilter  = vars['type_filter'];
    // super.store.typeIds     = vars['type_ids'];
    // super.store.deptFilter  = vars['dept_filter'];
    // super.store.deptIds     = vars['dept_ids'];
    // super.store.cfgiFilter  = vars['cfgi_filter'];
    // super.store.cfgiIds     = vars['cfgi_ids'];
    // super.store.limit       = vars['limit'];
    // super.store.offset      = vars['offset'];



  }
}


