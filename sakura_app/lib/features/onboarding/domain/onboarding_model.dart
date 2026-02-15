import 'dart:io';
import 'package:flutter/foundation.dart';
import 'enums.dart';

class OnboardingModel extends ChangeNotifier
{
    String? phoneNumber;
    String? verificationId;
    String? email;
    UserType? userType;

    //phase 3 (common + diverging)
    final Set<ServiceKind> clientInterests = {};
    //Freelancer path
    final Set<ServiceKind> servicesOffered = {};
    final Map<ServiceKind, num> pricing = {};

    //common
    Gender? gender;
    DateTime? birthday;
    String? locationText; //keep it simple (integrate Places later)
    final Set<Gender> interests = {}; // who the user is interestd in
    final List<File> photos = []; // Local files selected (uploaded later)
    String description = '';

    // helpers to mutate + notify UI
    void setPhone(String v) { phoneNumber = v; notifyListeners(); }
    void setVerificationId(String v) { verificationId = v; notifyListeners(); }
    void setEmail(String v) { email = v; notifyListeners(); }
    void setUserType(UserType v) { userType = v; notifyListeners(); }
    void setGender(Gender v) { gender = v; notifyListeners(); }
    void setBirthday(DateTime v) { birthday = v; notifyListeners(); }
    void setLocation(String v) { locationText = v; notifyListeners(); }
    void setDescription(String v) { description = v; notifyListeners(); }
}

