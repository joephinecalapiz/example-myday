import 'dart:convert';
import 'package:example/addeditpage.dart';
import 'package:example/detailspage.dart';
import 'package:example/model/myday.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';



class ListTodos extends StatefulWidget {
  const ListTodos({Key? key}) : super(key: key);

  @override
  State<ListTodos> createState() => _ListTodosState();
}

class _ListTodosState extends State<ListTodos> {
  bool isLoading = true;

  List items = <dynamic>[];

  MydayList info = MydayList (
    data: [],

  );


  @override
  void initState() {
    super.initState();
    fetchTodo();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text("My Diary")
        ),
        body: RefreshIndicator(
            onRefresh: fetchTodo,
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  final id = item ['_id'] as String;
                  return
                    ListTile(
                      leading: CircleAvatar(
                          child: Text('${index + 1}')),
                      title: Text(item['title'],
                          style: const TextStyle(fontSize: 20,)),
                      subtitle: Text(item['description'],
                          style: const TextStyle(fontSize: 16,)),
                      trailing: PopupMenuButton(
                        onSelected: (value) {
                          if (value == 'edit') {
                            navigateToEditPage(item);

                          } else if (value == 'delete') {
                            deleteById(id);
                          }
                        },
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                                value: 'edit',
                                child: Text('Edit')),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ];
                        },
                      ),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)=> DetailsPage(detail: item[index])),
                        );
                      },
                    );
                }
            )
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddPage,
          label: const Text('Add Diary'),
        )

    );
  }

  Future <void> navigateToAddPage() async{
    final route = MaterialPageRoute(
      builder: (context) => AddTodo(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();

  }

  void navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodo(todo: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }


  Future <void> fetchTodo() async {
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    }
    setState(() {
      isLoading = false;
    });
  }




  Future<void> deleteById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    if (response.statusCode == 200){
      final filtered   = items.where((element) => element['_id'] != id).toList();
      setState((){
        items = filtered;
        showSuccessMessage('delete successfully');

      });


    }else {
      showErrorMessage('Unable to delete');

    }

  }
  void showSuccessMessage(String message){
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void showErrorMessage(String message){
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

//  63236c2f2503b8760620386e
}



