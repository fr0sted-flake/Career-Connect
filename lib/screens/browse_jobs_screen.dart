import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:placement_portal/reusable_widgets/loading.dart';

class SeeJobs extends StatefulWidget {
  const SeeJobs({Key? key}) : super(key: key);

  @override
  State<SeeJobs> createState() => _SeeJobsState();
}

class _SeeJobsState extends State<SeeJobs> {
  final CollectionReference _jobss =
      FirebaseFirestore.instance.collection('jobs');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListWheelScrollView(
                        itemExtent: 150,
                        physics: const FixedExtentScrollPhysics(),
                        perspective: 0.001,
                        squeeze: 0.9,
                        offAxisFraction: 0.8,
                        children: List.generate(
                            streamSnapshot.data!.docs.length, (index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return Container(
                            padding: const EdgeInsets.all(12),
                            height: MediaQuery.of(context).size.height / 7,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.white12, Colors.white38],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 12,
                                      color: Colors.black54,
                                      offset: Offset(-3, -3))
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40))),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        IconData(0xe09e,
                                            fontFamily: 'MaterialIcons',
                                            matchTextDirection: true),
                                        color: Colors.white70,
                                        size: 45,
                                      ),
                                      Text(documentSnapshot['jobtitle'],
                                          style: const TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25)),
                                    ],
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Row(children: [
                                        const Icon(
                                          IconData(0xf02fa,
                                              fontFamily: 'MaterialIcons'),
                                          color: Colors.black54,
                                        ),
                                        Text("${documentSnapshot['ctc']} lpa",
                                            style: const TextStyle(
                                                color: Colors.black38,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15))
                                      ])),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                            documentSnapshot['officelocation'],
                                            style: const TextStyle(
                                                color: Colors.black))),
                                  ),
                                  Text(documentSnapshot['description'],
                                      style:
                                          const TextStyle(color: Colors.black)),
                                ]),
                          );
                        }));
                  }
                  return const Loading();
                })));
  }
}
