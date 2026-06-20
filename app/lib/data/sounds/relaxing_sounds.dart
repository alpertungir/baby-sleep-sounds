import '../../models/sound_category.dart';
import '../../models/sound_item.dart';

const _image = 'assets/images/app/relaxing-music.png';

const relaxingSounds = <SoundItem>[
  SoundItem(id: 're_forest_birds', name: 'Orman ve Kuşlar', categoryId: SoundCategoryId.relaxing, audioPath: 'assets/sounds/relaxing/forest_birds.wav', imagePath: _image),
  SoundItem(id: 're_calm_ocean', name: 'Sakin Okyanus', categoryId: SoundCategoryId.relaxing, audioPath: 'assets/sounds/relaxing/calm_ocean.wav', imagePath: _image),
  SoundItem(id: 're_rain_thunder', name: 'Yağmur ve Gök Gürültüsü', categoryId: SoundCategoryId.relaxing, audioPath: 'assets/sounds/relaxing/rain_thunder.wav', imagePath: _image),
  SoundItem(id: 're_night_ambience', name: 'Gece Ambiyansı', categoryId: SoundCategoryId.relaxing, audioPath: 'assets/sounds/relaxing/night_ambience.wav', imagePath: _image),
  SoundItem(id: 're_wind_chimes', name: 'Rüzgar Çanları', categoryId: SoundCategoryId.relaxing, audioPath: 'assets/sounds/relaxing/wind_chimes.wav', imagePath: _image),
  SoundItem(id: 're_cicadas', name: 'Cicadalar', categoryId: SoundCategoryId.relaxing, audioPath: 'assets/sounds/relaxing/cicadas.wav', imagePath: _image),
  SoundItem(id: 're_deep_sleep', name: 'Derin Uyku', categoryId: SoundCategoryId.relaxing, audioPath: 'assets/sounds/relaxing/deep_sleep.wav', imagePath: _image),
  SoundItem(id: 're_spring_sounds', name: 'Bahar Sesleri', categoryId: SoundCategoryId.relaxing, audioPath: 'assets/sounds/relaxing/spring_sounds.wav', imagePath: _image),
  SoundItem(id: 're_zen_music', name: 'Zen Müziği', categoryId: SoundCategoryId.relaxing, audioPath: 'assets/sounds/relaxing/zen_music.wav', imagePath: _image),
  SoundItem(id: 're_soothing_sleep', name: 'Sakin Uyku', categoryId: SoundCategoryId.relaxing, audioPath: 'assets/sounds/relaxing/soothing_sleep.wav', imagePath: _image),
];
