import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controller/quiz_controller.dart';

class AnswerOptions extends StatelessWidget {
  String text;
  int index, questionId;
  Function() onPresed;

  AnswerOptions(
      {required this.text,
      required this.index,
      required this.onPresed,
      required this.questionId});

  @override
  Widget build(BuildContext context) {
     return //Container(width: 100,height: 100,color: Colors.yellow,);
     GetBuilder<QUIZCONTROLLER>(
         init: QUIZCONTROLLER(),
    builder: (controller) => InkWell(
               onTap: controller.checkIsQuestionAnswerd(questionId)
                  ? null
                  : onPresed,
              child: Container(
                width: 300,height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      //edit here
                        width: 3, color: controller.getColor(index))),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: '${index + 1}. ',
                            style: Theme.of(context).textTheme.headline6,
                            children: [
                              TextSpan(
                                text: text,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ]),
                      ),
                      if (controller.checkIsQuestionAnswerd(questionId) &&
                          controller.selectedAnsure == index)
                        Container(
                            width: 30,
                            height: 30,
                            padding: EdgeInsets.zero,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: controller.getColor(index),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                shape: BoxShape.circle),
                            child: Icon(
                              controller.getIcon(index),
                              color: Colors.white,
                            ))
                    ],
                  ),
                ),
              ),
            ));
  }
}
/*GetBuilder<QUIZCONTROLLER>(
    //     init: QUIZCONTROLLER(),
    //     builder: (controller) => InkWell(
    //           onTap: controller.checkIsQuestionAnswerd(questionId)
    //               ? null
    //               : onPresed,
    //           child: Container(
    //             width: double.maxFinite,
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(15),
    //                 border: Border.all(
    //                   //edit here
    //                     width: 3, color: controller.getColor(index)!)),
    //             child: Padding(
    //               padding: const EdgeInsets.all(15.0),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   RichText(
    //                     text: TextSpan(
    //                         text: '${index + 1}. ',
    //                         style: Theme.of(context).textTheme.headline6,
    //                         children: [
    //                           TextSpan(
    //                             text: text,
    //                             style: Theme.of(context).textTheme.headline6,
    //                           ),
    //                         ]),
    //                   ),
    //                   if (controller.checkIsQuestionAnswerd(questionId) &&
    //                       controller.selectedAnsure == index)
    //                     Container(
    //                         width: 30,
    //                         height: 30,
    //                         padding: EdgeInsets.zero,
    //                         alignment: Alignment.center,
    //                         decoration: BoxDecoration(
    //                             color: controller.getColor(index),
    //                             border: Border.all(
    //                               color: Colors.white,
    //                               width: 3,
    //                             ),
    //                             shape: BoxShape.circle),
    //                         child: Icon(
    //                           controller.getIcon(index),
    //                           color: Colors.white,
    //                         ))
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ));*/