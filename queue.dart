/// Implementasi struktur data Queue (Antrian) menggunakan Dart
/// dengan prinsip FIFO (First In, First Out).
class Queue<T> {
  final List<T> _items = [];

  /// Menambahkan elemen baru ke bagian belakang antrian (Enqueue)
  void enqueue(T item) {
    _items.add(item);
  }

  /// Mengambil dan menghapus elemen dari bagian depan antrian (Pop / Dequeue)
  /// Mengembalikan `null` jika antrian kosong.
  T? pop() {
    if (isEmpty) {
      return null;
    }
    return _items.removeAt(0);
  }

  /// Melihat elemen terdepan tanpa menghapusnya dari antrian
  T? peek() {
    if (isEmpty) {
      return null;
    }
    return _items.first;
  }

  /// Memeriksa apakah antrian kosong
  bool get isEmpty => _items.isEmpty;

  /// Memeriksa apakah antrian memiliki elemen
  bool get isNotEmpty => _items.isNotEmpty;

  /// Mendapatkan jumlah elemen dalam antrian
  int get length => _items.length;

  /// Mengosongkan seluruh isi antrian
  void clear() {
    _items.clear();
  }

  @override
  String toString() {
    return _items.toString();
  }
}

void main() {
  // Contoh Penggunaan:
  print('=== Simulasi Queue (Antrian) ===');
  final antrian = Queue<String>();

  // 1. Menambahkan data menggunakan enqueue
  print('\n-- Melakukan Enqueue --');
  antrian.enqueue('Andi');
  print('Enqueue Andi -> Antrian: $antrian');

  antrian.enqueue('Budi');
  print('Enqueue Budi -> Antrian: $antrian');

  antrian.enqueue('Cici');
  print('Enqueue Cici -> Antrian: $antrian');

  print('Jumlah antrian: ${antrian.length}');
  print('Elemen terdepan (peek): ${antrian.peek()}');

  // 2. Mengambil data menggunakan pop
  print('\n-- Melakukan Pop --');
  print('Pop: ${antrian.pop()}'); // Andi keluar
  print('Antrian setelah pop: $antrian');

  print('Pop: ${antrian.pop()}'); // Budi keluar
  print('Antrian setelah pop: $antrian');

  print('Pop: ${antrian.pop()}'); // Cici keluar
  print('Antrian setelah pop: $antrian');

  // 3. Pop saat antrian kosong
  print('\n-- Pop saat antrian kosong --');
  print('Pop: ${antrian.pop()}'); // null
  print('Apakah antrian kosong? ${antrian.isEmpty}');
}
