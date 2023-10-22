import 'package:calculadoraimc/models/history.dart';
import 'package:calculadoraimc/repository/imc_history_repository.dart';
import 'package:calculadoraimc/service/imc_service.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  ImcHistoryRepository historyRepository = ImcHistoryRepository();
  var _data = const <History>[];
  int _currentPage = 0;
  static const _size = 10;
  bool _isLoading = false;

  double _lastPaginatedPosition = 0;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    addControllerListener();
    super.initState();
    getHistory();
  }

  void addControllerListener(){
    _scrollController.addListener(() {
      var paginationPosistion = _scrollController.position.maxScrollExtent * 0.7;
      if (_scrollController.position.pixels > paginationPosistion && _lastPaginatedPosition<_scrollController.position.pixels) {
        setState(() {
          _lastPaginatedPosition = _scrollController.position.pixels;
        });
        getHistory();
      }
    });
  }
  void getHistory() async {
    if(_isLoading) return;

    setState(() {
      _isLoading = true;  
    });
    var tempdata = await historyRepository.getAll(_size, _currentPage);
    _data += tempdata;
    _currentPage++;
    _isLoading = false;
    setState(() {});
  }

  void deleteHistory(int id) async {
    await historyRepository.delete(id);
    _data.removeWhere((element) => element.getId==id);
    setState(() {});
  }

  EvaluationAttributes getEvaluationAttribute (double imc){
    return ImcService.getAttibuteByImc(imc);
  } 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _data.isEmpty?
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Text("Não há nenhum registro ainda",
              textAlign: TextAlign.center
            )
          ):Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _data.length,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    var history = _data[index];
                    return Dismissible(
                      key: Key(history.getId.toString()), 
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirmação"),
                              content: const Text("Você tem certeza que deseja deletar esse item?"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => {
                                    deleteHistory(history.getId),
                                    Navigator.of(context).pop(false),
                                  },
                                  child: const Text("CONFIRMAR")
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: const Text("CANCELAR"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child:  ListTile(
                        leading: Container(
                            color:getEvaluationAttribute(history.value).color,
                            child: const Text("          ")
                        ),
                        title:Text("IMC: ${history.value.toStringAsFixed(2)}"),
                        subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(getEvaluationAttribute(history.value).label),
                            Text("Data: ${history.getFormattedDate()}")                    
                          ],
                        ),
                        isThreeLine: true,
                      )
                    );
                  }
                )),
                if(_isLoading) const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator()
                )
            ],
          ) 
    );
  }
}