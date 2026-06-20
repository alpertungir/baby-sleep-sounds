#!/usr/bin/env python3
"""Generate Google Play icon (512) and feature graphic (1024x500) from app icon."""

from __future__ import annotations

from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[2]
ICON_SRC = ROOT / "app/assets/icons/app-icon.png"
OUT_DIR = ROOT / "store/play-store/graphics"

BG = (0x2D, 0x1B, 0x69)
BG_LIGHT = (0x3F, 0x2B, 0x7A)
ACCENT = (0xFF, 0xB7, 0x4D)
TEXT = (0xFF, 0xF8, 0xE1)
MUTED = (0xCE, 0x93, 0xD8)


def _load_font(size: int, bold: bool = False) -> ImageFont.FreeTypeFont | ImageFont.ImageFont:
    candidates = [
        "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf" if bold else "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",
        "/usr/share/fonts/truetype/liberation/LiberationSans-Bold.ttf" if bold else "/usr/share/fonts/truetype/liberation/LiberationSans-Regular.ttf",
    ]
    for path in candidates:
        p = Path(path)
        if p.is_file():
            return ImageFont.truetype(str(p), size=size)
    return ImageFont.load_default()


def _icon512() -> None:
    src = Image.open(ICON_SRC).convert("RGBA")
    icon = src.resize((512, 512), Image.LANCZOS)
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    icon.save(OUT_DIR / "icon-512.png")
    print(f"Wrote {OUT_DIR / 'icon-512.png'}")


def _feature_graphic() -> None:
    w, h = 1024, 500
    img = Image.new("RGB", (w, h), BG)
    draw = ImageDraw.Draw(img)

    for y in range(h):
        t = y / h
        r = int(BG[0] * (1 - t) + BG_LIGHT[0] * t)
        g = int(BG[1] * (1 - t) + BG_LIGHT[1] * t)
        b = int(BG[2] * (1 - t) + BG_LIGHT[2] * t)
        draw.line([(0, y), (w, y)], fill=(r, g, b))

    icon = Image.open(ICON_SRC).convert("RGBA").resize((220, 220), Image.LANCZOS)
    img.paste(icon, (56, (h - 220) // 2), icon)

    title_font = _load_font(52, bold=True)
    sub_font = _load_font(28)
    brand_font = _load_font(22, bold=True)
    tag_font = _load_font(20)

    draw.text((320, 130), "Bebek Uyku Sesleri", font=title_font, fill=TEXT)
    draw.text((320, 198), "Baby Sleep Sounds", font=sub_font, fill=MUTED)
    draw.text((320, 252), "Ninni  ·  Beyaz Gürültü  ·  Zamanlayıcı", font=tag_font, fill=ACCENT)
    draw.text((320, 300), "50+ ses  ·  8 dil  ·  Reklamsız", font=tag_font, fill=TEXT)

    draw.rounded_rectangle((780, 408, 968, 452), radius=18, fill=ACCENT)
    bbox = draw.textbbox((0, 0), "Tngr", font=brand_font)
    tw, th = bbox[2] - bbox[0], bbox[3] - bbox[1]
    draw.text((874 - tw // 2, 430 - th // 2), "Tngr", font=brand_font, fill=(0x3E, 0x27, 0x23))

    for i, (x, y, r) in enumerate([(900, 80, 3), (950, 120, 2), (880, 160, 2), (960, 200, 3)]):
        fill = ACCENT if i % 2 == 0 else MUTED
        draw.ellipse((x - r, y - r, x + r, y + r), fill=fill)

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    img.save(OUT_DIR / "feature-graphic-1024x500.png", quality=95)
    print(f"Wrote {OUT_DIR / 'feature-graphic-1024x500.png'}")


def main() -> None:
    if not ICON_SRC.is_file():
        raise SystemExit(f"Missing {ICON_SRC}")
    _icon512()
    _feature_graphic()


if __name__ == "__main__":
    main()
