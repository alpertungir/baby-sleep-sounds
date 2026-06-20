#!/usr/bin/env python3
"""Generate loopable placeholder WAV files for the sound catalog."""

from __future__ import annotations

import hashlib
import math
import random
import struct
import wave
from pathlib import Path

SAMPLE_RATE = 44100
DURATION_SECONDS = 10
BASE = Path(__file__).resolve().parents[1] / "assets" / "sounds"


def seed_from(name: str) -> random.Random:
    digest = hashlib.sha256(name.encode()).hexdigest()
    return random.Random(int(digest[:16], 16))


def write_wav(path: Path, samples: list[float]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with wave.open(str(path), "w") as handle:
        handle.setnchannels(1)
        handle.setsampwidth(2)
        handle.setframerate(SAMPLE_RATE)
        frames = b"".join(
            struct.pack("<h", max(-32767, min(32767, int(sample))))
            for sample in samples
        )
        handle.writeframes(frames)


def sample_count() -> int:
    return SAMPLE_RATE * DURATION_SECONDS


def white_noise(rng: random.Random, amp: float = 0.12) -> list[float]:
    return [rng.uniform(-1, 1) * amp for _ in range(sample_count())]


def pink_noise(rng: random.Random, amp: float = 0.14) -> list[float]:
    b0 = b1 = b2 = b3 = b4 = b5 = b6 = 0.0
    output: list[float] = []
    for _ in range(sample_count()):
        white = rng.uniform(-1, 1)
        b0 = 0.99886 * b0 + white * 0.0555179
        b1 = 0.99332 * b1 + white * 0.0750759
        b2 = 0.96900 * b2 + white * 0.1538520
        b3 = 0.86650 * b3 + white * 0.3104856
        b4 = 0.55000 * b4 + white * 0.5329522
        b5 = -0.7616 * b5 - white * 0.0168980
        pink = b0 + b1 + b2 + b3 + b4 + b5 + b6 + white * 0.5362
        b6 = white * 0.115926
        output.append(pink * amp * 0.11)
    return output


def brown_noise(rng: random.Random, amp: float = 0.16) -> list[float]:
    last = 0.0
    output: list[float] = []
    for _ in range(sample_count()):
        last = (last + rng.uniform(-1, 1) * 0.1) * 0.99
        output.append(last * amp)
    return output


def mix(*arrays: list[float]) -> list[float]:
    return [sum(values) for values in zip(*arrays)]


def melody(rng: random.Random, freqs: list[float], amp: float = 0.05) -> list[float]:
    count = sample_count()
    output = [0.0] * count
    for index, freq in enumerate(freqs):
        phase = rng.random() * math.pi
        for i in range(count):
            envelope = 0.5 + 0.5 * math.sin(2 * math.pi * (index + 1) * i / count)
            output[i] += math.sin(2 * math.pi * freq * i / SAMPLE_RATE + phase) * amp * envelope
    return output


def generate(category: str, slug: str) -> None:
    rng = seed_from(f"{category}/{slug}")
    generators = {
        "whitenoise": lambda: mix(pink_noise(rng, 0.1), white_noise(rng, 0.05)),
        "lullaby": lambda: melody(rng, [330, 392, 440, 494]),
        "turkish_lullaby": lambda: melody(rng, [294, 349, 392, 440]),
        "classic": lambda: melody(rng, [220, 277, 330, 415], amp=0.04),
        "background": lambda: mix(pink_noise(rng, 0.04), melody(rng, [196, 247, 294], amp=0.025)),
        "national": lambda: melody(rng, [262, 311, 349, 392], amp=0.045),
        "relaxing": lambda: mix(brown_noise(rng, 0.07), pink_noise(rng, 0.04)),
    }
    samples = generators[category]()
    write_wav(BASE / category / f"{slug}.wav", samples)


MANIFEST = {
    "whitenoise": [
        "blender",
        "dryer",
        "fan",
        "heater",
        "motor",
        "ocean",
        "pure_noise",
        "rain",
        "refrigerator",
        "shower",
        "storm",
        "stream",
        "underwater",
        "vacuum",
        "waves",
        "water_boiling",
        "waterfall",
    ],
    "lullaby": [
        "bed_time",
        "dreaming_angel",
        "goodnight_for_you",
        "hush_little_baby",
        "bath_time",
        "lullaby_goodnight",
        "pretty_little_horses",
        "rock_bye_baby",
        "sarabande_handel",
        "twinkle_little_star",
    ],
    "turkish_lullaby": [
        "uyusun_da_buyusun",
        "dandini_dastana",
        "esekli_ninni",
        "kedili_ninni",
        "atem_tutam_ben_seni",
        "bahce_duvarina",
        "ninneme",
        "uyku_tulumu",
    ],
    "classic": [
        "albinoni_adagio",
        "ave_maria",
        "canon_in_d",
        "chopin_nocturne",
        "clair_de_lune",
        "grieg_morning_mood",
        "mozart_lullaby",
        "schubert_ave_maria",
        "vivaldi_winter",
        "sleeping_beauty_waltz",
    ],
    "background": [
        "dreamy_ambient",
        "simple_peaceful_piano",
        "mystic_dream_piano",
        "fur_elise_music_box",
        "choir_singing",
        "autumn_day",
        "lounge_deep_house",
        "ambient_background",
    ],
    "national": [
        "fr_frere_jacques",
        "de_schlaf_kindlein",
        "es_a_la_ru_ru",
        "it_ninna_nanna",
        "ru_bayu_bayushki",
        "en_abc_song",
        "fr_clair_de_lune",
        "es_cancion_de_cuna",
    ],
    "relaxing": [
        "forest_birds",
        "calm_ocean",
        "rain_thunder",
        "night_ambience",
        "wind_chimes",
        "cicadas",
        "deep_sleep",
        "spring_sounds",
        "zen_music",
        "soothing_sleep",
    ],
}


def main() -> None:
    for category, slugs in MANIFEST.items():
        for slug in slugs:
            generate(category, slug)
            print(f"generated {category}/{slug}.wav")


if __name__ == "__main__":
    main()
