# GitHub'a Yayınlama

Proje yerelde commit edildi. GitHub'a push için aşağıdaki adımları izleyin.

## 1. GitHub'da repo oluşturun

[github.com/new](https://github.com/new) adresinde:

| Alan | Değer |
|------|--------|
| Repository name | `baby-sleep-sounds` |
| Visibility | Public (Pages için) |
| README / .gitignore | **Eklemeyin** (zaten var) |

## 2. Kimlik doğrulama

Terminalde bir yöntem seçin:

### Seçenek A — GitHub CLI (önerilen)

```bash
sudo snap install gh   # veya: sudo apt install gh
gh auth login
```

### Seçenek B — Personal Access Token

1. GitHub → Settings → Developer settings → Personal access tokens
2. `repo` yetkisiyle token oluşturun
3. Push sırasında şifre yerine token kullanın

### Seçenek C — SSH

```bash
ssh-keygen -t ed25519 -C "alperttungir@gmail.com"
# Public key'i GitHub → Settings → SSH keys'e ekleyin
git remote set-url origin git@github.com:alpertungir/baby-sleep-sounds.git
```

## 3. Push

```bash
cd /home/furkan/Workspace/baby-sleep-sounds
git push -u origin master:main
```

## 4. GitHub Pages

Push sonrası:

1. Repo → **Settings → Pages**
2. **Source:** GitHub Actions
3. Actions sekmesinde **Deploy Privacy Policy** workflow'unun yeşil olmasını bekleyin
4. Gizlilik URL'si: https://alpertungir.github.io/baby-sleep-sounds/privacy-policy.html

## Mevcut durum

```bash
git log -1 --oneline
git remote -v
```

Remote: `https://github.com/alpertungir/baby-sleep-sounds.git`
