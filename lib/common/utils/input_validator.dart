class InputValidationResult {
  final bool successful;
  final String? errorMessage;

  const InputValidationResult._({
    required this.successful,
    this.errorMessage,
  });

  const InputValidationResult.success() : this._(successful: true);
  const InputValidationResult.fail(String? errorMessage)
      : this._(successful: false, errorMessage: errorMessage);
}

mixin InputValidator {
  static const campaignTitleMinLength = 10;
  static const campaignTitleMaxLength = 300;
  static const campaignDescriptionMinLength = 100;
  static const campaignDescriptionMaxLength = 2000;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required!";
    }
    // Regular expression for email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address!";
    }
    return null; // Return null if validation passes
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required!";
    }

    final passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).{6,}$');
    if (!passwordRegex.hasMatch(value)) {
      return "Password must contain at least 1 letter, 1 digit, and have a minimum length of 6 characters!";
    }
    return null; // Return null if validation passes
  }

  InputValidationResult validateCampaignTargetAmount(String? amount) {
    if (amount == null) {
      return const InputValidationResult.fail('Amount is required');
    }
    int? amountInt = int.tryParse(amount);
    if (amountInt == null) {
      return const InputValidationResult.fail('Amount is required');
    }
    if (amountInt <= 500) {
      return const InputValidationResult.fail(
          'Amount must be greater than RM500');
    }
    return const InputValidationResult.success();
  }

  InputValidationResult validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null) {
      return const InputValidationResult.fail('Phone number is required');
    }
    // Replace '-'
    final formattedPhoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
    if (formattedPhoneNumber.length < 9 || formattedPhoneNumber.length > 10) {
      return const InputValidationResult.fail('Invalid phone number format');
    }
    return const InputValidationResult.success();
  }

  InputValidationResult validateState(String? stateId) {
    if (stateId == null) {
      return const InputValidationResult.fail('Please select a state');
    }
    return const InputValidationResult.success();
  }

  InputValidationResult validateCampaignCategory(String? categoryId) {
    if (categoryId == null) {
      return const InputValidationResult.fail('Please select a category');
    }
    return const InputValidationResult.success();
  }

  InputValidationResult validateFullName(String? fullName) {
    if (fullName == null || fullName.isEmpty) {
      return const InputValidationResult.fail('Full name is required');
    }
    return const InputValidationResult.success();
  }

  InputValidationResult validateStringWithMinMaxLength(
      {required String title,
      required String? value,
      int minLength = 3,
      int maxLength = 50}) {
    if (value == null || value.isEmpty) {
      return InputValidationResult.fail('$title is required');
    }
    if (value.length < minLength) {
      return InputValidationResult.fail(
          '$title too short! $title should have at least $minLength character');
    }
    if (value.length > maxLength) {
      return InputValidationResult.fail(
          '$title too long! $title should not longer than $maxLength character');
    }
    return const InputValidationResult.success();
  }
}
