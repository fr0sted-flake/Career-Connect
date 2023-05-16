import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:placement_portal/reusable_widgets/loading.dart';

class PostJobs extends StatefulWidget {
  const PostJobs({Key? key}) : super(key: key);

  @override
  State<PostJobs> createState() => _PostJobsState();
}

class _PostJobsState extends State<PostJobs> {
  // text fields' controllers
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _ctcController = TextEditingController();
  final TextEditingController _officeLocationController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final CollectionReference _jobss =
      FirebaseFirestore.instance.collection('jobs');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _jobTitleController.text = documentSnapshot['jobtitle'];
      _ctcController.text = documentSnapshot['ctc'].toString();
      _officeLocationController.text = documentSnapshot['officelocation'];
      _descriptionController.text = documentSnapshot['description'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _jobTitleController,
                  decoration: const InputDecoration(labelText: 'Job Title'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _ctcController,
                  decoration: const InputDecoration(
                    labelText: 'CTC',
                  ),
                ),
                TextField(
                  controller: _officeLocationController,
                  decoration:
                      const InputDecoration(labelText: 'Office Location'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? jobtitle = _jobTitleController.text;
                    final double? ctc = double.tryParse(_ctcController.text);
                    final String? officelocation =
                        _officeLocationController.text;
                    final String? description = _descriptionController.text;
                    if (jobtitle != null &&
                        ctc != null &&
                        officelocation != null &&
                        description != null) {
                      if (action == 'create') {
                        await _jobss.add({
                          "jobtitle": jobtitle,
                          "ctc": ctc,
                          "officelocation": officelocation,
                          "description": description
                        });
                      }

                      if (action == 'update') {
                        // Update the product
                        await _jobss.doc(documentSnapshot!.id).update({
                          "jobtitle": jobtitle,
                          "ctc": ctc,
                          "officelocation": officelocation,
                          "description": description
                        });
                      }

                      // Clear the text fields
                      _jobTitleController.text = '';
                      _ctcController.text = '';
                      _officeLocationController.text = '';
                      _descriptionController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Deleting a product by id
  Future<void> _deleteProduct(String productId) async {
    await _jobss.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using StreamBuilder to display all products from Firestore in real-time
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.teal.shade200, Colors.lightGreen.shade200],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: StreamBuilder(
          stream: _jobss.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: Column(
                        children: [
                          Text(documentSnapshot['jobtitle'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.black),),
                          const Padding(padding: EdgeInsets.only(top: 5)),
                          Text(documentSnapshot['ctc'].toString(),style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15,color: Colors.black87
                          ),),
                        ],
                      ),
                      title: Text(documentSnapshot['officelocation'],style: const TextStyle(color: Colors.black54),),
                      subtitle: Text(documentSnapshot['description'],style: const TextStyle(color: Colors.black54),),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            // Press this button to edit a single product
                            IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () =>
                                    _createOrUpdate(documentSnapshot)),
                            // This icon button is used to delete a single product
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () =>
                                    _deleteProduct(documentSnapshot.id)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const Loading();
          },
        ),
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
