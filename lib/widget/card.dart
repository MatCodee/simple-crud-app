
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_homework/updateTask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CardElement extends StatelessWidget {

  final String title;
  final String subtitle;
  final String id;
  //final String date;


  const CardElement({super.key,required this.title,required this.subtitle,required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 238, 238, 238),
            blurRadius: 10,
            offset: Offset(0, 10), // Shadow position
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: Text(title,  overflow: TextOverflow.ellipsis,  softWrap: true,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)),
                  const SizedBox(height: 5,),
                  Container(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: Text(subtitle,style: const TextStyle(fontSize: 15,color: Colors.black54),)),
                ],
              ),
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(50))),        
                  child: IconButton(onPressed: (){}, icon: const Icon(Icons.check),color: Colors.white),
              ),             
              
            ],
          ),
            
          
          const SizedBox(height: 10,),
          const Divider(color: Colors.black45,),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Text("Today: ",style: TextStyle(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.w500),),
                  Text("10:00 PM - 11:45 PM",style: TextStyle(fontSize: 15,color: Colors.black54),)
                ],
              ),
              IconButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  UpdateTask(documentId: id)));
              }, icon: const Icon(Icons.edit),color: Colors.blue,iconSize: 30,),
              IconButton(onPressed: () {
                FirebaseFirestore.instance
                    .collection("tasks")
                    .doc(id)
                    .delete();
              }, icon: const Icon(Icons.delete),color: Colors.blue,iconSize: 30,)
            ],
          )
        ],
      ),
    );
  }
}