class TeacherQueList {
  int code;
  String msg;
  List<TeacherQueData> data;

  TeacherQueList({this.code, this.msg, this.data});

  TeacherQueList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<TeacherQueData>();
      json['data'].forEach((v) {
        data.add(new TeacherQueData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeacherQueData {
  int id;
  String name;
  String time;
  String question;
  int person;
  List<Answer> answer;

  TeacherQueData(
      {this.id, this.name, this.time, this.question, this.person, this.answer});

  TeacherQueData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    time = json['time'];
    question = json['question'];
    person = json['person'];
    if (json['answer'] != null) {
      answer = new List<Answer>();
      json['answer'].forEach((v) {
        answer.add(new Answer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['time'] = this.time;
    data['question'] = this.question;
    data['person'] = this.person;
    if (this.answer != null) {
      data['answer'] = this.answer.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answer {
  String stuname;
  String time;
  String content;

  Answer({this.stuname, this.time, this.content});

  Answer.fromJson(Map<String, dynamic> json) {
    stuname = json['stuname'];
    time = json['time'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stuname'] = this.stuname;
    data['time'] = this.time;
    data['content'] = this.content;
    return data;
  }
}