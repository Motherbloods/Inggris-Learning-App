import 'package:flutter/material.dart';
import '../models/exercise.dart';

class ExerciseWidget extends StatelessWidget {
  final Exercise exercise;
  final Function(String) onAnswerSelected;

  ExerciseWidget({required this.exercise, required this.onAnswerSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              exercise.question,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 24),
            if (exercise.type == 'true_false')
              _buildTrueFalseOptions()
            else if (exercise.type == 'multiple_choice')
              _buildMultipleChoiceOptions()
            else if (exercise.type == 'fill_in_the_blank')
              _buildFillInTheBlankOption(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTrueFalseOptions() {
    return Column(
      children: [
        ElevatedButton(
          child: Text('True'),
          onPressed: () => onAnswerSelected('true'),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          child: Text('False'),
          onPressed: () => onAnswerSelected('false'),
        ),
      ],
    );
  }

  Widget _buildMultipleChoiceOptions() {
    return Column(
      children: exercise.options!
          .map(
            (option) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: ElevatedButton(
                child: Text(option),
                onPressed: () => onAnswerSelected(option),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildFillInTheBlankOption(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'Your Answer',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          child: Text('Submit'),
          onPressed: () {
            if (controller.text.isNotEmpty) {
              onAnswerSelected(controller.text);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please enter an answer'),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
