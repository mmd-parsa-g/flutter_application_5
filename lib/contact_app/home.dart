// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_application_5/contact_app/user_info.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  void addContact() {
    Box<UserInfo> contactBox = Hive.box<UserInfo>("userinfo");
    contactBox.add(UserInfo(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        number: int.parse(_phoneNumberController.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact App"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Add Contact"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _firstNameController,
                            decoration:
                                const InputDecoration(hintText: "first Name"),
                          ),
                          TextField(
                            controller: _lastNameController,
                            decoration:
                                const InputDecoration(hintText: "last Name"),
                          ),
                          TextField(
                            controller: _phoneNumberController,
                            decoration:
                                const InputDecoration(hintText: "phone Number"),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    style: const ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.black26)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _firstNameController.clear();
                                      _lastNameController.clear();
                                      _phoneNumberController.clear();
                                    },
                                    child: const Text("Cancel")),
                                TextButton(
                                    style: const ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.black26)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      addContact();
                                      _firstNameController.clear();
                                      _lastNameController.clear();
                                      _phoneNumberController.clear();
                                    },
                                    child: const Text("Save Contact")),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<UserInfo>("userinfo").listenable(),
        builder: (context, Box<UserInfo> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text("No Cantact Exist"),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemBuilder: (context, index) {
                        UserInfo? userInfo = box.getAt(index);

                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                  "${userInfo!.firstName} ${userInfo.lastName}"),
                              Text(userInfo.number.toString()),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton.icon(
                                    label: const Text('Edit'),
                                    onPressed: () {
                                      final TextEditingController
                                          firstNameController =
                                          TextEditingController(
                                              text: userInfo.firstName);
                                      final TextEditingController
                                          lastNameController =
                                          TextEditingController(
                                              text: userInfo.lastName);
                                      final TextEditingController
                                          phoneNumberController =
                                          TextEditingController(
                                              text: userInfo.number.toString());
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Edit Contact"),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller:
                                                      firstNameController,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "first Name"),
                                                ),
                                                TextField(
                                                  controller:
                                                      lastNameController,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "last Name"),
                                                ),
                                                TextField(
                                                  controller:
                                                      phoneNumberController,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "phone Number"),
                                                ),
                                                const SizedBox(height: 30),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      TextButton(
                                                          style: const ButtonStyle(
                                                              backgroundColor:
                                                                  WidgetStatePropertyAll(
                                                                      Colors
                                                                          .black26)),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                              "Cancel")),
                                                      TextButton(
                                                          style: const ButtonStyle(
                                                              backgroundColor:
                                                                  WidgetStatePropertyAll(
                                                                      Colors
                                                                          .black26)),
                                                          onPressed: () {
                                                            final value = UserInfo(
                                                                firstName:
                                                                    firstNameController
                                                                        .text,
                                                                lastName:
                                                                    lastNameController
                                                                        .text,
                                                                number: int.parse(
                                                                    phoneNumberController
                                                                        .text));
                                                            box.putAt(
                                                                index, value);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                              "Save")),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  TextButton.icon(
                                      label: const Text("Remove"),
                                      onPressed: () async {
                                        await box.deleteAt(index);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: box.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1.5,
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
