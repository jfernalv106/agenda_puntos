class MensajeError {
  MensajeError({
    this.msg,
    this.param,
    this.location,
  });

  String msg;
  String param;
  String location;

  factory MensajeError.fromJson(Map<String, dynamic> json) => MensajeError(
    msg: json["msg"],
    param: json["param"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "param": param,
    "location": location,
  };
}