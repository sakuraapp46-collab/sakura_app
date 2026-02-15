enum UserType { client, freelancer}
enum Gender { man, woman, transMan, transWoman}

enum ServiceKind{
  dates,
  callServices,
  videoCallServices,
  multimediaServices
}

extension Label on ServiceKind {
  String get label => switch(this) {
    ServiceKind.dates => 'Dates',
    ServiceKind.callServices => 'Call Services',
    ServiceKind.videoCallServices => 'Video Call Services',
    ServiceKind.multimediaServices => 'Multimedia Services',
  };
}