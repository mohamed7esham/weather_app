import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ContactUs"),
        leading: IconButton(icon: const Icon(Icons.arrow_back),
         onPressed: () { Navigator.pop(context); }, ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.asset('assets/images/ContactUs.png'),
          const Center(
            child: Text("contact us on ",
            style: TextStyle(fontSize: 32,
            fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(Icons.facebook_outlined,size: 50,color: Colors.blue,),
              Icon(Icons.whatsapp,size: 50,color: Colors.lightGreen,),
              Icon(Icons.telegram,size: 50,color: Colors.lightBlue,),
            ],
          ),
        ]),
      ),
    );
  }
}