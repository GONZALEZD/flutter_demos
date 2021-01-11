abstract class DBObject {
  int id;

  DBObject({this.id});

  Map<String, dynamic> get attributes;
}

class CreditCard extends DBObject {
  final String lastName;
  final String type;
  final String cardNumber;
  final String cryptogram;
  final DateTime expiration;

  CreditCard._({this.lastName, this.type, this.cardNumber, this.cryptogram, this.expiration, int dbId,}):
        super(id: dbId);

  factory CreditCard.fromMap({Map<String, dynamic> data}) {
    return CreditCard._(
      dbId: data["id"],
      lastName: data["last_name"],
      type: data["type"],
      cardNumber: data["card_id"],
      cryptogram: data["cryptogram"],
      expiration: DateTime(data["expiration_year"], data["expiration_month"]),
    );
  }

  factory CreditCard.card({String lastName, String type, String cardNumber, String cryptogram, DateTime expiration}) {
    return CreditCard._(
      lastName: lastName,
      type: type,
      cardNumber: cardNumber,
      cryptogram: cryptogram,
      expiration: expiration,
    );
  }

  @override
  Map<String, dynamic> get attributes {
    var data = {
      "last_name": lastName,
      "type": type,
      "card_id": cardNumber,
      "cryptogram": cryptogram,
      "expiration_month": expiration.month,
      "expiration_year": expiration.year,
    };
    if (this.id != null) {
      data["id"] = this.id;
    }
    return data;
  }
}