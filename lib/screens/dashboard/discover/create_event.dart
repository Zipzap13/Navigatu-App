import 'dart:io';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../../controller/data_controller.dart';
import '../../../model/event_media_model.dart';
import '../../../utils/app_color.dart';
import '../../../widgets/my_widgets.dart';

class CreateEventView extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  CreateEventView({Key? key}) : super(key: key);

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  DateTime? date = DateTime.now();
//Text Controllerrs
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  TextEditingController maxEntries = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  // ignore: prefer_const_constructors
  TimeOfDay startTime = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 0, minute: 0);


//Reset Contorllers -clearing
  void resetControllers() {
    media.clear();
    dateController.clear();
    timeController.clear();
    titleController.clear();
    locationController.clear();
    descriptionController.clear();
    tagsController.clear();
    maxEntries.clear();
    endTimeController.clear();
    startTimeController.clear();

    startTime = TimeOfDay(hour: 0, minute: 0);
    endTime = TimeOfDay(hour: 0, minute: 0);
    setState(() {});
  }

  var isCreatingEvent = false.obs;

//selecting date from date picker
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015), 
      lastDate: DateTime(2101),
    );

    if (picked != null) { 
      date = DateTime(picked.year, picked.month, picked.day, date!.hour,
          date!.minute, date!.second);
      dateController.text = '${date!.day}-${date!.month}-${date!.year}';
    }
    setState(() {});  
  }
