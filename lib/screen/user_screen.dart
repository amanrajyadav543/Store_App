import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../services/api_handler.dart';
import '../widgets/users_widget.dart';

class UsersScreen extends StatelessWidget{
  const UsersScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text("Users"),
     ),
     body: FutureBuilder<List<UsersModel>>(
       future: APIHandler.getAllUsers(),
       builder: ((context , snapshot){
         if (snapshot.connectionState == ConnectionState.waiting){
           return const Center(
             child: CircularProgressIndicator(),
           );
         }else if(snapshot.hasError){
           Center(
              child: Text("No product has been Added Yet")
           );
         }
         return ListView.builder(
             itemCount: snapshot.data!.length,
             itemBuilder: (ctx, index){
               return ChangeNotifierProvider.value(value: snapshot.data![index],
               child: UsersWidget(),);

         });
       }),
     ),
   );
  }

}