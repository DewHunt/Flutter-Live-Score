import 'package:flutter/material.dart';
import 'package:live_score/entities/football_entity.dart';

class FootballScoreCard extends StatelessWidget {
  const FootballScoreCard({
    super.key,
    required this.footballEntity,
  });

  final FootballEntity footballEntity;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTeamScore(
              footballEntity.teamAName,
              footballEntity.teamAScore,
            ),
            const Text(
              "VS",
              style: TextStyle(
                color: Colors.red,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildTeamScore(
              footballEntity.teamBName,
              footballEntity.teamBScore,
            ),
          ],
        ),
      ),
    );
  }

  Column _buildTeamScore(String teamName, int score) {
    return Column(
      children: [
        Text(
          score.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          teamName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
