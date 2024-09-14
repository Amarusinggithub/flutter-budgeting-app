import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HelpAndSupportProvider extends ChangeNotifier {
  final List<String> _helpTopics = [
    'How to create a budget',
    'Tracking expenses',
    'Managing categories',
    'Setting up notifications'
  ];

  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: 'email@gmail.com',
    queryParameters: {
      'subject': "Costumer Support",
      'body': "",
    },
  );

  List<String> _filteredHelpTopics;

  HelpAndSupportProvider()
      : _filteredHelpTopics = [
          'How to create a budget',
          'Tracking expenses',
          'Managing categories',
          'Setting up notifications'
        ];

  List<String> get filteredHelpTopics => _filteredHelpTopics;

  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  void updateSearchQuery(String query) {
    _searchQuery = query;
    _filteredHelpTopics = _helpTopics
        .where(
            (topic) => topic.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void clearSearchQuery() {
    _searchQuery = '';
    _filteredHelpTopics = _helpTopics;
    notifyListeners();
  }

  Future<void> _openUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> callSupport() async {
    await _openUrl('tel:${917600896744}');
  }

  Future<void> emailSupport() async {
    await _openUrl(emailUri.toString());
  }

  Future<void> smsSupport() async {
    _openUrl('sms:${917600896744}');
  }
}
