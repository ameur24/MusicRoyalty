class WebsitesRegistrationFields {
  Map<String, String> url;
  String musictitle;
  String stepid;
  String sousstepid;
  String fnamefield;
  String lnamefield;
  String fullname;
  String middlenamefield;
  String emailfield;
  String adressfield;
  String statefield;
  String datefield;
  String phonenumberfield;
  String zipfield;
  bool autofill;
  String publisherfnamefield;
  String publisherlnamefield;
  String publisherfullname;
  String publishermiddlenamefield;
  String publisheremailfield;
  String publisheradressfield;
  String publisherstatefield;
  String publisherdatefield;
  String publisherphonenumberfield;
  String publisherzipfield;
  WebsitesRegistrationFields({
    required this.musictitle,
    required this.url,
    required this.stepid,
    required this.sousstepid,
    required this.fnamefield,
    required this.lnamefield,
    this.fullname = "",
    this.middlenamefield = "",
    required this.emailfield,
    required this.adressfield,
    required this.statefield,
    required this.datefield,
    required this.phonenumberfield,
    required this.zipfield,
    required this.autofill,
    required this.publisherfnamefield,
    required this.publisherlnamefield,
    this.publisherfullname = "",
    this.publishermiddlenamefield = "",
    required this.publisheremailfield,
    required this.publisheradressfield,
    required this.publisherstatefield,
    required this.publisherdatefield,
    required this.publisherphonenumberfield,
    required this.publisherzipfield,
  });
}
