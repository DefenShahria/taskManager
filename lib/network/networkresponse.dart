class Networkresponse{
  final int statusCode;
  final bool issuccess;
  final Map<String, dynamic>? body;

  Networkresponse(this.issuccess,this.statusCode, this.body);
}