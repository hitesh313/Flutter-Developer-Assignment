import 'package:shared_preferences/shared_preferences.dart';

/// Thin wrapper around [SharedPreferences] so the rest of the app never
/// touches the plugin directly — keeps storage keys in one place and
/// makes it trivial to swap the backing store later if needed.
class CaptionStorageService {
  static const _captionKeyPrefix = 'smart_post_caption_';
  static const _lastIndexKey = 'smart_post_last_index';

  Future<void> saveCaption(int postIndex, String caption) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_captionKeyPrefix$postIndex', caption);
  }

  Future<String?> loadCaption(int postIndex) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('$_captionKeyPrefix$postIndex');
  }

  Future<void> saveLastPostIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastIndexKey, index);
  }

  Future<int?> loadLastPostIndex() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_lastIndexKey);
  }
}
