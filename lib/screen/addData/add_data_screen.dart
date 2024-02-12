import 'dart:io';

import 'package:contact_info/model/contact_model.dart';
import 'package:contact_info/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  String? path;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtE = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Center(
                  child: Text(
                "Create a new Contact",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (key.currentState!.validate()) {
                          if (path == null) {
                            ScaffoldMessenger.of(context)!.showSnackBar(
                                SnackBar(content: Text("Image is required")));
                          } else {
                            Contact c1 = Contact(
                                email: txtE.text,
                                mobile: txtMobile.text,
                                image: path == null
                                    ? "assets/image/profile.png"
                                    : path,
                                name: txtName.text);
                            contactList.add(c1);
                            txtName.clear();
                            txtMobile.clear();
                            txtE.clear();
                            ScaffoldMessenger.of(context)!.showSnackBar(
                                SnackBar(
                                    content: Text("Your Contact is saved")));
                            Future.delayed(Duration(seconds: 1),
                                () => Navigator.pop(context));
                          }
                        }
                      });
                    },
                    child: const Text("Save"),
                  ),
                ),
              ],
            ),
            body: Container(
              width: MediaQuery.sizeOf(context).width,
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            path == null
                                ? const CircleAvatar(
                                    radius: 60,
                                    backgroundImage: AssetImage(
                                        "assets/image/profile.png"),
                                  )
                                : CircleAvatar(
                                    radius: 60,
                                    backgroundImage: FileImage(File(path!)),
                                  ),
                            Align(
                                alignment: const Alignment(0.8, 0.8),
                                child: IconButton(
                                  onPressed: () async {
                                    ImagePicker picker = ImagePicker();
                                    XFile? image = await picker.pickImage(
                                        source: ImageSource.camera);
                                    setState(() {
                                      path = image!.path;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo_rounded,
                                    color: Colors.black,
                                    weight: 50,
                                  ),
                                )),
                            Align(
                                alignment: const Alignment(-0.8, -0.8),
                                child: IconButton(
                                  onPressed: () async {
                                    ImagePicker picker = ImagePicker();
                                    XFile? image = await picker.pickImage(
                                        source: ImageSource.gallery);
                                    setState(() {
                                      path = image!.path;
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
                      SizedBox(height: 15,),
                      Column(
                        children: [
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
                                enabledBorder: OutlineInputBorder(),
                                hintStyle: TextStyle(color: Colors.black),
                                suffixIcon: Icon(Icons.person)),
                            style: const TextStyle(color: Colors.black),
                          ),
                          SizedBox(height: 15,),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: txtMobile,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Mobile number is required";
                              }
                              if (value!.length != 10) {
                                return "Enter valid number";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: "Enter Mobile Number",
                                enabledBorder: OutlineInputBorder(),
                                hintStyle: TextStyle(color: Colors.black),
                                suffixIcon: Icon(Icons.call)),
                            style: const TextStyle(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: txtE,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email is required";
                              } else if (!RegExp(
                                  "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$")
                                  .hasMatch(value!)) {
                                return "enter the valid email";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: "Enter Your Email",
                                enabledBorder: OutlineInputBorder(),
                                hintStyle: TextStyle(color: Colors.black),
                                suffixIcon: Icon(Icons.mail)),
                            style: const TextStyle(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
