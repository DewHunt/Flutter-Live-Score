import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:live_score/entities/football_entity.dart';
import 'package:live_score/ui/widgets/football_score_card.dart';

class MatchListsScreen extends StatefulWidget {
  const MatchListsScreen({super.key});

  @override
  State<MatchListsScreen> createState() => _MatchListsScreenState();
}

class _MatchListsScreenState extends State<MatchListsScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<FootballEntity> footballMatchLists = [];

  @override
  void initState() {
    super.initState();
    _getFootballMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Live Score (Football)",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder(
        stream: firebaseFirestore.collection('football').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (snapshot.hasData == false) {
            return const Center(
              child: Text('No match available right now.'),
            );
          }

          footballMatchLists.clear();
          for (QueryDocumentSnapshot doc in snapshot.data?.docs ?? []) {
            footballMatchLists.add(
              FootballEntity(
                id: doc.id,
                matchName: doc.get('matchName'),
                teamAName: doc.get('teamAName'),
                teamAScore: doc.get('teamAScore'),
                teamBName: doc.get('teamBName'),
                teamBScore: doc.get('teamBScore'),
              ),
            );
          }

          return ListView.builder(
            itemCount: footballMatchLists.length,
            itemBuilder: (context, index) {
              return FootballScoreCard(
                footballEntity: footballMatchLists[index],
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _getFootballMatches() async {
    footballMatchLists.clear();
    final QuerySnapshot results =
        await firebaseFirestore.collection('football').get();

    for (QueryDocumentSnapshot doc in results.docs) {
      footballMatchLists.add(
        FootballEntity(
          id: doc.id,
          matchName: doc.get('matchName'),
          teamAName: doc.get('teamAName'),
          teamAScore: doc.get('teamAScore'),
          teamBName: doc.get('teamBName'),
          teamBScore: doc.get('teamBScore'),
        ),
      );
    }
    setState(() {});
  }
}
