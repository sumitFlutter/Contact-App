import 'dart:io';

import 'package:contact_info/model/contact_model.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Contact? c2;
  @override
  Widget build(BuildContext context) {
    c2=ModalRoute.of(context)!.settings.arguments as Contact;
    return SafeArea(child: Scaffold(
        appBar: AppBar(title:  const Center(
            child: Text(
              "View Contact",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18),
            )),),
        body:
        Container(
          width: MediaQuery.sizeOf(context).width,
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.grey.shade50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: c2?.image=="assets/image/profile.png"
                            ?
                        Center(
                          child: const CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage("assets/image/profile.png"),
                          ),
                        ): Center(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(File(c2!.image!)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Center(
                        child: Text(
                          "${c2?.name}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21),
                        ),
                      ),
                      SizedBox(height: 15,),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(child: Icon(Icons.call,size: 25,color: Colors.white,),backgroundColor: Colors.green,radius: 20,),
                        Text("call",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(child: Icon(Icons.message,size: 25,color: Colors.white,),backgroundColor: Colors.blue,radius: 20,),
                        Text("Text",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(child: Icon(Icons.video_call,size: 25,color: Colors.white,),backgroundColor: Colors.red,radius: 20,),
                        Text("video",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Align(
                  alignment: AlignmentDirectional.topStart,
                    child: Text("NOW",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                Row(children: [
                  Column(
                    children: [
                      Text("${c2?.mobile}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      Text("${c2?.email}",style: TextStyle(fontSize: 15),),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.mail,size: 30,),
                  SizedBox(width: 15,),
                  Icon(Icons.call,size: 30,),

                ],)
              ],
            ),
          ),
        )
    ));
  }
}
