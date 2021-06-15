import 'dart:convert';

class Helper {
  static String encodeUrl(String s) {
    String result = s;
    //result = result.replaceAll("?", "%3F");
    //result = result.replaceAll("/", "%2F");
    result = Uri.encodeComponent(result);
    return result;
  }

  static String decodeUrl(String s) {
    String result = s;
    //result = result.replaceAll("%3F", "?");
    //result = result.replaceAll("%2F", "/");
    //result = Uri.decodeComponent(result);
    return result;
  }

  static String encodeBase64(String s) {
    return utf8.fuse(base64).encode(s);
  }

  static String decodeBase64(String s) {
    return utf8.fuse(base64).decode(s);
  }

  static String encodeContent(String content) {
    return encodeUrl(encodeBase64(content));
  }

  static String decodeContent(String content) {
    return decodeUrl(decodeBase64(content));
  }

  static String usTimeStringToDe(String us) {
    return toTimeStringDe(DateTime.parse(us));
  }

  static String usTimeStringToDeShort(String us) {
    return toTimeStringDeShort(DateTime.parse(us));
  }

  static String toTimeStringDeShort(DateTime dt) {
    String day = "${dt.day}";
    String month = "${dt.month}";

    if (dt.day < 10) {
      day = "0" + day;
    }

    if (dt.month < 10) {
      month = "0" + month;
    }

    return "${day}.${month}.";
  }

  static String toTimeStringDe(DateTime dt) {
    String day = "${dt.day}";
    String month = "${dt.month}";

    if (dt.day < 10) {
      day = "0" + day;
    }

    if (dt.month < 10) {
      month = "0" + month;
    }

    return "${day}.${month}.${dt.year}";
  }

  static String toTimeStringUs(DateTime dt) {
    String day = "${dt.day}";
    String month = "${dt.month}";

    if (dt.day < 10) {
      day = "0" + day;
    }

    if (dt.month < 10) {
      month = "0" + month;
    }

    return "${dt.year}-${month}-${day}";
  }

  static String nowDe() {
    return toTimeStringDe(DateTime.now());
  }

  static String nowUs() {
    return toTimeStringUs(DateTime.now());
  }

  /*
  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
   */

  static String trimUdid(String udid) {
    if (udid.length > 12) {
      return udid.substring(0, 13);
    }
    return udid;
  }

  static DateTime normalizeToFriday(DateTime dt) {
    DateTime result = dt;
    int indexDay = dt.weekday;
    switch (indexDay) {
      case 1:
        {
          // montag
          result = result.add(Duration(days: 4));
          break;
        }
      case 2:
        {
          // dienstag
          result = result.add(Duration(days: 3));
          break;
        }
      case 3:
        {
          // mittwoch
          result = result.add(Duration(days: 2));
          break;
        }
      case 4:
        {
          // donnerstag
          result = result.add(Duration(days: 1));
          break;
        }
      case 5:
        {
          // freitag
          result = result.add(Duration(days: 0));
          break;
        }
      case 6:
        {
          // samstag
          result = result.add(Duration(days: 6));
          break;
        }
      case 7:
        {
          // sonntag
          result = result.add(Duration(days: 5));
          break;
        }
    }
    return result;
  }
}
