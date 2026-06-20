import '../../models/sound_category.dart';
import '../../models/sound_item.dart';

const _image = 'assets/images/app/background-music.png';

const backgroundSounds = <SoundItem>[
  SoundItem(id: 'bg_dreamy_ambient', name: 'Dreamy Ambient', categoryId: SoundCategoryId.background, audioPath: 'assets/sounds/background/dreamy_ambient.wav', imagePath: _image),
  SoundItem(id: 'bg_simple_peaceful_piano', name: 'Simple Peaceful Piano', categoryId: SoundCategoryId.background, audioPath: 'assets/sounds/background/simple_peaceful_piano.wav', imagePath: _image),
  SoundItem(id: 'bg_mystic_dream_piano', name: 'Mystic Dream Piano', categoryId: SoundCategoryId.background, audioPath: 'assets/sounds/background/mystic_dream_piano.wav', imagePath: _image),
  SoundItem(id: 'bg_fur_elise_music_box', name: 'Für Elise Music Box', categoryId: SoundCategoryId.background, audioPath: 'assets/sounds/background/fur_elise_music_box.wav', imagePath: _image),
  SoundItem(id: 'bg_choir_singing', name: 'Choir Singing', categoryId: SoundCategoryId.background, audioPath: 'assets/sounds/background/choir_singing.wav', imagePath: _image),
  SoundItem(id: 'bg_autumn_day', name: 'Autumn Day', categoryId: SoundCategoryId.background, audioPath: 'assets/sounds/background/autumn_day.wav', imagePath: _image),
  SoundItem(id: 'bg_lounge_deep_house', name: 'Lounge Deep House', categoryId: SoundCategoryId.background, audioPath: 'assets/sounds/background/lounge_deep_house.wav', imagePath: _image),
  SoundItem(id: 'bg_ambient_background', name: 'Ambient Background', categoryId: SoundCategoryId.background, audioPath: 'assets/sounds/background/ambient_background.wav', imagePath: _image),
];
