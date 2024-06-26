import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoPlayClass {
  late final Player player;
  late final VideoController controller;
  late Duration _totalPlayTime;
  late DateTime _lastPlayTime;
  late bool _isPlaying;
  late double _lastPlaybackRate;
  VideoPlayClass() {
    try {
      _totalPlayTime = Duration.zero;
      _lastPlayTime = DateTime.now();
      _lastPlaybackRate = 1.0;
      _isPlaying = false;

      player = Player();
      controller = VideoController(player);

      player.open(
        Media(
            'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
        play: false,
      );
    } catch (e) {}
  }
  Future<void> playVideo() async {
    await player.play();
  }

  Future<void> pauseVideo() async {
    await player.pause();
  }

  Future<void> playOrPause() async {
    await player.playOrPause();
  }

  void startTrackingPlayTime() {
    if (!_isPlaying) {
      _lastPlayTime = DateTime.now();
      _lastPlaybackRate = player.state.rate;
      _isPlaying = true;
    }
  }

  void stopTrackingPlayTime() {
    if (_isPlaying) {
      Duration playedTime = DateTime.now().difference(_lastPlayTime);
      _totalPlayTime += playedTime * _lastPlaybackRate;
      _isPlaying = false;
    }
  }

  Duration get totalPlayTime {
    if (_isPlaying) {
      Duration playedTime = DateTime.now().difference(_lastPlayTime);
      return _totalPlayTime + (playedTime * _lastPlaybackRate);
    }
    return _totalPlayTime;
  }
}