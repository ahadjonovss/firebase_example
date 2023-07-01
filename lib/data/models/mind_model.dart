class MindModel {
  String mind;
  String author;
  String docId;
  MindModel({required this.author, required this.mind,this.docId=''});


  toJson()=>{
    "mind":mind,
    "author":author,
    "docId":docId
  };


  factory MindModel.fromJson(Map<String,dynamic> json){
    return MindModel(author: json["author"], mind: json["mind"],docId: json["docId"]);
  }
}
