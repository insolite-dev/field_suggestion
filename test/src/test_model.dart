// A early made model to test [isClassList], [renderClassList] and others...
class TestModel {
  const TestModel({this.title});

  final String? title;

  Map<String, dynamic> toJson() => {'title': this.title};
}
