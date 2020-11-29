class Dept {
  List<Subject> subject;

  Dept({this.subject});

  Dept.fromJson(Map<String, dynamic> json) {
    if (json['subject'] != null) {
      subject = new List<Subject>();
      json['subject'].forEach((v) {
        subject.add(new Subject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subject != null) {
      data['subject'] = this.subject.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subject {
  List<Topics> topics;
  String name;

  Subject({this.topics, this.name});

  Subject.fromJson(Map<String, dynamic> json) {
    if (json['topics'] != null) {
      topics = new List<Topics>();
      json['topics'].forEach((v) {
        topics.add(new Topics.fromJson(v));
      });
    }
    name = json['name'] ?? 'no name found';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topics != null) {
      data['topics'] = this.topics.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    return data;
  }
}

class Topics {
  String youtubeLink;
  String topicName;
  String pdfLink;
  String audiobookLink;

  Topics({this.youtubeLink, this.topicName, this.pdfLink, this.audiobookLink});

  Topics.fromJson(Map<String, dynamic> json) {
    youtubeLink = json['youtube_link'];
    topicName = json['topic_name'];
    pdfLink = json['pdf_link'];
    audiobookLink = json['audiobook_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['youtube_link'] = this.youtubeLink;
    data['topic_name'] = this.topicName;
    data['pdf_link'] = this.pdfLink;
    data['audiobook_link'] = this.audiobookLink;
    return data;
  }
}
