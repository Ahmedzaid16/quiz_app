import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/question+model.dart';
import 'package:quiz_app/screens/quiz_screen/quiz_screen.dart';
import 'package:quiz_app/screens/result_screen/result_screen.dart';

class QUIZCONTROLLER extends GetxController{
  String name = '';
  final List <QUESTIONMODEL> _questionList = [
    QUESTIONMODEL(
        id: 1,
        question: 'أي مما يلي هو أصغر كوكب في النظام الشمسي ؟',
        answer: 2,
        options: ['الزهرة','الأرض','نبتون']
    ),
    QUESTIONMODEL(
        id: 2,
        question: 'ما هو أطول نهر في العالم ؟',
        answer: 1,
        options: ['الأمازون','النيل','النهر الأصفر']
    ),
    QUESTIONMODEL(
        id: 3,
        question: 'من هو أول البشر ؟',
        answer: 0,
        options: ['آدم ','نوح','صالح']
    ),
    QUESTIONMODEL(
        id: 4,
        question: 'كم عدد القارات الموجودة على الأرض',
        answer: 2,
        options: ['3 قارات','5 قارات','7 قارات']
    ),
    QUESTIONMODEL(
        id: 5,
        question: 'من هو الصحابي الذي لُقّب بالصديق ؟',
        answer: 2,
        options: ['علي  بن أبي طالب','عمر بن العاص','أبو بكر']
    ),
    QUESTIONMODEL(
        id: 6,
        question: 'عضو في جسم الإنسان ينبض طوال الوقت ؟',
        answer: 0,
        options: ['القلب','العقل','اللسان']
    ),
    QUESTIONMODEL(
        id: 7,
        question: 'ما هو الطائر الذي يستطيع تكرار كلام الإنسان بالتدريب ؟',
        answer: 2,
        options: ['الحمام','البلبل','البغبغاء']
    ),
    QUESTIONMODEL(
        id: 8,
        question: 'شيء يسمع ويتكلم بلا أذن ولا لسان، فما يكون ؟',
        answer: 2,
        options: ['التلفزيون','الساعة','التليفون']
    ),
    QUESTIONMODEL(
        id: 9,
        question: 'ما هو اسم الكوكب الأقرب إلى الشمس ؟',
        answer: 1,
        options: ['المشترى','عطارد','الزهرة']
    ),
    QUESTIONMODEL(
        id: 10,
        question: 'ما هي عاصمة فلسطين ؟',
        answer: 2,
        options: ['رام الله','القاهرة','القدس']
    ),

  ];
  bool _ispresed = false;
  double _numberofQuestions=1;
  int? _selectedAnswer=0;
  int _countofCorrectAnswer=0;
  final RxInt _sec=15.obs;

  int get countOfquestions => _questionList.length;


  List<QUESTIONMODEL> get questionList => [..._questionList];

  bool get ispresed => _ispresed;

  double get numberofQuestions => _numberofQuestions;

  int? get selectedAnsure => _selectedAnswer;

  int get countofCorrectAnswer => _countofCorrectAnswer;

  RxInt get sec => _sec;
  int? _correctAnswer;
  final Map<int,bool> __questionIsAnswerd={};
  Timer? _timer;
  final maxSec =15;
  late PageController pageController;
  @override
  void onInit() {
    // TODO: implement onInit
    pageController = PageController(initialPage: 0);
    resetAnswer();
    super.onInit();
  }
@override
  void onClose() {
    // TODO: implement onClose
  pageController.dispose();
    super.onClose();
  }
  double get scoreResult{

    return _countofCorrectAnswer*100/questionList.length;
  }
  void checkAnswer(QUESTIONMODEL questionmodel,int selectedAnswer){
    _ispresed =true;
    _selectedAnswer = selectedAnswer;
    _correctAnswer = questionmodel.answer;
    if(_correctAnswer==_selectedAnswer)
      {
        _countofCorrectAnswer++;
      }
    stoptimer();
    __questionIsAnswerd.update(questionmodel.id, (value) => true);
    Future.delayed(const Duration(milliseconds: 500)).then((value) => nextQuestion());
    update();
  }
  bool checkIsQuestionAnswerd(int questionId){
    return __questionIsAnswerd.entries
        .firstWhere((element) => element.key==questionId)
        .value;
  }
  void resetAnswer() {
    for(var element in _questionList )
      {
        __questionIsAnswerd.addAll({element.id: false});
      }
  }

  void stoptimer()=>_timer!.cancel();

  nextQuestion() {
    if (_timer !=null || _timer!.isActive){
      stoptimer();
    }
    if (pageController.page == _questionList.length - 1) {
      Get.offAndToNamed(ResultScreen.routeName);
    } else {
      _ispresed = false;
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.linear);

      startTimer();
    }
    _numberofQuestions = pageController.page!+2;
    update();
  }

  Color getColor (int answerIndex)
  {
    if(_ispresed)
      {
        if(answerIndex==_correctAnswer)
          {
            return Colors.green;
          }
        else if(answerIndex==_selectedAnswer && _correctAnswer!= _selectedAnswer){
          return Colors.red;
        }
      }
    return Colors.white;
  }
  IconData getIcon (int answerIndex)
  {
    if(_ispresed)
      {
        if(answerIndex==_correctAnswer)
          {
            return Icons.done;
          }
        else if(answerIndex==_selectedAnswer && _correctAnswer!= _selectedAnswer){
          return Icons.close;
        }
      }
    return Icons.close;
  }

  void startTimer() {
    resetTimer();
    _timer=Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_sec.value>0)
        {
          _sec.value--;
        }
      else
        {
          stoptimer();
          nextQuestion();
        }
    });
  }

  void resetTimer()=>_sec.value=maxSec;
  void staragain()
  {
    Get.offAndToNamed(QuizScreen.routeName);
    _correctAnswer=null;
    _countofCorrectAnswer=0;
    _selectedAnswer=null;
    resetAnswer();
  }
}
