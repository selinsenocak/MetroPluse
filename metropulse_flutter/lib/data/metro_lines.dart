/// Metro İstanbul lines and a representative set of their stations.
/// Used for the "Hat / İstasyon Seçimi" pickers throughout the app.
/// Station lists aim to be realistic but are a best-effort mock dataset
/// for this prototype, not a live feed from İBB / Metro İstanbul.
class MetroLine {
  final String code;
  final String routeName;
  final List<String> stations;
  const MetroLine({required this.code, required this.routeName, required this.stations});

  String get label => '$code — $routeName';
}

const List<MetroLine> metroLines = [
  MetroLine(
    code: 'M1A',
    routeName: 'Yenikapı - Atatürk Havalimanı',
    stations: [
      'Yenikapı', 'Aksaray', 'Emniyet-Fatih', 'Topkapı-Ulubatlı', 'Bayrampaşa-Maltepe',
      'Sağmalcılar', 'Kocatepe', 'Otogar', 'Terazidere', 'Davutpaşa-YTÜ', 'Merter',
      'Zeytinburnu', 'Bakırköy-İncirli', 'Bahçelievler', 'Ataköy-Şirinevler',
      'Yenibosna', 'DTM-İstanbul Fuar Merkezi', 'Atatürk Havalimanı',
    ],
  ),
  MetroLine(
    code: 'M1B',
    routeName: 'Yenikapı - Kirazlı',
    stations: ['Yenikapı', 'Aksaray', 'Otogar', 'Esenler', 'Menderes', 'Üçyüz', 'Bağcılar Meydan', 'Kirazlı'],
  ),
  MetroLine(
    code: 'M2',
    routeName: 'Yenikapı - Hacıosman',
    stations: [
      'Yenikapı', 'Vezneciler', 'Haliç', 'Şişhane', 'Taksim', 'Osmanbey',
      'Şişli-Mecidiyeköy', 'Gayrettepe', 'Levent', '4.Levent', 'Sanayi Mahallesi',
      'Seyrantepe', 'İTÜ-Ayazağa', 'Atatürk Oto Sanayi', 'Darüşşafaka', 'Hacıosman',
    ],
  ),
  MetroLine(
    code: 'M3',
    routeName: 'Kirazlı - Kayaşehir Merkez',
    stations: [
      'Kirazlı', 'Yenimahalle', 'Mahmutbey', 'İstoç', 'İkitelli Sanayi', 'Turgut Özal',
      'Siteler', 'Başak Konutları', 'Başakşehir Metrokent', 'Şehir Hastanesi',
      'Onurkent', 'Toplu Konutlar', 'Ziya Gökalp Mahallesi', 'Olimpiyat', 'Kayaşehir Merkez',
    ],
  ),
  MetroLine(
    code: 'M4',
    routeName: 'Kadıköy - Sabiha Gökçen Havalimanı',
    stations: [
      'Kadıköy', 'Ayrılık Çeşmesi', 'Acıbadem', 'Ünalan', 'Göztepe', 'Yenisahra',
      'Kozyatağı', 'Bostancı', 'Küçükyalı', 'Maltepe', 'Huzurevi', 'Gülsuyu',
      'Esenkent', 'Hastane-Adliye', 'Soğanlık', 'Kartal', 'Yakacık-Adnan Kahveci',
      'Pendik', 'Tavşantepe', 'Fevzi Çakmak-Hastane', 'Yayalar-Yenidoğan',
      'Sabiha Gökçen Havalimanı',
    ],
  ),
  MetroLine(
    code: 'M5',
    routeName: 'Üsküdar - Çekmeköy / Samandıra',
    stations: [
      'Üsküdar', 'Fıstıkağacı', 'Bağlarbaşı', 'Altunizade', 'Kısıklı', 'Bulgurlu',
      'Ümraniye', 'Çarşı', 'Yamanevler', 'Çakmak', 'Ihlamurkuyu', 'Altınşehir',
      'İmam Hatip Lisesi', 'Dudullu', 'Necip Fazıl', 'Çekmeköy', 'Meclis',
      'Sarıgazi', 'Sancaktepe Belediyesi', 'Samandıra Merkez',
    ],
  ),
  MetroLine(
    code: 'M6',
    routeName: 'Levent - Boğaziçi Üniversitesi/Hisarüstü',
    stations: ['Levent', 'Nispetiye', 'Etiler', 'Boğaziçi Üniversitesi-Hisarüstü'],
  ),
  MetroLine(
    code: 'M7',
    routeName: 'Mecidiyeköy - Mahmutbey',
    stations: [
      'Mecidiyeköy', 'Çağlayan', 'Kağıthane', 'Nurtepe', 'Alibeyköy', 'Yıldıztabya',
      'Karadeniz Mahallesi', 'Yeşilpınar', 'Bağcılar', 'Mahmutbey',
    ],
  ),
  MetroLine(
    code: 'M8',
    routeName: 'Bostancı - Parseller',
    stations: [
      'Bostancı', 'Emin Ali Paşa', 'İçerenköy', 'Küçükbakkalköy', 'Kayışdağı',
      'Mevlana', 'Şerifali', 'Yukarı Dudullu', 'Parseller',
    ],
  ),
  MetroLine(
    code: 'M9',
    routeName: 'Ataköy - İkitelli',
    stations: ['Ataköy', 'Yenibosna', 'İkitelli Sanayi'],
  ),
  MetroLine(
    code: 'M11',
    routeName: 'Gayrettepe - İstanbul Havalimanı',
    stations: ['Gayrettepe', 'Kağıthane', 'Hasdal', 'Kemerburgaz', 'İhsaniye', 'Göktürk', 'İstanbul Havalimanı'],
  ),
  MetroLine(
    code: 'T1',
    routeName: 'Kabataş - Bağcılar',
    stations: [
      'Kabataş', 'Fındıklı', 'Tophane', 'Karaköy', 'Eminönü', 'Sirkeci', 'Gülhane',
      'Sultanahmet', 'Çemberlitaş', 'Beyazıt-Kapalıçarşı', 'Laleli-Üniversite',
      'Aksaray', 'Yusufpaşa', 'Haseki', 'Fındıkzade', 'Çapa-Şehremini', 'Pazartekke',
      'Topkapı-Ulubatlı', 'Cevizlibağ-Davutpaşa', 'Merkezefendi', 'Mithatpaşa',
      'Bayrampaşa-Maltepe', 'Sağmalcılar', 'Kartaltepe', 'Otogar', 'Terazidere',
      'Zeytinburnu', 'Merter', 'Güngören', 'Soğanlı', 'Bağcılar Meydan',
    ],
  ),
  MetroLine(
    code: 'T3',
    routeName: 'Kadıköy - Moda (Nostaljik Tramvay)',
    stations: ['Kadıköy', 'Bahariye', 'Damga Sokak', 'Moda Caddesi', 'Muvakkithane Caddesi'],
  ),
  MetroLine(
    code: 'T4',
    routeName: 'Topkapı - Mescid-i Selam',
    stations: [
      'Topkapı', 'Vatan', 'Akşemsettin', 'Merkezefendi', 'Cevatpaşa', 'Bahçelievler',
      'Soğanlı', 'Mescid-i Selam',
    ],
  ),
  MetroLine(
    code: 'T5',
    routeName: 'Cibali - Alibeyköy',
    stations: ['Cibali', 'Fener', 'Balat', 'Ayvansaray', 'Eyüpsultan', 'Silahtarağa', 'Alibeyköy'],
  ),
  MetroLine(
    code: 'F1',
    routeName: 'Taksim - Kabataş (Füniküler)',
    stations: ['Taksim', 'Kabataş'],
  ),
  MetroLine(
    code: 'TF2',
    routeName: 'Eyüp - Piyer Loti (Teleferik)',
    stations: ['Eyüp', 'Piyer Loti'],
  ),
];
