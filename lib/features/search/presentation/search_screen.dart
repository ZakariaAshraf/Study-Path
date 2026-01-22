import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:study_path/features/filter/presentation/screens/filter_screen.dart';
import 'package:study_path/features/home/data/model/program_model.dart';

import '../../../core/widgets/default_message_card.dart';
import '../../../core/widgets/university_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final BehaviorSubject<String> _searchQuerySubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _categorySubject =
      BehaviorSubject<String>.seeded('All');

  Stream<List<ProgramModel>> fetchAllProperties() {
    return _firestore.collection('programs').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProgramModel.fromJson({
          ...doc.data(),
          'id': doc.id,
        });
      }).toList();
    });
  }

  List<ProgramModel> _filterProperties({
    required List<ProgramModel> properties,
    required String query,
    required String category,
  }) {
    List<ProgramModel> filtered = properties;

    if (category.isNotEmpty && category != 'All') {
      filtered = filtered
          .where(
            (property) =>
                property.programName.toLowerCase() == category.toLowerCase(),
          )
          .toList();
    }

    if (query.isNotEmpty) {
      filtered = filtered
          .where(
            (property) =>
                property.universityName.toLowerCase().contains(
                  query.toLowerCase(),
                ) ||
                property.universityName.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
    }

    return filtered;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchQuerySubject.close();
    _categorySubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.redAccent.withOpacity(0.1),
                ),
                child: Image.asset(
                  "assets/icons/ic_filter.png",
                  height: 18,
                  width: 18,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(
                decoration: BoxDecoration(
                  border: BoxBorder.all(color: Colors.grey),
                  borderRadius:BorderRadius.circular(12),
                ),
                controller: _searchController,
                onChanged: _searchQuerySubject.add,
              ),
            ),
            Expanded(
              child: StreamBuilder<List<ProgramModel>>(
                stream: Rx.combineLatest3(
                  fetchAllProperties(),
                  _searchQuerySubject.stream.startWith(''),
                  _categorySubject.stream,
                  (
                    List<ProgramModel> properties,
                    String query,
                    String category,
                  ) {
                    return _filterProperties(
                      properties: properties,
                      query: query,
                      category: category,
                    );
                  },
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const DefaultMessageCard(
                      sign: "!",
                      subTitle: "Error fetching properties",
                      title: "Error",
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const DefaultMessageCard(
                      sign: "!",
                      subTitle: "No properties found",
                      title: "No Results",
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return UniversityItem(program: snapshot.data![index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
