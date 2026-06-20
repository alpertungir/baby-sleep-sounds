import '../../models/sound_category.dart';
import '../../models/sound_item.dart';

const _image = 'assets/images/app/classic-music.png';

const classicSounds = <SoundItem>[
  SoundItem(id: 'cl_albinoni_adagio', name: 'Albinoni Adagio', categoryId: SoundCategoryId.classic, audioPath: 'assets/sounds/classic/albinoni_adagio.wav', imagePath: _image),
  SoundItem(id: 'cl_ave_maria', name: 'Ave Maria', categoryId: SoundCategoryId.classic, audioPath: 'assets/sounds/classic/ave_maria.wav', imagePath: _image),
  SoundItem(id: 'cl_canon_in_d', name: 'Canon in D', categoryId: SoundCategoryId.classic, audioPath: 'assets/sounds/classic/canon_in_d.wav', imagePath: _image),
  SoundItem(id: 'cl_chopin_nocturne', name: 'Chopin Nocturne', categoryId: SoundCategoryId.classic, audioPath: 'assets/sounds/classic/chopin_nocturne.wav', imagePath: _image),
  SoundItem(id: 'cl_clair_de_lune', name: 'Clair de Lune', categoryId: SoundCategoryId.classic, audioPath: 'assets/sounds/classic/clair_de_lune.wav', imagePath: _image),
  SoundItem(id: 'cl_grieg_morning_mood', name: 'Grieg Morning Mood', categoryId: SoundCategoryId.classic, audioPath: 'assets/sounds/classic/grieg_morning_mood.wav', imagePath: _image),
  SoundItem(id: 'cl_mozart_lullaby', name: 'Mozart Ninni', categoryId: SoundCategoryId.classic, audioPath: 'assets/sounds/classic/mozart_lullaby.wav', imagePath: _image),
  SoundItem(id: 'cl_schubert_ave_maria', name: 'Schubert Ave Maria', categoryId: SoundCategoryId.classic, audioPath: 'assets/sounds/classic/schubert_ave_maria.wav', imagePath: _image),
  SoundItem(id: 'cl_vivaldi_winter', name: 'Vivaldi Kış', categoryId: SoundCategoryId.classic, audioPath: 'assets/sounds/classic/vivaldi_winter.wav', imagePath: _image),
  SoundItem(id: 'cl_sleeping_beauty_waltz', name: 'Sleeping Beauty Waltz', categoryId: SoundCategoryId.classic, audioPath: 'assets/sounds/classic/sleeping_beauty_waltz.wav', imagePath: _image),
];
