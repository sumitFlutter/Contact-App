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
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            contactList.length==0
                ? const Center(
                    child: Text(
                      "Nothing is here tap to + Button to add Contact",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ):Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => Container(
                    height: 150,
                    width: 150,
                    color: Colors.primaries[index].shade300,
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(15),
                    child: Row(
                      children: [contactList[index].image=="assets/image/profile.png"?
                        CircleAvatar(
                            radius: 50,
                        backgroundImage: AssetImage(contactList[index].image!),):
                                CircleAvatar(
                                radius: 50,
                                    backgroundImage: FileImage(
                                        File(contactList[index].image!))),
                        SizedBox(width: 20,),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "\nName:\n${contactList[index].name}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Mobile Number:\n${contactList[index].mobile!}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20,),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
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
                                                   SizedBox(height: 5,),
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
                                                   SizedBox(
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
                                                             ScaffoldMessenger.of(context)!.showSnackBar(SnackBar(content: Text("Image is required")));
                                                           }
                                                           else{
                                                            contactList[index].name=txtName.text;
                                                            contactList[index].email=txtE.text;
                                                            contactList[index].mobile=txtMobile.text;
                                                            contactList[index].image=editI;
                                                             txtName.clear();
                                                             txtMobile.clear();
                                                             txtE.clear();
                                                             ScaffoldMessenger.of(context)!.showSnackBar(SnackBar(content: Text("Your Contact is saved")));
                                                             Future.delayed(Duration(seconds: 1),() => Navigator.pop(context));
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
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      contactList.removeAt(index);
                                    });
                                  },
                                  icon: Icon(Icons.delete)),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, "view",arguments: contactList[index]);
                                  },
                                  icon: Icon(Icons.remove_red_eye))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  itemCount: contactList.length,
                ))
          ],
        ),
      ),
          floatingActionButton: FloatingActionButton(onPressed: () {
            Navigator.pushNamed(context, "add").then((value) => setState(() {}));
          },child: Icon(Icons.add),),
    ));
  }
}
