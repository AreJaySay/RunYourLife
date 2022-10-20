import 'package:run_your_life/data_component/objective_vm.dart';
import 'package:run_your_life/services/apis_services/screens/objective.dart';

class ObjectiveService {
  final ObjectiveApi _api = ObjectiveApi();
  final ObjectivesVM _vm = ObjectivesVM.instance;
  Future<void> fetchObjectiveAndPopulate() async {
    try{
      await _api.get().then((value) {
        if(value != null){
          _vm.populate(value);
        }
      });
      return;
    }catch (e){
      return;
    }
  }
}