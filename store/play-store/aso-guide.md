# Google Play ASO Rehberi — Bebek Uyku Sesleri

Arama sıralamasında üst sıralara çıkmak için Play Console ve mağaza sayfasında yapılacaklar.

## 1. Mağaza listesi (en yüksek etki)

| Alan | Limit | Öneri |
|------|-------|--------|
| **Uygulama adı** | 30 karakter | `Bebek Uyku Sesleri` — ana anahtar kelime başta |
| **Kısa açıklama** | 80 karakter | `metadata.yaml` içindeki metni aynen yapıştırın; arama indeksinde kritik |
| **Uzun açıklama** | 4000 karakter | `listing-tr.md` — ilk 2 cümlede: bebek uyku sesi, ninni, beyaz gürültü |
| **Kategori** | — | **Ebeveynlik (Parenting)** |

### Önerilen etiketler (Play Console → Store settings → Tags)

Play’in sunduğu listeden uygun olanları seçin (max 5):

- Parenting
- Sleep
- Baby
- Health & fitness *(uygunsa)*
- Music *(uygunsa)*

> Etiketler bölgeye göre değişir; konsolda önerilenleri işaretleyin.

## 2. Yerelleştirme

- **Birincil:** Türkçe (tr-TR) — hedef pazar
- **İkincil:** İngilizce (en-US) — `listing-en.md` ile ekleyin
- Uygulama içi 8 dil mağaza sıralamasına doğrudan etki etmez; TR/EN listeleri öncelikli

## 3. Grafikler ve ekran görüntüleri

| Dosya | Konum |
|-------|--------|
| İkon 512 | `store/play-store/graphics/icon-512.png` |
| Feature graphic 1024×500 | `store/play-store/graphics/feature-graphic-1024x500.png` |
| Ekran görüntüleri | `store/screenshots/android/` — plan: `screenshot-plan.md` |

**ASO ipucu:** Ekran görüntüsü üzerine kısa metin ekleyin:
- “Ninni & Beyaz Gürültü”
- “50+ Uyku Sesi”
- “Reklamsız”
- “Uyku Zamanlayıcısı”
- “Çevrimdışı Çalışır”

## 4. Sıralamayı etkileyen davranış metrikleri

Google algoritması mağaza metninin yanında şunlara bakar:

| Metrik | Ne yapmalı |
|--------|------------|
| **Yükleme → kalma** | İlk açılış hızlı; crash yok |
| **Değerlendirme** | Uygulama içi in-app review (eklendi); memnun kullanıcılardan puan isteyin |
| **Kaldırma oranı** | Reklamsız, sade UX; aşırı izin istemeyin |
| **Güncellemeler** | Ayda 1 küçük güncelleme bile sıralamaya yardımcı olur |
| **ANR / crash** | Play Console → Android vitals yeşil tutun |

## 5. Play Console kontrol listesi

- [ ] **Store listing** TR + EN tamamlandı
- [ ] **Content rating** anketi
- [ ] **Data safety** — veri toplanmıyor
- [ ] **Target audience** — ebeveynler (13+ veya 18+; çocuk programı gerekmez, reklam yok)
- [ ] **Privacy policy URL** canlı
- [ ] **Internal testing** → kapalı test → üretim (kademeli yayın önerilir)
- [ ] **Store listing experiments** — A/B test (kısa açıklama varyantları)

## 6. Kısa açıklama A/B test fikirleri

Mevcut (önerilen):
```
Bebek uyku sesi: ninni, beyaz gürültü, rahatlatıcı melodiler. Reklamsız, 50+ ses.
```

Alternatif B:
```
Ninni ve beyaz gürültü — bebeğiniz için 50+ uyku sesi. Reklamsız, çevrimdışı.
```

Alternatif C:
```
Bebek uyutma sesleri: fan, yağmur, ninni. Zamanlayıcı ve favoriler. Reklamsız.
```

Play Console → **Store listing experiments** ile 28 gün test edin.

## 7. Dış trafik (isteğe bağlı)

- GitHub Pages landing: `https://alpertungir.github.io/baby-sleep-sounds/`
- Anne-baba forumları, blog yorumları (spam değil, gerçek öneri)
- Sosyal medyada “bebek uyku sesi” anahtar kelimesiyle kısa tanıtım

## 8. Yapılmaması gerekenler

- Anahtar kelime doldurma (keyword stuffing) — Play cezalandırabilir
- Yanıltıcı ekran görüntüsü
- Sahte yorum / satın alınmış install
- Kategori değiştirme (Parenting dışına çıkmayın)

---

Güncel kopyala-yapıştır metinler: [`metadata.yaml`](metadata.yaml), [`listing-tr.md`](listing-tr.md), [`developer-brand.md`](developer-brand.md)
