import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:oneup_noobs/Services/database_Services.dart';
import 'package:oneup_noobs/Utils/colors.dart';
import 'package:oneup_noobs/Utils/roundbutton.dart';
import 'package:oneup_noobs/Utils/utils.dart';
import 'package:oneup_noobs/Utils/widget.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  bool loading = false;
  final hostnamecontroller = TextEditingController();
  final eventnamecontroller = TextEditingController();
  final timecontroller = TextEditingController();
  final eventimgcontroller = TextEditingController();
  final datecontroller = TextEditingController();
  final dobcontroller = TextEditingController();
  final eventdetailcontroller = TextEditingController();

  File? _image;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final picker = ImagePicker();
  Future<void> getimageGallery() async {
    final pickedfile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    setState(() {
      if (pickedfile != null) {
        _image = File(pickedfile.path);
      } else {
        // Utils().toastMessage('No image picked');
      }
    });
  }

  Future<void> handleImageUpload() async {
    if (_image != null) {
      try {
        String imageUrl = await uploadimage();
        eventimgcontroller.text =
            imageUrl; // Save the image URL to the controller
      } catch (e) {
        //  Utils().toastMessage('Failed to upload image: $e');
      }
    } else {
      //Utils().toastMessage('No image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    final double height = screensize.height;
    final double width = screensize.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bluecolor,
        foregroundColor: Colors.white,
        title: Text('Add Events'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.03,
              ),
              TextFormField(
                controller: eventnamecontroller,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Game Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              // TextFormField(
              //   controller: hostnamecontroller,
              //   maxLines: 1,
              //   decoration: InputDecoration(
              //       hintText: 'HostName',
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10))),
              // ),
              // SizedBox(
              //   height: height * 0.03,
              // ),
              // TextFormField(
              //   controller: eventdetailcontroller,
              //   maxLines: 5,
              //   decoration: InputDecoration(
              //       hintText: 'Event Details',
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10))),
              // ),
              // SizedBox(
              //   height: height * 0.03,
              // ),
              // TextFormField(
              //   controller: timecontroller,
              //   maxLines: 1,
              //   decoration: InputDecoration(
              //       hintText: 'Time',
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10))),
              // ),
              // SizedBox(
              //   height: height * 0.03,
              // ),
              // TextFormField(
              //   controller: datecontroller,
              //   maxLines: 1,
              //   decoration: InputDecoration(
              //       hintText: 'Date',
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10))),
              // ),
              // SizedBox(
              //   height: height * 0.03,
              // ),
              TextFormField(
                controller: eventimgcontroller,
                maxLines: 4,
                decoration: InputDecoration(
                    hintText: 'Select Event Pic',
                    icon: InkWell(
                      child: Icon(Icons.add_a_photo),
                      onTap: () async {
                        await getimageGallery();
                        await handleImageUpload();
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              RoundButton(
                loading: loading,
                title: 'Add Event',
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  DatabaseService()
                      .addgames(
                    eventnamecontroller.text.toString(),
                    eventimgcontroller.text.toString(),

                    //  eventdetailcontroller.text.toString()
                  )
                      .then(
                    (value) {
                      Utils().toastMessage('Details Sucessfully Added');
                      setState(() {
                        loading = false;
                      });
                      //nextScreenReplace(context, MembersPage());

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) =>
                      //           AddCourseContentAfterAddingCourse(
                      //               coursename:
                      //                   coursenamecontroller.text.toString()),
                      //     ));
                    },
                  ).onError(
                    (error, stackTrace) {
                      Utils().toastMessage(error.toString());
                      setState(() {
                        loading = false;
                      });
                    },
                  );
                  //String id = 'ayushshahi96kmr@gmail.com';
                },
              ),
              SizedBox(
                height: height * 0.05,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> uploadimage() async {
    if (_image == null) {
      throw Exception('No image file selected');
    }
    String fileExtension = _image!.path.split('.').last;
    String fileName = '${DateTime.now().microsecondsSinceEpoch}.$fileExtension';
    firebase_storage.Reference ref = storage.ref('/foldername/$fileName');
    firebase_storage.SettableMetadata metadata =
        firebase_storage.SettableMetadata(
      contentType: 'image/$fileExtension',
      contentDisposition: 'inline; filename="$fileName"',
    );
    firebase_storage.UploadTask uploadTask = ref.putFile(_image!, metadata);
    await uploadTask;
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }
}
