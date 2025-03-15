// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign In`
  String get sign_in {
    return Intl.message(
      'Sign In',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get user_name {
    return Intl.message(
      'User Name',
      name: 'user_name',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get remembrer_me {
    return Intl.message(
      'Remember Me',
      name: 'remembrer_me',
      desc: '',
      args: [],
    );
  }

  /// `Search Student or Class`
  String get search_student_or_class {
    return Intl.message(
      'Search Student or Class',
      name: 'search_student_or_class',
      desc: '',
      args: [],
    );
  }

  /// `Attendance`
  String get attendance {
    return Intl.message(
      'Attendance',
      name: 'attendance',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Add Class`
  String get add_class {
    return Intl.message(
      'Add Class',
      name: 'add_class',
      desc: '',
      args: [],
    );
  }

  /// `Class Name`
  String get class_name {
    return Intl.message(
      'Class Name',
      name: 'class_name',
      desc: '',
      args: [],
    );
  }

  /// `Group Name`
  String get group_name {
    return Intl.message(
      'Group Name',
      name: 'group_name',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Scan`
  String get scan {
    return Intl.message(
      'Scan',
      name: 'scan',
      desc: '',
      args: [],
    );
  }

  /// `Student Name`
  String get student_name {
    return Intl.message(
      'Student Name',
      name: 'student_name',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Parent's Phone`
  String get parent_phone {
    return Intl.message(
      'Parent\'s Phone',
      name: 'parent_phone',
      desc: '',
      args: [],
    );
  }

  /// `Student Code`
  String get student_code {
    return Intl.message(
      'Student Code',
      name: 'student_code',
      desc: '',
      args: [],
    );
  }

  /// `Generate`
  String get generate {
    return Intl.message(
      'Generate',
      name: 'generate',
      desc: '',
      args: [],
    );
  }

  /// `Full Data of Student`
  String get full_data_of_student {
    return Intl.message(
      'Full Data of Student',
      name: 'full_data_of_student',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'welcome back' key

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Delete User`
  String get delete_user {
    return Intl.message(
      'Delete User',
      name: 'delete_user',
      desc: '',
      args: [],
    );
  }

  /// `Add User`
  String get add_user {
    return Intl.message(
      'Add User',
      name: 'add_user',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get sign_out {
    return Intl.message(
      'Sign Out',
      name: 'sign_out',
      desc: '',
      args: [],
    );
  }

  /// `Allow this user to delete other users`
  String get make_this_user_can_delete_other_user {
    return Intl.message(
      'Allow this user to delete other users',
      name: 'make_this_user_can_delete_other_user',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'make_this_user_can\'t_delete_other_user' key

  // skipped getter for the 'email_can\'t_be_empty' key

  /// `this filed cant't be empty`
  String get this_filed_cant_be_empty {
    return Intl.message(
      'this filed cant\'t be empty',
      name: 'this_filed_cant_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `password must be at least 6 character`
  String get Password_must_be_at_least_6_characters {
    return Intl.message(
      'password must be at least 6 character',
      name: 'Password_must_be_at_least_6_characters',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Wrong number`
  String get wrong_number {
    return Intl.message(
      'Wrong number',
      name: 'wrong_number',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get no_data {
    return Intl.message(
      'No data',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back`
  String get welcome_back {
    return Intl.message(
      'Welcome back',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Choose class and group number`
  String get choose_class_and_group_no {
    return Intl.message(
      'Choose class and group number',
      name: 'choose_class_and_group_no',
      desc: '',
      args: [],
    );
  }

  /// `Attend at`
  String get attend_at {
    return Intl.message(
      'Attend at',
      name: 'attend_at',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
