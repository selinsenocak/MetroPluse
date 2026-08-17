---
{
  "version": "alpha",
  "name": "MetroPulse",
  "description": "İBB Metro İstanbul yürüyen merdiven/bant ve asansör arıza takibi, kayıp eşya eşleştirme ve bakım-onarım önceliklendirme mobil uygulaması için tasarım sistemi. 6 ana renk + 30 ara renk; ara renkler İstanbul Metro hat renklerinden türetilmiştir.",

  "colors": {
    "fault": "#D32F2F",
    "active": "#2E7D32",
    "brand": "#1A365D",
    "work": "#F57C00",
    "info": "#0288D1",
    "station": "#F4F6F8",

    "fault-surface": "#FBEAEA",
    "fault-soft": "#F9C9CB",
    "fault-strong": "#E0282C",
    "fault-accent": "#DA2948",
    "fault-deep": "#891F1F",

    "ok-surface": "#E6EFE6",
    "ok-soft": "#C1DCBF",
    "ok-strong": "#1A8C40",
    "ok-muted": "#4B8B53",
    "ok-deep": "#1E5120",

    "brand-surface": "#E8EBEF",
    "brand-soft": "#B1C1D6",
    "brand-rail": "#0D4072",
    "brand-accent": "#353460",
    "brand-deep": "#102038",

    "work-surface": "#FEEFE0",
    "work-amber": "#F8A206",
    "work-strong": "#FA7D21",
    "work-plan": "#E19136",
    "work-deep": "#A25900",

    "info-surface": "#E6F3FA",
    "info-soft": "#9CD5EF",
    "info-strong": "#0797D8",
    "info-scan": "#2282C9",
    "info-deep": "#0166A8",

    "surface-raised": "#FBFBFC",
    "border": "#D5DBE2",
    "platform": "#D9D9D5",
    "text-secondary": "#5B708C",
    "text-primary": "#30496C"
  },

  "typography": {
    "h1": { "fontFamily": "Inter", "fontSize": "1.75rem", "fontWeight": 700, "lineHeight": 1.25, "letterSpacing": "-0.01em" },
    "h2": { "fontFamily": "Inter", "fontSize": "1.375rem", "fontWeight": 700, "lineHeight": 1.3 },
    "h3": { "fontFamily": "Inter", "fontSize": "1.125rem", "fontWeight": 600, "lineHeight": 1.35 },
    "body-lg": { "fontFamily": "Inter", "fontSize": "1rem", "fontWeight": 400, "lineHeight": 1.55 },
    "body-md": { "fontFamily": "Inter", "fontSize": "0.9375rem", "fontWeight": 400, "lineHeight": 1.5 },
    "body-sm": { "fontFamily": "Inter", "fontSize": "0.8125rem", "fontWeight": 400, "lineHeight": 1.45 },
    "label-strong": { "fontFamily": "Inter", "fontSize": "0.875rem", "fontWeight": 600, "lineHeight": 1.3 },
    "label-caps": { "fontFamily": "Inter", "fontSize": "0.6875rem", "fontWeight": 700, "lineHeight": 1.2, "letterSpacing": "0.08em" },
    "device-id": { "fontFamily": "Roboto Mono", "fontSize": "0.875rem", "fontWeight": 500, "lineHeight": 1.4, "letterSpacing": "0.02em" },
    "line-badge": { "fontFamily": "Inter", "fontSize": "0.75rem", "fontWeight": 700, "lineHeight": 1, "letterSpacing": "0.02em" }
  },

  "rounded": {
    "xs": "4px",
    "sm": "8px",
    "md": "12px",
    "lg": "16px",
    "xl": "24px",
    "full": "999px"
  },

  "spacing": {
    "xs": "4px",
    "sm": "8px",
    "md": "16px",
    "lg": "24px",
    "xl": "32px",
    "2xl": "48px"
  },

  "components": {
    "app-bar": {
      "backgroundColor": "brand",
      "textColor": "station",
      "typography": "h3",
      "padding": "md",
      "height": "56px"
    },
    "app-bar-technical": {
      "backgroundColor": "brand-rail",
      "textColor": "station",
      "typography": "h3",
      "padding": "md",
      "height": "56px"
    },
    "screen": {
      "backgroundColor": "station",
      "textColor": "text-primary",
      "typography": "body-md",
      "padding": "md"
    },
    "card": {
      "backgroundColor": "surface-raised",
      "textColor": "text-primary",
      "typography": "body-md",
      "rounded": "md",
      "padding": "md"
    },
    "card-fault": {
      "backgroundColor": "fault-surface",
      "textColor": "fault-deep",
      "typography": "body-md",
      "rounded": "md",
      "padding": "md"
    },
    "card-repair": {
      "backgroundColor": "work-surface",
      "textColor": "work-deep",
      "typography": "body-md",
      "rounded": "md",
      "padding": "md"
    },
    "card-active": {
      "backgroundColor": "ok-surface",
      "textColor": "ok-deep",
      "typography": "body-md",
      "rounded": "md",
      "padding": "md"
    },
    "status-badge-fault": {
      "backgroundColor": "fault-strong",
      "textColor": "surface-raised",
      "typography": "label-caps",
      "rounded": "full",
      "padding": "xs"
    },
    "status-badge-repair": {
      "backgroundColor": "work-strong",
      "textColor": "brand-deep",
      "typography": "label-caps",
      "rounded": "full",
      "padding": "xs"
    },
    "status-badge-active": {
      "backgroundColor": "ok-strong",
      "textColor": "surface-raised",
      "typography": "label-caps",
      "rounded": "full",
      "padding": "xs"
    },
    "priority-badge": {
      "backgroundColor": "fault-accent",
      "textColor": "surface-raised",
      "typography": "label-caps",
      "rounded": "full",
      "padding": "xs"
    },
    "maintenance-pulled-badge": {
      "backgroundColor": "work-amber",
      "textColor": "brand-deep",
      "typography": "label-caps",
      "rounded": "full",
      "padding": "xs"
    },
    "maintenance-planned-badge": {
      "backgroundColor": "work-plan",
      "textColor": "brand-deep",
      "typography": "label-caps",
      "rounded": "full",
      "padding": "xs"
    },
    "resolved-badge": {
      "backgroundColor": "ok-muted",
      "textColor": "surface-raised",
      "typography": "label-caps",
      "rounded": "full",
      "padding": "xs"
    },
    "line-badge": {
      "backgroundColor": "brand-rail",
      "textColor": "surface-raised",
      "typography": "line-badge",
      "rounded": "xs",
      "size": "28px"
    },
    "button-primary": {
      "backgroundColor": "brand",
      "textColor": "station",
      "typography": "label-strong",
      "rounded": "sm",
      "padding": "md",
      "height": "48px"
    },
    "button-secondary": {
      "backgroundColor": "brand-surface",
      "textColor": "brand",
      "typography": "label-strong",
      "rounded": "sm",
      "padding": "md",
      "height": "48px"
    },
    "button-report-fault": {
      "backgroundColor": "fault",
      "textColor": "surface-raised",
      "typography": "label-strong",
      "rounded": "sm",
      "padding": "md",
      "height": "52px"
    },
    "button-resolve": {
      "backgroundColor": "active",
      "textColor": "surface-raised",
      "typography": "label-strong",
      "rounded": "sm",
      "padding": "md",
      "height": "48px"
    },
    "search-field": {
      "backgroundColor": "surface-raised",
      "textColor": "text-primary",
      "typography": "body-md",
      "rounded": "full",
      "padding": "md",
      "height": "44px"
    },
    "filter-chip": {
      "backgroundColor": "info-surface",
      "textColor": "info-deep",
      "typography": "body-sm",
      "rounded": "full",
      "padding": "sm"
    },
    "filter-chip-selected": {
      "backgroundColor": "info",
      "textColor": "surface-raised",
      "typography": "body-sm",
      "rounded": "full",
      "padding": "sm"
    },
    "qr-scanner-frame": {
      "backgroundColor": "brand-deep",
      "textColor": "info-soft",
      "typography": "body-sm",
      "rounded": "lg",
      "padding": "lg"
    },
    "qr-scan-target": {
      "backgroundColor": "info-scan",
      "textColor": "surface-raised",
      "typography": "label-caps",
      "rounded": "md",
      "size": "240px"
    },
    "lost-item-card": {
      "backgroundColor": "surface-raised",
      "textColor": "text-primary",
      "typography": "body-md",
      "rounded": "md",
      "padding": "md"
    },
    "lost-item-photo": {
      "backgroundColor": "platform",
      "rounded": "sm",
      "size": "72px"
    },
    "match-highlight": {
      "backgroundColor": "info-soft",
      "textColor": "brand-deep",
      "typography": "label-strong",
      "rounded": "sm",
      "padding": "sm"
    },
    "list-item": {
      "backgroundColor": "surface-raised",
      "textColor": "text-primary",
      "typography": "body-md",
      "padding": "md",
      "height": "64px"
    },
    "list-divider": {
      "backgroundColor": "border",
      "height": "1px"
    },
    "meta-text": {
      "textColor": "text-secondary",
      "typography": "body-sm"
    },
    "device-id-tag": {
      "backgroundColor": "brand-surface",
      "textColor": "brand",
      "typography": "device-id",
      "rounded": "xs",
      "padding": "xs"
    },
    "panel-header-citizen": {
      "backgroundColor": "brand",
      "textColor": "station",
      "typography": "h2",
      "padding": "lg"
    },
    "panel-header-ibb": {
      "backgroundColor": "brand-accent",
      "textColor": "station",
      "typography": "h2",
      "padding": "lg"
    },
    "panel-header-technical": {
      "backgroundColor": "brand-rail",
      "textColor": "station",
      "typography": "h2",
      "padding": "lg"
    },
    "empty-state": {
      "backgroundColor": "station",
      "textColor": "text-secondary",
      "typography": "body-md",
      "padding": "xl"
    }
  }
}
---

