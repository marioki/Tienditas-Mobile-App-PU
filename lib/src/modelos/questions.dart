// To parse this JSON data, do
//
//     final questions = questionsFromJson(jsonString);

import 'dart:convert';

Questions questionsFromJson(String str) => Questions.fromJson(json.decode(str));

String questionsToJson(Questions data) => json.encode(data.toJson());

class Questions {
    Questions({
        this.statusCode,
        this.body,
    });

    int statusCode;
    Body body;

    factory Questions.fromJson(Map<String, dynamic> json) => Questions(
        statusCode: json["statusCode"],
        body: Body.fromJson(json["body"]),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "body": body.toJson(),
    };
}

class Body {
    Body({
        this.questions,
    });

    List<Question> questions;

    factory Body.fromJson(Map<String, dynamic> json) => Body(
        questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
    };
}

class Question {
    Question({
        this.question,
        this.answer,
    });

    String question;
    String answer;

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["question"],
        answer: json["answer"],
    );

    Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
    };
}
