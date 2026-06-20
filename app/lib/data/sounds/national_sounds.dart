import '../../models/sound_category.dart';
import '../../models/sound_item.dart';

const _image = 'assets/images/app/national-music.png';

const nationalSounds = <SoundItem>[
  SoundItem(id: 'na_fr_frere_jacques', name: 'Frère Jacques (FR)', categoryId: SoundCategoryId.national, audioPath: 'assets/sounds/national/fr_frere_jacques.wav', imagePath: _image),
  SoundItem(id: 'na_de_schlaf_kindlein', name: 'Schlaf Kindlein (DE)', categoryId: SoundCategoryId.national, audioPath: 'assets/sounds/national/de_schlaf_kindlein.wav', imagePath: _image),
  SoundItem(id: 'na_es_a_la_ru_ru', name: 'A La Ru Ru (ES)', categoryId: SoundCategoryId.national, audioPath: 'assets/sounds/national/es_a_la_ru_ru.wav', imagePath: _image),
  SoundItem(id: 'na_it_ninna_nanna', name: 'Ninna Nanna (IT)', categoryId: SoundCategoryId.national, audioPath: 'assets/sounds/national/it_ninna_nanna.wav', imagePath: _image),
  SoundItem(id: 'na_ru_bayu_bayushki', name: 'Bayu Bayushki (RU)', categoryId: SoundCategoryId.national, audioPath: 'assets/sounds/national/ru_bayu_bayushki.wav', imagePath: _image),
  SoundItem(id: 'na_en_abc_song', name: 'ABC Song (EN)', categoryId: SoundCategoryId.national, audioPath: 'assets/sounds/national/en_abc_song.wav', imagePath: _image),
  SoundItem(id: 'na_fr_clair_de_lune', name: 'Clair de Lune (FR)', categoryId: SoundCategoryId.national, audioPath: 'assets/sounds/national/fr_clair_de_lune.wav', imagePath: _image),
  SoundItem(id: 'na_es_cancion_de_cuna', name: 'Canción de Cuna (ES)', categoryId: SoundCategoryId.national, audioPath: 'assets/sounds/national/es_cancion_de_cuna.wav', imagePath: _image),
];