## Amaç ve Sınır

Bu tasarım sistemi yalnızca `intennt.md` içindeki kapsamı destekler: cihaz durum
takibi, QR ile arıza bildirimi, kayıp eşya eşleştirme ve bakım-onarım
önceliklendirme. Üç panel vardır — Vatandaş, İBB Personeli, Teknik Ekip.
Kapsam dışı başlıklar (§9) için token/komponent tanımlanmamıştır: ödül-puan
rozeti, sosyal paylaşım, reklam yüzeyi, erişilebilirlik skoru göstergesi ve
metro dışı ulaşım modu ikonografisi bu sistemde **yoktur**.

## Renk Mimarisi

6 ana renk sistemin anlam eksenidir; 30 ara renk bu eksenlerin yüzey, yumuşak,
güçlü, sessiz ve derin kademeleridir. Her ara renk, ana rengin bir **İstanbul
Metro hat rengiyle** (Wikipedia `Module:Adjacent stations/Istanbul Metro`)
oransal karışımıdır — böylece arayüz, İstanbul metro haritasının renk diliyle
aynı aileden konuşur.

| Ana renk | Anlam | Ara renkleri |
|---|---|---|
| `fault` #D32F2F | Arıza, aciliyet | fault-surface, fault-soft, fault-strong, fault-accent, fault-deep |
| `active` #2E7D32 | Aktif cihaz, çözülmüş kayıt | ok-surface, ok-soft, ok-strong, ok-muted, ok-deep |
| `brand` #1A365D | İBB kimliği, AppBar, panel | brand-surface, brand-soft, brand-rail, brand-accent, brand-deep |
| `work` #F57C00 | Onarımda, bakım önceliği | work-surface, work-amber, work-strong, work-plan, work-deep |
| `info` #0288D1 | Kayıp eşya, arama, QR | info-surface, info-soft, info-strong, info-scan, info-deep |
| `station` #F4F6F8 | Arka plan, kart, form | surface-raised, border, platform, text-secondary, text-primary |

