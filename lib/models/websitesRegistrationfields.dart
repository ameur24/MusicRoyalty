class WebsitesRegistrationFields {
  Map<String, String> url;
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
  WebsitesRegistrationFields({
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
  });
}
