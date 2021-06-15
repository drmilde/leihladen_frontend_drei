class ConfigElement {
  ConfigElement({
    this.key = "",
    this.val = "",
  });

  String key;
  String val;

  factory ConfigElement.fromJson(Map<String, dynamic> json) => ConfigElement(
        key: json["Key"],
        val: json["Val"],
      );

  Map<String, dynamic> toJson() => {
        "Key": key,
        "Val": val,
      };
}
