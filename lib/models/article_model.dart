class ArticleModel {
  String? title;
  String? description;
  String? link;
  String? thumbnail;

  ArticleModel({
    this.title = '',
    this.description = '',
    this.link = '',
    this.thumbnail = '',
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        title: json['title'],
        description: json['description'],
        link: json['link'],
        thumbnail: json['thumbnail'],
      );
}

List<ArticleModel> listArticle = [
  ArticleModel(
    title: 'Ciri Detak Jantung Normal dan Gangguan yang Bisa Terjadi',
    description:
        'Setiap orang memiliki detak jantung normal yang berbeda-beda dan dapat dipengaruhi oleh berbagai hal, termasuk kondisi kesehatan tertentu. Nah, dengan mengetahui detak jantung normal, Anda pun bisa lebih waspada terhadap kemungkinan adanya gangguan pada jantung.',
    link:
        'https://www.alodokter.com/ciri-detak-jantung-normal-dan-gangguan-yang-bisa-terjadi',
    thumbnail:
        'https://res.cloudinary.com/dk0z4ums3/image/upload/v1629644474/attached_image/ciri-detak-jantung-normal-dan-gangguan-yang-bisa-terjadi-0-alodokter.jpg',
  ),
  ArticleModel(
    title: 'Penyebab Detak Jantung Cepat dan Cara Mengatasinya',
    description:
        'Perubahan ritme detak jantung, seperti detak jantung cepat, dapat membuat seseorang merasa tidak nyaman, cemas, bahkan terasa akan pingsan. Ada beberapa alasan dan kondisi medis yang menyebabkan detak jantung menjadi cepat.',
    link:
        'https://www.alodokter.com/ketahui-alasan-detak-jantung-cepat-dan-cara-mengatasinya#:~:text=Detak%20jantung%20cepat%20disebut%20juga,bisa%20muncul%20tanpa%20menimbulkan%20komplikasi.',
    thumbnail:
        'https://res.cloudinary.com/dk0z4ums3/image/upload/v1637731401/attached_image/ketahui-alasan-detak-jantung-cepat-dan-cara-mengatasinya-0-alodokter.jpg',
  ),
  ArticleModel(
    title: 'Detak Jantung Cepat: Penyebab dan Cara Mengatasi',
    description:
        'Ada kalanya, detak jantung kita berdegup lebih cepat ketimbang biasanya.',
    link:
        'https://health.kompas.com/read/2020/12/12/200200668/detak-jantung-cepat-penyebab-dan-cara-mengatasi?page=all',
    thumbnail:
        'https://asset.kompas.com/crops/nOgYBhBgRcgFeS1Ah861J9tzCUQ=/0x7:990x667/750x500/data/photo/2020/08/20/5f3de62a67e80.jpg',
  ),
  ArticleModel(
    title: '4 Posisi yang Bisa Membantu Meningkatkan Saturasi Oksigen',
    description:
        'Dalam melakukan isolasi mandiri,pasien yang terkonfirmasi positif, diharuskan untuk melakukan kontrol terhadap perkembangan kondisi tubuh serta saturasi oksigen dalam tubuh setiap harinya.',
    link:
        'https://upk.kemkes.go.id/new/4-posisi-yang-bisa-membantu-meningkatkan-saturasi-oksigen',
    thumbnail:
        'https://upk.kemkes.go.id/new/imagex/content/c4b239222d344d85409f348e46d71971.jpg',
  ),
  ArticleModel(
    title: 'Cara Membaca Oximeter untuk Cek Saturasi Oksigen',
    description:
        '"Oximeter digunakan untuk mendeteksi setiap perubahan pada saturasi oksigen meskipun dalam kadar kecil. Pastikan kamu tahu cara membaca oximeter untuk menentukan tindakan medis yang perlu dilakukan.”',
    link:
        'https://www.halodoc.com/artikel/begini-cara-membaca-oximeter-untuk-cek-saturasi-oksigen',
    thumbnail:
        'https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2021/10/19095318/Begini-Cara-Membaca-Oximeter-untuk-Cek-Saturasi-Oksigen.jpg.webp',
  ),
  ArticleModel(
    title:
        '7 Cara Meningkatkan Kadar Oksigen Rendah, Alami sampai Terapi Oksigen',
    description:
        'Cara meningkatkan kadar oksigen rendah dalam darah bisa dengan sejumlah langkah alami sampai perlu terapi oksigen.',
    link:
        'https://health.kompas.com/read/2022/02/07/200100868/7-cara-meningkatkan-kadar-oksigen-rendah-alami-sampai-terapi-oksigen-?page=all',
    thumbnail:
        'https://asset.kompas.com/crops/iMISGUD9GGyYKkUb4LzLv-oh5qg=/76x43:774x508/750x500/data/photo/2021/07/03/60e0589a7843e.png',
  ),
  ArticleModel(
    title: 'Penyebab Bradikardia, Detak Jantung Lemah Berakibat Fatal',
    description:
        'Apakah Anda pernah mencoba untuk menghitung detak jantung Anda? Tahukah Anda detak jantung Anda sekarang ini normal atau tidak? Atau malah lebih lambat dari normal? Detak jantung lemah yang tidak normal adalah salah satu gejala yang bisa membahayakan kesehatan jantung, bahkan kesehatan tubuh secara umum.',
    link:
        'https://hellosehat.com/jantung/aritmia/bradikardia-denyut-jantung-lemah/',
    thumbnail:
        'https://cdn.hellosehat.com/wp-content/uploads/2016/11/shutterstock_363109484.jpg',
  ),
  ArticleModel(
    title: '7 Jenis Makanan Sehat untuk Jantung dan Pantangannya',
    description:
        'Penyakit jantung secara bertahap dapat memburuk jika tidak diiringi dengan perubahan pola hidup dan mengonsumsi makanan yang sehat untuk jantung. Makanan yang tidak sehat dapat menyebabkan penumpukan plak di arteri sehingga mengurangi aliran darah ke jantung.',
    link:
        'https://www.mitrakeluarga.com/artikel/artikel-kesehatan/makanan-sehat-untuk-jantung#:~:text=Pilihlah%20sayuran%20berdaun%20hijau%20seperti,jeruk%2C%20melon%2C%20dan%20pepaya.',
    thumbnail:
        'https://mitrakeluarga.s3.ap-southeast-1.amazonaws.com/images/article/full/132_85_7-jenis-makanan-sehat-untuk-jantung-dan-pantangannya.png',
  ),
];
