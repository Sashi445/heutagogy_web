class Option{
  final String text;
  final bool value;
  Option({this.value, this.text});

  factory Option.fromJson(Map<String, dynamic> jsonData){
    return Option(
      text: jsonData['text'],
      value: jsonData['value']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'text' : text,
      'value' : value
    };
  }
}