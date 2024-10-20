class WaterProgress {
  final int mount;

  DateTime timestamp;
  final String userId;

  WaterProgress({
    required this.mount,
    required this.timestamp,
    required this.userId,


  });

  // transforme map or jison to object
  factory WaterProgress.fromMap(Map<String, dynamic> map) {
    return WaterProgress(
      mount: map['mount'] ?? 0,
      timestamp: map['timestamp'] ?? " ",
      userId: map['userId'] ??" ",

    );
  }

  // transform data to map or jison to be able upload them
  Map<String, dynamic> toMap() {
    return {
      ' mount':mount,
      ' timestamp':timestamp,
      'userId': userId,

    };
  }
}