## Ara Renklerin Türetimi

`⊕ X %n` = ana rengin X hat rengiyle %n oranında karıştırılması.

| Token | Türetim | Kaynak hat |
|---|---|---|
| fault-surface | fault + beyaz %90 | — |
| fault-soft | (fault ⊕ #FF4B58 %50) + beyaz %72 | M13 |
| fault-strong | fault ⊕ #EE2229 %50 | M1A / M1B |
| fault-accent | fault ⊕ #E81E77 %35 | M4 |
| fault-deep | fault + siyah %35 | — |
| ok-surface | active + beyaz %88 | — |
| ok-soft | (active ⊕ #4CAA3C %45) + beyaz %68 | M10 |
| ok-strong | active ⊕ #059A4D %50 | M2 |
| ok-muted | active ⊕ #90ABA0 %30 | T2 |
| ok-deep | active + siyah %35 | — |
| brand-surface | brand + beyaz %90 | — |
| brand-soft | (brand ⊕ #487ABF %55) + beyaz %62 | M8 |
| brand-rail | brand ⊕ #004B86 %50 | T1 |
| brand-accent | brand ⊕ #683166 %35 | M5 |
| brand-deep | brand + siyah %40 | — |
| work-surface | work + beyaz %88 | — |
| work-amber | work ⊕ #FCD10D %45 | M9 |
| work-strong | work ⊕ #FF7E42 %50 | T4 |
| work-plan | work ⊕ #C9AA79 %45 | M6 |
| work-deep | (work ⊕ #B16400 %80) + siyah %15 | M14 |
| info-surface | info + beyaz %90 | — |
| info-soft | (info ⊕ #0CA6DF %50) + beyaz %60 | M3 |
| info-strong | info ⊕ #0CA6DF %50 | M3 |
| info-scan | info ⊕ #487ABF %45 | M8 |
| info-deep | info ⊕ #004B86 %55 | T1 |
| surface-raised | station + beyaz %60 | — |
| border | station ⊕ #1A365D %14 | — |
| platform | station ⊕ #7A745A %22 | F1 / F3 / F4 |
| text-secondary | station ⊕ #1A365D %70 | — |
| text-primary | station ⊕ #1A365D %90 | — |

## Durum Renk Eşlemesi

`intennt.md` §6 durum makinesi doğrudan renge bağlanır:

- **Aktif** → `ok-strong` dolgu, `ok-surface` kart, `ok-deep` metin
- **Arızalı** → `fault-strong` dolgu, `fault-surface` kart, `fault-deep` metin
- **Onarımda** → `work-strong` dolgu, `work-surface` kart, `work-deep` metin
- **Çözüldü (arşiv)** → `ok-muted` rozet, `text-secondary` meta metin
- **Bakım öne çekildi** (§8.1, ilk %30 hat) → `work-amber` rozet
- **Standart periyot bakımı** (§8.3) → `work-plan` rozet

Kayıp eşya akışı (§5) tamamen `info` ailesindedir: sorgu alanı `info-surface`,
seçili filtre `info`, olası eşleşme vurgusu `info-soft`, e-liste başlığı
`info-deep`. QR tarama (§7) `info-scan` + `brand-deep` çerçevedir.

## Panel Ayrımı

Üç panel aynı token setini kullanır; ayrım yalnızca başlık renginde yapılır —
yeni palet üretilmez.

- **Vatandaş Paneli** → `brand` başlık; birincil eylem `button-report-fault`
- **İBB Personeli Paneli** → `brand-accent` başlık; salt izleme, eylem butonu
  yerine `meta-text` ağırlıklı liste
- **Teknik Ekip Paneli** → `brand-rail` başlık; `button-resolve` ve bakım
  önceliklendirme rozetleri yalnızca burada görünür

## Hat Rozetleri

Hat renkleri (M1A #EE2229 … T6 #E77C7C) **veri katmanındadır**, token değildir;
`line-badge` bileşeninin `backgroundColor` değeri kayıttaki hat renginden
gelir. Varsayılan `brand-rail`, hat bilgisi yoksa kullanılır. Rozet metni:
açık hatlarda (M6, M7, M9, M12, T2) `brand-deep`, diğer hepsinde
`surface-raised`.

## Erişilebilirlik

Ölçülmüş kontrast oranları (WCAG 2.1):

- `text-primary` / `station` = 8.45 — gövde metni AAA
- `text-secondary` / `station` = 4.68 — meta metin AA
- `brand` / `station` = 11.21, beyaz / `brand` = 12.14 — AppBar AAA
- `fault-deep` / `fault-surface` = 7.92, beyaz / `fault-strong` = 4.66 — AA
- `ok-deep` / `ok-surface` = 7.92, beyaz / `ok-strong` = 4.31 — büyük metin AA
- `work-deep` / `work-surface` = 4.70 — AA
- `info-deep` / `info-surface` = 5.35 — AA

Kurallar:

1. Açık yüzey üzerindeki metin **daima** `*-deep` tonudur; `fault`, `work` ve
   `info` ana tonları açık zeminde gövde metni olarak kullanılamaz
   (sırasıyla 4.60 / 2.50 / 3.56).
2. `work-strong`, `work-amber` ve `work-plan` üzerinde beyaz metin yasaktır;
   `brand-deep` kullanılır.
3. Durum asla yalnız renkle anlatılmaz — her durum rozetinde ikon + `label-caps`
   metin bulunur (renk körlüğü ve istasyon aydınlatması nedeniyle).
4. Dokunma hedefi minimum 48×48px; QR tarama tetikleyicisi 52px.

## Yüzey Hiyerarşisi

`station` (ekran zemini) → `surface-raised` (kart) → `border` (1px ayraç) →
`platform` (fotoğraf/boş görsel yer tutucu, F hattı grisinden türetilmiş).
Gölge kullanılmaz; katman ayrımı yalnızca yüzey ve `border` ile yapılır — düşük
aydınlıklı istasyon ortamında gölge okunmaz.

## Tipografi Kullanımı

- `h1` yalnızca panel giriş ekranında
- `h2` panel başlıkları, `h3` AppBar ve kart başlıkları
- `device-id` monospace: cihaz ID, Metro ID ve QR sonucu — karakter karışması
  (0/O, 1/l) saha koşullarında hata üretir
- `label-caps` yalnızca durum rozetlerinde
- `body-sm` + `text-secondary`: son bakım tarihi, son arıza nedeni, saat bilgisi

## Kapsam Dışı Tokenlar

Bilinçli olarak tanımlanmamıştır: ödül/puan renkleri, gamification vurguları,
sosyal paylaşım buton stilleri, reklam yüzeyi, üçüncü taraf marka renkleri,
metro dışı ulaşım modu ikonografisi, IoT sensör canlı-veri göstergesi. Bunlar
`intennt.md` §9 gereği kapsam dışıdır.
