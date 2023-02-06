class EventModel {
  String? kind;
  String? etag;
  String? summary;
  String? updated;
  String? timeZone;
  String? accessRole;
  List<DefaultReminders>? defaultReminders;
  String? nextSyncToken;
  List<Items>? items;

  EventModel(
      {this.kind,
        this.etag,
        this.summary,
        this.updated,
        this.timeZone,
        this.accessRole,
        this.defaultReminders,
        this.nextSyncToken,
        this.items});

  EventModel.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    summary = json['summary'];
    updated = json['updated'];
    timeZone = json['timeZone'];
    accessRole = json['accessRole'];
    if (json['defaultReminders'] != null) {
      defaultReminders = <DefaultReminders>[];
      json['defaultReminders'].forEach((v) {
        defaultReminders!.add(DefaultReminders.fromJson(v));
      });
    }
    nextSyncToken = json['nextSyncToken'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = kind;
    data['etag'] = etag;
    data['summary'] = summary;
    data['updated'] = updated;
    data['timeZone'] = timeZone;
    data['accessRole'] = accessRole;
    if (defaultReminders != null) {
      data['defaultReminders'] =
          defaultReminders!.map((v) => v.toJson()).toList();
    }
    data['nextSyncToken'] = nextSyncToken;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DefaultReminders {
  String? method;
  int? minutes;

  DefaultReminders({this.method, this.minutes});

  DefaultReminders.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    minutes = json['minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['method'] = method;
    data['minutes'] = minutes;
    return data;
  }
}

class Items {
  String? kind;
  String? etag;
  String? id;
  String? status;
  String? htmlLink;
  String? created;
  String? updated;
  String? summary;
  Creator? creator;
  Creator? organizer;
  Start? start;
  Start? end;
  String? iCalUID;
  int? sequence;
  String? hangoutLink;
  ConferenceData? conferenceData;
  Reminders? reminders;
  String? eventType;
  List<Attendees>? attendees;
  bool? guestsCanInviteOthers;
  bool? guestsCanSeeOtherGuests;
  String? description;
  String? location;
  String? colorId;

  Items(
      {this.kind,
        this.etag,
        this.id,
        this.status,
        this.htmlLink,
        this.created,
        this.updated,
        this.summary,
        this.creator,
        this.organizer,
        this.start,
        this.end,
        this.iCalUID,
        this.sequence,
        this.hangoutLink,
        this.conferenceData,
        this.reminders,
        this.eventType,
        this.attendees,
        this.guestsCanInviteOthers,
        this.guestsCanSeeOtherGuests,
        this.description,
        this.location,
        this.colorId});

  Items.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'];
    status = json['status'];
    htmlLink = json['htmlLink'];
    created = json['created'];
    updated = json['updated'];
    summary = json['summary'];
    creator =
    json['creator'] != null ? Creator.fromJson(json['creator']) : null;
    organizer = json['organizer'] != null
        ? Creator.fromJson(json['organizer'])
        : null;
    start = json['start'] != null ? Start.fromJson(json['start']) : null;
    end = json['end'] != null ? Start.fromJson(json['end']) : null;
    iCalUID = json['iCalUID'];
    sequence = json['sequence'];
    hangoutLink = json['hangoutLink'];
    conferenceData = json['conferenceData'] != null
        ? ConferenceData.fromJson(json['conferenceData'])
        : null;
    reminders = json['reminders'] != null
        ? Reminders.fromJson(json['reminders'])
        : null;
    eventType = json['eventType'];
    if (json['attendees'] != null) {
      attendees = <Attendees>[];
      json['attendees'].forEach((v) {
        attendees!.add(Attendees.fromJson(v));
      });
    }
    guestsCanInviteOthers = json['guestsCanInviteOthers'];
    guestsCanSeeOtherGuests = json['guestsCanSeeOtherGuests'];
    description = json['description'];
    location = json['location'];
    colorId = json['colorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['kind'] = kind;
    data['etag'] = etag;
    data['id'] = id;
    data['status'] = status;
    data['htmlLink'] = htmlLink;
    data['created'] = created;
    data['updated'] = updated;
    data['summary'] = summary;
    if (creator != null) {
      data['creator'] = creator!.toJson();
    }
    if (organizer != null) {
      data['organizer'] = organizer!.toJson();
    }
    if (start != null) {
      data['start'] = start!.toJson();
    }
    if (end != null) {
      data['end'] = end!.toJson();
    }
    data['iCalUID'] = iCalUID;
    data['sequence'] = sequence;
    data['hangoutLink'] = hangoutLink;
    if (conferenceData != null) {
      data['conferenceData'] = conferenceData!.toJson();
    }
    if (reminders != null) {
      data['reminders'] = reminders!.toJson();
    }
    data['eventType'] = eventType;
    if (attendees != null) {
      data['attendees'] = attendees!.map((v) => v.toJson()).toList();
    }
    data['guestsCanInviteOthers'] = guestsCanInviteOthers;
    data['guestsCanSeeOtherGuests'] = guestsCanSeeOtherGuests;
    data['description'] = description;
    data['location'] = location;
    data['colorId'] = colorId;
    return data;
  }
}

class Creator {
  String? email;
  bool? self;
  String? displayName;

  Creator({this.email, this.self, this.displayName});

  Creator.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    self = json['self'];
    displayName = json['displayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    data['self'] = self;
    data['displayName'] = displayName;
    return data;
  }
}

class Start {
  String? dateTime;
  String? timeZone;

  Start({this.dateTime, this.timeZone});

  Start.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    timeZone = json['timeZone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['dateTime'] = dateTime;
    data['timeZone'] = timeZone;
    return data;
  }
}

class ConferenceData {
  List<EntryPoints>? entryPoints;
  ConferenceSolution? conferenceSolution;
  String? conferenceId;
  CreateRequest? createRequest;

  ConferenceData(
      {this.entryPoints,
        this.conferenceSolution,
        this.conferenceId,
        this.createRequest});

  ConferenceData.fromJson(Map<String, dynamic> json) {
    if (json['entryPoints'] != null) {
      entryPoints = <EntryPoints>[];
      json['entryPoints'].forEach((v) {
        entryPoints!.add(EntryPoints.fromJson(v));
      });
    }
    conferenceSolution = json['conferenceSolution'] != null
        ? ConferenceSolution.fromJson(json['conferenceSolution'])
        : null;
    conferenceId = json['conferenceId'];
    createRequest = json['createRequest'] != null
        ? CreateRequest.fromJson(json['createRequest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (entryPoints != null) {
      data['entryPoints'] = entryPoints!.map((v) => v.toJson()).toList();
    }
    if (conferenceSolution != null) {
      data['conferenceSolution'] = conferenceSolution!.toJson();
    }
    data['conferenceId'] = conferenceId;
    if (createRequest != null) {
      data['createRequest'] = createRequest!.toJson();
    }
    return data;
  }
}

class EntryPoints {
  String? entryPointType;
  String? uri;
  String? label;
  String? regionCode;
  String? pin;

  EntryPoints(
      {this.entryPointType, this.uri, this.label, this.regionCode, this.pin});

  EntryPoints.fromJson(Map<String, dynamic> json) {
    entryPointType = json['entryPointType'];
    uri = json['uri'];
    label = json['label'];
    regionCode = json['regionCode'];
    pin = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['entryPointType'] = entryPointType;
    data['uri'] = uri;
    data['label'] = label;
    data['regionCode'] = regionCode;
    data['pin'] = pin;
    return data;
  }
}

class ConferenceSolution {
  Key_? key;
  String? name;
  String? iconUri;

  ConferenceSolution({this.key, this.name, this.iconUri});

  ConferenceSolution.fromJson(Map<String, dynamic> json) {
    key = json['key'] != null ? Key_.fromJson(json['key']) : null;
    name = json['name'];
    iconUri = json['iconUri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (key != null) {
      data['key'] = key!.toJson();
    }
    data['name'] = name;
    data['iconUri'] = iconUri;
    return data;
  }
}

class Key_ {
  String? type;

  Key_({this.type});

  Key_.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    return data;
  }
}

class CreateRequest {
  String? requestId;
  Key_? conferenceSolutionKey;
  Status? status;

  CreateRequest({this.requestId, this.conferenceSolutionKey, this.status});

  CreateRequest.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    conferenceSolutionKey = json['conferenceSolutionKey'] != null
        ? Key_.fromJson(json['conferenceSolutionKey'])
        : null;
    status =
    json['status'] != null ? Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['requestId'] = requestId;
    if (conferenceSolutionKey != null) {
      data['conferenceSolutionKey'] = conferenceSolutionKey!.toJson();
    }
    if (status != null) {
      data['status'] = status!.toJson();
    }
    return data;
  }
}

class Status {
  String? statusCode;

  Status({this.statusCode});

  Status.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['statusCode'] = statusCode;
    return data;
  }
}

class Reminders {
  bool? useDefault;

  Reminders({this.useDefault});

  Reminders.fromJson(Map<String, dynamic> json) {
    useDefault = json['useDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['useDefault'] = useDefault;
    return data;
  }
}

class Attendees {
  String? email;
  bool? self;
  String? responseStatus;
  bool? organizer;

  Attendees({this.email, this.self, this.responseStatus, this.organizer});

  Attendees.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    self = json['self'];
    responseStatus = json['responseStatus'];
    organizer = json['organizer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    data['self'] = self;
    data['responseStatus'] = responseStatus;
    data['organizer'] = organizer;
    return data;
  }
}