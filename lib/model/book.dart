// Model untuk data buku inventaris
class Book {
  String? id;
  String judul;
  int harga;
  int jumlah;
  String tanggalMasuk;
  int volume;
  String penulis;
  String penerbit;

  Book({
    this.id,
    required this.judul,
    required this.harga,
    required this.jumlah,
    required this.tanggalMasuk,
    required this.volume,
    required this.penulis,
    required this.penerbit,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id']?.toString(),
      judul: json['judul']?.toString() ?? '',
      harga: int.tryParse(json['harga']?.toString() ?? '0') ?? 0,
      jumlah: int.tryParse(json['jumlah']?.toString() ?? '0') ?? 0,
      tanggalMasuk: json['tanggal_masuk']?.toString() ?? '',
      volume: int.tryParse(json['volume']?.toString() ?? '0') ?? 0,
      penulis: json['penulis']?.toString() ?? '',
      penerbit: json['penerbit']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id.toString(),
      'judul': judul,
      'harga': harga.toString(),
      'jumlah': jumlah.toString(),
      'tanggal_masuk': tanggalMasuk,
      'volume': volume.toString(),
      'penulis': penulis,
      'penerbit': penerbit,
    };
  }
}