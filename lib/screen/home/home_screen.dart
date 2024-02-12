import 'dart:io';

import 'package:contact_info/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';

import '../../model/contact_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  String? editI;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtE = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Contacts",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "add").then((value) => setState(() {}));
                },
                child: Container(
                  height: 45,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.lightBlue.shade50,),
                  child:  const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person_add,color: Colors.lightBlue,),
                    SizedBox(width: 10,),
                    Text("Create a new contact",style: TextStyle(color: Colors.lightBlue),)
                  ],
                ),),
              ),
            ),
                Expanded(
                child: ListView.builder(
                  itemCount: contactList.length,
                  itemBuilder: (context, index) => Container(
                    height: 80,
                    width: 80,
                    margin: const EdgeInsets.all(15),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "view",arguments: contactList[index]);
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [contactList[index].image=="assets/image/profile.png"?
                              CircleAvatar(
                                  radius: 25,
                              backgroundImage: AssetImage(contactList[index].image!),):
                                      CircleAvatar(
                                      radius: 25,
                                          backgroundImage: FileImage(
                                              File(contactList[index].image!))),
                              const SizedBox(width: 20,),
                              Text(
                                "${contactList[index].name}",
                                style: const TextStyle(fontWeight: FontWeight.bold,),
                              ),
                              const Spacer(),
                              Container(
                                color: Colors.grey.shade50,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        txtMobile.text=contactList[index].mobile!;
                                        txtE.text=contactList[index].email!;
                                        txtName.text=contactList[index].name!;
                                        editI=contactList[index].image!;
                                      });
                                     showDialog(context: context, builder: (context) {
                                       return  Center(
                                         child: Material(
                                           child: Container(
                                             width: MediaQuery.sizeOf(context).width,
                                             margin: const EdgeInsets.all(15),
                                             padding: const EdgeInsets.all(15),
                                             color: Colors.primaries[index].shade300,
                                             child: SingleChildScrollView(
                                               child: Form(
                                                 key: key,
                                                 child: Column(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: [
                                                     Container(
                                                       color: Colors.white,
                                                       child: Stack(
                                                         alignment: Alignment.center,
                                                         children: [
                                                           editI==null
                                                               ?
                                                           const CircleAvatar(
                                                             radius: 90,
                                                             backgroundImage: AssetImage("assets/image/profile.png"),
                                                           ): CircleAvatar(
                                                             radius: 90,
                                                             backgroundImage: FileImage(File(editI!)),
                                                           ),
                                                           Align(
                                                               alignment: const Alignment(0.8,0.8),
                                                               child: IconButton(
                                                                 onPressed: () async {
                                                                   ImagePicker picker = ImagePicker();
                                                                   XFile? image = await picker.pickImage(
                                                                       source: ImageSource.camera);
                                                                   setState(() {
                                                                     editI = image!.path;
                                                                   });
                                                                 },
                                                                 icon: const Icon(
                                                                   Icons.add_a_photo_rounded,
                                                                   color: Colors.black,
                                                                   weight: 50,
                                                                 ),
                                                               )),
                                                           Align(
                                                               alignment: const Alignment(-0.8,-0.8),
                                                               child: IconButton(
                                                                 onPressed: () async {
                                                                   ImagePicker picker = ImagePicker();
                                                                   XFile? image = await picker.pickImage(
                                                                       source: ImageSource.gallery);
                                                                   setState(() {
                                                                     editI = image!.path;
                                                                   });
                                                                 },
                                                                 icon: const Icon(
                                                                   Icons.photo,
                                                                   color: Colors.black,
                                                                   weight: 50,
                                                                 ),
                                                               ))
                                                         ],
                                                       ),
                                                     ),
                                                     const SizedBox(height: 5,),
                                                     const Text(
                                                       "Name:",
                                                       style: TextStyle(
                                                           fontWeight: FontWeight.bold, fontSize: 15,color: Colors.white),
                                                     ),
                                                     TextFormField(
                                                       keyboardType: TextInputType.name,
                                                       controller: txtName,
                                                       validator: (value) {
                                                         if (value!.isEmpty) {
                                                           return "Name is required";
                                                         }
                                                         return null;
                                                       },
                                                       decoration: const InputDecoration(
                                                           hintText: "Enter Your name",
                                                           hintStyle: TextStyle(color: Colors.white)),
                                                       style: const TextStyle(color: Colors.white),
                                                     ),
                                                     const SizedBox(
                                                       height: 5,
                                                     ),
                                                     const Text(
                                                       "Mobile Number:",
                                                       style: TextStyle(
                                                           fontWeight: FontWeight.bold, fontSize: 15,color: Colors.white),
                                                     ),
                                                     TextFormField(
                                                       keyboardType: TextInputType.number,
                                                       controller: txtMobile,
                                                       validator: (value) {
                                                         if (value!.isEmpty) {
                                                           return "Mobile number is required";
                                                         }
                                                         if(value!.length!=10)
                                                         {
                                                           return "Enter valid number";
                                                         }
                                                         return null;
                                                       },
                                                       decoration: const InputDecoration(
                                                           hintText: "Enter Mobile Number",
                                                           hintStyle: TextStyle(color: Colors.white)),
                                                       style: const TextStyle(color: Colors.white),

                                                     ),
                                                     const SizedBox(
                                                       height: 5,
                                                     ),
                                                     const Text(
                                                       "Email Address",
                                                       style: TextStyle(
                                                           fontWeight: FontWeight.bold, fontSize: 15,color: Colors.white),
                                                     ),
                                                     TextFormField(
                                                       keyboardType: TextInputType.emailAddress,
                                                       controller: txtE,
                                                       validator: (value) {
                                                         if (value!.isEmpty) {
                                                           return "Email is required";
                                                         }
                                                         else if (!RegExp(
                                                             "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$")
                                                             .hasMatch(value!)) {
                                                           return "enter the valid email";
                                                         }
                                                         return null;
                                                       },
                                                       decoration: const InputDecoration(
                                                           hintText: "Enter Your Email",
                                                           hintStyle: TextStyle(color: Colors.white)),
                                                       style: const TextStyle(color: Colors.white),
                                                     ),
                                                     const SizedBox(height: 15,),
                                                     Center(
                                                       child: ElevatedButton(onPressed: () {
                                                         setState(() {
                                                           if (key.currentState!.validate())
                                                           {
                                                             if(editI==null)
                                                             {
                                                               ScaffoldMessenger.of(context)!.showSnackBar(const SnackBar(content: Text("Image is required")));
                                                             }
                                                             else{
                                                              contactList[index].name=txtName.text;
                                                              contactList[index].email=txtE.text;
                                                              contactList[index].mobile=txtMobile.text;
                                                              contactList[index].image=editI;
                                                               txtName.clear();
                                                               txtMobile.clear();
                                                               txtE.clear();
                                                               ScaffoldMessenger.of(context)!.showSnackBar(const SnackBar(content: Text("Your Contact is saved")));
                                                               Future.delayed(const Duration(seconds: 1),() => Navigator.pop(context));
                                                             }

                                                           }
                                                         });
                                                       },child: const Text("Submit"),),
                                                     )
                                                   ],
                                                 ),
                                               ),
                                             ),
                                           ),
                                         ),
                                       );
                                     },);
                                    },
                                    icon: const Icon(Icons.edit)),
                              ),
                              const SizedBox(width: 7,),
                              Container(
                                color: Colors.grey.shade50,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        contactList.removeAt(index);
                                      });
                                    },
                                    icon: const Icon(Icons.delete)),
                              ),
                            ],
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
