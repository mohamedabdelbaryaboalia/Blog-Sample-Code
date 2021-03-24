// * Class To Validate Form Fields
import 'package:flutter/material.dart';
import 'package:homeward_interview_sample_code/services/helpers/form_validator/src/validator_builder.dart';

class MHValidator {
  // ? Function to Validate Password
  static Validator validateEmail(BuildContext context) {
    return ValidationBuilder()
        .email("Email Should be Valid")
        .minLength(6, "Valid Email Shouldn't Be Less Than 6 Characters")
        .maxLength(20, "Valid Email Shouldn't Be More Than 20 Characters")
        .build();
  }

  // ? Function to Validate Password
  static Validator validatePassword(BuildContext context) {
    return ValidationBuilder()
        .minLength(6, "Valid Password Shouldn't Be Less Than 6 Characters")
        .maxLength(20, "Valid Password Shouldn't Be More Than 20 Characters")
        .build();
  }
}

typedef Validator = String? Function(String? text);
