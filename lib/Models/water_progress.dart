class WaterProgress {
  final int amount;

  DateTime timestamp;
  final String userId;

  WaterProgress({
    required this.amount,
    required this.timestamp,
    required this.userId,


  });

  // transforme map or jison to object
  factory WaterProgress.fromMap(Map<String, dynamic> map) {
    return WaterProgress(
      amount: map['amount'] ?? 0,
      timestamp: map['timestamp'] ?? " ",
      userId: map['userId'] ??" ",

    );
  }

  // transform data to map or jison to be able upload them
  Map<String, dynamic> toMap() {
    return {
      ' amount':amount,
      ' timestamp':timestamp,
      'userId': userId,

    };
  }
}