//selecting time from time picker
  startTimeMethod(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      startTime = picked;
      startTimeController.text =
          '${startTime.hourOfPeriod > 9 ? "" : ''}${startTime.hour > 12 ? '${startTime.hour - 12}' : startTime.hour}:${startTime.minute > 9 ? startTime.minute : '${startTime.minute}'} ${startTime.hour > 12 ? 'PM' : 'AM'}';
    }
    print("start ${startTimeController.text}");
    setState(() {});
  }

  endTimeMethod(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      endTime = picked;
      endTimeController.text =
          '${endTime.hourOfPeriod > 9 ? "" : ""}${endTime.hour > 9 ? "" : ""}${endTime.hour > 12 ? '${endTime.hour - 12}' : endTime.hour}:${endTime.minute > 9 ? endTime.minute : '0${endTime.minute}'} ${endTime.hour > 12 ? 'PM' : 'AM'}';
    }

    print("end ${endTimeController.text} ");
    setState(() {});
  }

  String event_type = 'Pitching';
  List<String> list_item = ['Pitching', 'Mentoring', 'Seminar & Workshop'];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> mediaUrls = [];

  List<EventMediaModel> media = [];

  // List<File> media = [];
  // List thumbnail = [];
  // List<bool> isImage = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeController.text = '${date!.hour}:${date!.minute}:${date!.second}';
    dateController.text = '${date!.day}-${date!.month}-${date!.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                iconWithTitle(text: 'Create Event', func: () {
                  navigator?.pop(true);
                }),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black.withOpacity(0.6),
                                  width: 0.6))),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: Container(

                       
                            ),

                        icon: Icon(Icons.arrow_drop_down_rounded),
                        elevation: 16,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                        value: event_type,
                        onChanged: (String? newValue) {
                          setState(
                            () {
                              event_type = newValue!;
                            },
                          );
                        },
                        items: list_item
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Container(
                  height: Get.width * 0.6,
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                      color: AppColors.border.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8)),
                  child: DottedBorder(
                    color: AppColors.border,
                    strokeWidth: 1.5,
                    dashPattern: [6, 6],
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: Get.height * 0.05,
                          ),
                          Container(
                            width: 76,
                            height: 59,
                            child: Image.asset('assets/images/upload.png'),
                          ),
                          myText(
                            text: 'Click and upload image/video',
                            style: TextStyle(
                              color: AppColors.blue,
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          elevatedButton(
                              onpress: () async {
                                mediaDialog(context);
                              },
                              text: 'Upload')
                        ],
                      ),
                    ),
                  ),
                ),
                media.length == 0
                    ? Container()
                    : SizedBox(
                        height: 20,
                      ),

                media.length == 0
                    ? Container()
                    : Container(
                        width: Get.width,
                        height: Get.width * 0.3,
                        child: ListView.builder(
                            itemBuilder: (ctx, i) {
                              return media[i].isVideo!
                                  //!isImage[i]
                                  ? Container(
                                      width: Get.width * 0.3,
                                      height: Get.width * 0.3,
                                      margin: EdgeInsets.only(
                                          right: 15, bottom: 10, top: 10),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: MemoryImage(
                                                media[i].thumbnail!),
                                            fit: BoxFit.fill),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Stack(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(5),
                                                child: CircleAvatar(
                                                  child: IconButton(
                                                    onPressed: () {
                                                      media.removeAt(i);
                                                      // media.removeAt(i);
                                                      // isImage.removeAt(i);
                                                      // thumbnail.removeAt(i);
                                                      setState(() {});
                                                    },
                                                    icon: Icon(Icons.close),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.slow_motion_video_rounded,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: Get.width * 0.3,
                                      height: Get.width * 0.3,
                                      margin: EdgeInsets.only(
                                          right: 15, bottom: 10, top: 10),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(media[i].image!),
                                            fit: BoxFit.fill),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                            child: CircleAvatar(
                                              child: IconButton(
                                                onPressed: () {
                                                  media.removeAt(i);
                                                  // isImage.removeAt(i);
                                                  // thumbnail.removeAt(i);
                                                  setState(() {});
                                                },
                                                icon: Icon(Icons.close),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                            },
                            itemCount: media.length,
                            scrollDirection: Axis.horizontal),
                      ),

                SizedBox(
                  height: 20,
                ),
                myTextField(
                    bool: false,
                    icon: 'assets/images/booking.jpg',
                    text: 'Event Name',
                    controller: titleController,
                    validator: (String input) {
                      if (input.isEmpty) {
                        Get.snackbar('Opps', "Event name is required.",
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        return '';
                      }

                      if (input.length < 3) {
                        Get.snackbar(
                            'Opps', "Event name is should be 3+ characters.",
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        return '';
                      }
                      return null;
                    }),

                SizedBox(
                  height: 20,
                ),
                myTextField(
                    bool: false,
                    icon: 'assets/images/loc.png',
                    text: 'Location',
                    controller: locationController,
                    validator: (String input) {
                      if (input.isEmpty) {
                        Get.snackbar('Opps', "Location is required.",
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        return '';
                      }

                      if (input.length < 3) {
                        Get.snackbar('Opps', "Location is Invalid.",
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        return '';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    iconTitleContainer(
                      isReadOnly: true,
                      path: 'assets/images/date.png',
                      text: 'Date',
                      controller: dateController,
                      validator: (input) {
                        if (date == null) {
                          Get.snackbar('Opps', "Date is required.",
                              colorText: Colors.white,
                              backgroundColor: Colors.blue);
                          return '';
                        }
                        return null;
                      },
                      onPress: () {
                        _selectDate(context);
                      },
                    ),
                    iconTitleContainer(
                        path: 'assets/images/parti.png',
                        text: ' Participants',
                        controller: maxEntries,
                        type: TextInputType.number,
                        onPress: () {},
                        validator: (String input) {
                          if (input.isEmpty) {
                            Get.snackbar('Opps', "Entries is required.",
                                colorText: Colors.white,
                                backgroundColor: Colors.blue);
                            return '';
                          }
                          return null;
                        }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                iconTitleContainer(
                    path: 'assets/images/parti.png',
                    text: 'Enter tags that will go with event.',
                    width: double.infinity,
                    controller: tagsController,
                    type: TextInputType.text,
                    onPress: () {},
                    validator: (String input) {
                      if (input.isEmpty) {
                        Get.snackbar('Opps', "Entries is required.",
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        return '';
                      }
                      return null;
                    }),

                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    iconTitleContainer(
                        path: 'assets/images/time.png',
                        text: 'Start Time',
                        controller: startTimeController,
                        isReadOnly: true,
                        validator: (input) {},
                        onPress: () {
                          startTimeMethod(context);
                        }),
                    iconTitleContainer(
                        path: 'assets/images/time.png',
                        text: 'End Time',
                        isReadOnly: true,
                        controller: endTimeController,
                        validator: (input) {},
                        onPress: () {
                          endTimeMethod(context);
                        }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    myText(
                        text: 'Description/Instruction',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 149,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(width: 1, color: AppColors.genderTextColor),
                  ),
                  child: TextFormField(
                    maxLines: 5,
                    controller: descriptionController,
                    validator: (input) {
                      if (input!.isEmpty) {
                        Get.snackbar('Opps', "Description is required.",
                            colorText: Colors.white,
                            backgroundColor: Colors.blue);
                        return '';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.only(top: 25, left: 15, right: 15),
                      hintStyle: TextStyle(
                        color: AppColors.genderTextColor,
                      ),
                      hintText:
                          'Write a summary and any details your invitee should know about the event...',
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(8.0),
                      // ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: Get.height * 0.02,
                // ),
                // Container(
                //   alignment: Alignment.topLeft,
                //   child: myText(
                //     text: 'Who can invite?',
                //     style: TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.w700,
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: Get.height * 0.005,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Container(
                //       alignment: Alignment.center,
                //       padding: EdgeInsets.only(left: 10, right: 10),
                //       width: 150,
                //       height: 40,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(8),
                //         border: Border.all(
                //             width: 1, color: AppColors.genderTextColor),
                //       ),
                //       // decoration: BoxDecoration(
                //       //
                //       //   // borderRadius: BorderRadius.circular(8),
                //       //    border: Border(
                //       //         bottom: BorderSide(color: Colors.black.withOpacity(0.8),width: 0.6)
                //       //     )
                //       //
                //       // ),
                //       child: DropdownButton(
                //         isExpanded: true,
                //         underline: Container(),
                //         //borderRadius: BorderRadius.circular(10),
                //         icon: Image.asset('assets/arrowDown.png'),
                //         elevation: 16,
                //         style: TextStyle(
                //           fontWeight: FontWeight.w400,
                //           color: AppColors.black,
                //         ),
                //         value: accessModifier,
                //         onChanged: (String? newValue) {
                //           setState(
                //             () {
                //               accessModifier = newValue!;
                //             },
                //           );
                //         },
                //         items: close_list
                //             .map<DropdownMenuItem<String>>((String value) {
                //           return DropdownMenuItem(
                //             value: value,
                //             child: Text(
                //               value,
                //               style: TextStyle(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w400,
                //                 color: Color(0xffA6A6A6),
                //               ),
                //             ),
                //           );
                //         }).toList(),
                //       ),
                //     ),
                //     iconTitleContainer(
                //         path: 'assets/dollarLogo.png',
                //         text: 'price',
                //         type: TextInputType.number,
                //         height: 40,
                //         controller: priceController,
                //         onPress: () {},
                //         validator: (String input) {
                //           if (input.isEmpty) {
                //             Get.snackbar('Opps', "Price is required.",
                //                 colorText: Colors.white,
                //                 backgroundColor: Colors.blue);
                //             return '';
                //           }
                //         })
                //   ],
                // ),
                SizedBox(
                  height: Get.height * 0.03,
                ),

                Obx(() => isCreatingEvent.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        height: 42,
                        width: double.infinity,
                        child: elevatedButton(
                            onpress: () async {
                              if (!formKey.currentState!.validate()) {
                                return;
                              }

                              if (media.isEmpty) {
                                Get.snackbar('Opps', "Media is required.",
                                    colorText: Colors.white,
                                    backgroundColor: Colors.blue);

                                return;
                              }

                              if (tagsController.text.isEmpty) {
                                Get.snackbar('Opps', "Tags is required.",
                                    colorText: Colors.white,
                                    backgroundColor: Colors.blue);

                                return;
                              }

                              isCreatingEvent(true);

                              DataController dataController = Get.find();

                              if (media.isNotEmpty) {
                                for (int i = 0; i < media.length; i++) {
                                  if (media[i].isVideo!) {
                                    /// if video then first upload video file and then upload thumbnail and
                                    /// store it in the map

                                    String thumbnailUrl = await dataController
                                        .uploadThumbnailToFirebase(
                                            media[i].thumbnail!);

                                    String videoUrl = await dataController
                                        .uploadImageToFirebase(media[i].video!);

                                    mediaUrls.add({
                                      'url': videoUrl,
                                      'thumbnail': thumbnailUrl,
                                      'isImage': false
                                    });
                                  } else {
                                    /// just upload image

                                    String imageUrl = await dataController
                                        .uploadImageToFirebase(media[i].image!);
                                    mediaUrls.add(
                                        {'url': imageUrl, 'isImage': true});
                                  }
                                }
                              }

                              List<String> tags =
                                  tagsController.text.split(',');

                              Map<String, dynamic> eventData = {
                                'event': event_type,
                                'event_name': titleController.text,
                                'location': locationController.text,
                                'date': date,
                                'start_time': startTimeController.text,
                                'end_time': endTimeController.text,
                                '#_participants': int.parse(maxEntries.text),
                                'description': descriptionController.text,
                                'media': mediaUrls,
                                'tags': tags,
                              };

                              await dataController
                                  .createEvent(eventData)
                                  .then((value) {
                                print("Event Created");
                                isCreatingEvent(false);
                                resetControllers();
                              });
                            },
                            text: 'Create Event'),
                      )),
                SizedBox(
                  height: Get.height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getImageDialog(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(
      source: source,
    );

    if (image != null) {
      media.add(EventMediaModel(
          image: File(image.path), video: null, isVideo: false));
    }

    setState(() {});
    Navigator.pop(context);
  }

  getVideoDialog(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? video = await _picker.pickVideo(
      source: source,
    );
    if (video != null) {
      // media.add(File(image.path));
      Uint8List? uint8list = await VideoThumbnail.thumbnailData(
        video: video.path,
        imageFormat: ImageFormat.JPEG,
        quality: 75,
      );

      media.add(EventMediaModel(
          thumbnail: uint8list!, video: File(video.path), isVideo: true));
      // thumbnail.add(uint8list!);
      //
      // isImage.add(false);
    }

    // print(thumbnail.first.path);
    setState(() {});

    Navigator.pop(context);
  }

  void mediaDialog(BuildContext context) {
    showDialog(
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Media Type"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      imageDialog(context, true);
                    },
                    icon: Icon(Icons.image)),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      imageDialog(context, false);
                    },
                    icon: Icon(Icons.slow_motion_video_outlined)),
              ],
            ),
          );
        },
        context: context);
  }

  void imageDialog(BuildContext context, bool image) {
    showDialog(
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Media Source"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      if (image) {
                        getImageDialog(ImageSource.gallery);
                      } else {
                        getVideoDialog(ImageSource.gallery);
                      }
                    },
                    icon: Icon(Icons.image)),
                IconButton(
                    onPressed: () {
                      if (image) {
                        getImageDialog(ImageSource.camera);
                      } else {
                        getVideoDialog(ImageSource.camera);
                      }
                    },
                    icon: Icon(Icons.camera_alt)),
              ],
            ),
          );
        },
        context: context);
  }
}
