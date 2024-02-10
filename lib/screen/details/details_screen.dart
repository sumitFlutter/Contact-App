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
        Center(
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(15),
            color: Colors.blue.shade300,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.blue.shade300,
                    child: c2?.image=="assets/image/profile.png"
                        ?
                    Center(
                      child: const CircleAvatar(
                        radius: 90,
                        backgroundImage: AssetImage("assets/image/profile.png"),
                      ),
                    ): Center(
                      child: CircleAvatar(
                        radius: 90,
                        backgroundImage: FileImage(File(c2!.image!)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  const Text(
                    "Name:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15,color: Colors.white),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${c2?.name}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15,color: Colors.white),
                  ),
                  const Divider(),
                  const Text(
                    "Mobile Number:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15,color: Colors.white),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${c2?.mobile}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15,color: Colors.white),
                  ),
                  const Divider(),
                  const Text(
                    "Email Address",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15,color: Colors.white),
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    "${c2?.email}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15,color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        )
    ));
  }
}
