import 'package:get/get.dart';
import '../models/question_model.dart';
import '../supabase_config.dart';

class QuestionController extends GetxController {
  var question = Rxn<Question>();
  var selected = ''.obs;
  var isCorrect = false.obs;

  var correctCount = 0.obs;
  var wrongCount = 0.obs;
  var answeredQuestions = <String>[].obs;

  Future<void> fetchQuestion() async {
    final data = await SupabaseConfig.client
        .from('questions')
        .select()
        .order('created_at', ascending: false)
        .limit(1)
        .single();

    question.value = Question.fromMap(data);
    selected.value = '';
    isCorrect.value = false;
  }

  Future<void> submit() async {
    final q = question.value;
    if (q == null) return;

    if (answeredQuestions.contains(q.id)) return;

    isCorrect.value = selected.value == q.correct;

    if (isCorrect.value) {
      correctCount.value++;
    } else {
      wrongCount.value++;
    }

    answeredQuestions.add(q.id);

    try {
      final userId = SupabaseConfig.client.auth.currentUser?.id;
      if (userId != null) {
        await SupabaseConfig.client.from('answers').insert({
          'user_id': userId,
          'question_id': q.id,
          'user_answer': selected.value,
          'is_correct': isCorrect.value,
        });
        print('Answer submitted successfully');
      } else {
        print('User not logged in, answer not saved');
      }
    } catch (e) {
      print('Error submitting answer: $e');
    }
  }
}
