# Implementasi Struktur Data Antrean (Queue) dalam Bahasa Dart

Repositori ini berisi dokumentasi dan implementasi struktur data **Queue (Antrean)** berbasis bahasa pemrograman Dart. Program dirancang secara modular dan generik (`Queue<T>`), mematuhi prinsip fundamental **FIFO (First In, First Out)**, serta dilengkapi dengan fungsi pengujian interaktif untuk mendemonstrasikan alur penambahan, pembacaan, dan pengambilan elemen.

---

## Daftar Isi

1. [Gambaran Umum dan Konsep Queue](#gambaran-umum-dan-konsep-queue)
   - [Karakteristik Utama Queue](#karakteristik-utama-queue)
   - [Analogi Dunia Nyata](#analogi-dunia-nyata)
2. [Struktur Direktori Proyek](#struktur-direktori-proyek)
3. [Penjelasan Kode dan Logika Program (`queue.dart`)](#penjelasan-kode-dan-logika-program-queuedart)
   - [Kelas Generik Queue](#kelas-generik-queue)
   - [Daftar Operasi dan Metode](#daftar-operasi-dan-metode)
   - [Alur Eksekusi Fungsi `main()`](#alur-eksekusi-fungsi-main)
4. [Tabel Ringkasan Operasi dan Kompleksitas](#tabel-ringkasan-operasi-dan-kompleksitas)
   - [Analisis Efisiensi dan Alternatif Produksi](#analisis-efisiensi-dan-alternatif-produksi)
5. [Prasyarat dan Cara Menjalankan Program](#prasyarat-dan-cara-menjalankan-program)
   - [Prasyarat](#prasyarat)
   - [Verifikasi Pemasangan Dart](#verifikasi-pemasangan-dart)
   - [Langkah Menjalankan Program](#langkah-menjalankan-program)
6. [Dokumentasi dan Analisis Hasil Eksekusi (Folder `Screenshot`)](#dokumentasi-dan-analisis-hasil-eksekusi-folder-screenshot)
   - [1. Screenshot Kode Bagian 1 (`ss_code1.png`)](#1-screenshot-kode-bagian-1-ss_code1png)
   - [2. Screenshot Kode Bagian 2 (`ss_code2.png`)](#2-screenshot-kode-bagian-2-ss_code2png)
   - [3. Screenshot Kode Bagian 3 (`ss_code3.png`)](#3-screenshot-kode-bagian-3-ss_code3png)
   - [4. Screenshot Terminal Eksekusi (`ss_run.png`)](#4-screenshot-terminal-eksekusi-ss_runpng)

---

## Gambaran Umum dan Konsep Queue

**Queue** (antrean) adalah struktur data linear yang beroperasi dengan prinsip dasar **FIFO (First In, First Out)**. Prinsip ini menyatakan bahwa elemen yang pertama kali dimasukkan ke dalam antrean akan menjadi elemen yang pertama kali dikeluarkan.

### Karakteristik Utama Queue

- **Enqueue (Penambahan):** Elemen baru selalu dimasukkan dari ujung belakang (*rear/tail*).
- **Dequeue / Pop (Pengambilan):** Elemen selalu diambil dan dihapus dari ujung depan (*front/head*).
- **Peek (Inspeksi):** Melihat data terdepan tanpa mengubah struktur antrean.
- **Fair Ordering:** Menjamin urutan pemrosesan data yang adil sesuai urutan waktu kedatangan.

### Analogi Dunia Nyata

Konsep antrean ini identik dengan:

1. **Antrean loket bioskop atau kasir:** Pelanggan yang datang lebih awal akan dilayani lebih dahulu.
2. **Antrean pencetakan dokumen (*printer spooler*):** Dokumen yang dikirim pertama kali akan dicetak terlebih dahulu sebelum dokumen berikutnya.
3. **Sistem pengiriman pesan (*message broker* / *task queue*):** Memastikan tugas-tugas dieksekusi secara berurutan tanpa mendahului proses yang sudah mengantre sebelumnya.

---

## Struktur Direktori Proyek

```text
QueueDart/
├── Screenshot/
│   ├── ss_code1.png    # Tangkapan layar kode baris 1 s.d. 35
│   ├── ss_code2.png    # Tangkapan layar kode baris 34 s.d. 66
│   ├── ss_code3.png    # Tangkapan layar kode baris 64 s.d. 83
│   └── ss_run.png      # Tangkapan layar eksekusi program di terminal
├── queue.dart          # Berkas kode utama Dart
└── README.md           # Berkas dokumentasi program (Bahasa Indonesia)
```

---

## Penjelasan Kode dan Logika Program (`queue.dart`)

Program `queue.dart` terdiri dari implementasi kelas kustom `Queue<T>` dan fungsi utama `main()` untuk mensimulasikan alur kerja antrean secara komprehensif.

### Kelas Generik Queue

Implementasi menggunakan parameter generik `<T>` (`class Queue<T>`), sehingga antrean dapat menyimpan berbagai jenis tipe data (seperti `String`, `int`, atau objek kustom) secara *type-safe*.

Data internal disimpan dalam variabel privat:

```dart
final List<T> _items = [];
```

Penggunaan variabel privat (`_items` diawali tanda garis bawah) menerapkan prinsip **enkapsulasi**, sehingga struktur data internal tidak dapat diubah secara langsung dari luar kelas selain melalui metode resmi yang disediakan. Kata kunci `final` menjamin bahwa referensi list tidak dapat dialihkan (*reassigned*) ke objek lain, sementara isinya tetap dapat dimutasi secara dinamis. Kelas memanfaatkan konstruktor generatif bawaan (*default constructor*) Dart saat instansiasi (misalnya `Queue<String>()`).

### Daftar Operasi dan Metode

1. **`void enqueue(T item)`**
   - **Tujuan:** Menambahkan elemen baru ke posisi paling belakang (*tail*) antrean.
   - **Logika:** Menggunakan metode bawaan `_items.add(item)`. Operasi ini menambahkan data ke akhir list dengan kompleksitas waktu `O(1)` amortized.

2. **`T? pop()`**
   - **Tujuan:** Mengambil dan mengeluarkan elemen terdepan (*head*) dari antrean (berfungsi sebagai operasi *dequeue*).
   - **Catatan Terminologi:** Dalam terminologi ilmu komputer formal, operasi penghapusan pada antrean umumnya disebut `dequeue`, sedangkan istilah `pop` lazimnya diasosiasikan dengan Stack (LIFO). Pada berkas `queue.dart`, penulis menamainya `pop()` (dengan dokumentasi kode `Pop / Dequeue`), namun semantiknya tetap menerapkan FIFO dengan mengambil elemen terdepan (`removeAt(0)`), bukan elemen terakhir.
   - **Logika:**
     - Memeriksa terlebih dahulu apakah antrean kosong menggunakan pengondisian `if (isEmpty) return null;`.
     - Jika antrean memiliki elemen, memanggil `_items.removeAt(0)` untuk menghapus dan mengembalikan elemen pada indeks ke-0.
     - Tipe pengembalian `T?` bersifat *nullable*, sehingga aman terhadap kemungkinan *index out of range* atau pengecualian saat antrean kosong.
     - Kompleksitas waktu operasi ini adalah `O(n)` karena seluruh elemen di belakang indeks ke-0 digeser satu posisi ke kiri pada array list.
   - **Penanganan Nilai Null (*Nullability*):** Jika tipe parameter generik bertipe *nullable* (misalnya `Queue<String?>`) dan elemen `null` dimasukkan ke dalam antrean, nilai balik `pop()` yang bernilai `null` dapat mengindikasikan dua hal: antrean memang kosong, atau elemen yang dikeluarkan adalah nilai `null`. Oleh karena itu, pemanggil disarankan selalu memverifikasi status menggunakan *getter* `isEmpty` untuk memastikan kepastian status antrean.

3. **`T? peek()`**
   - **Tujuan:** Membaca nilai elemen terdepan tanpa menghapusnya dari antrean.
   - **Logika:** Jika antrean kosong, mengembalikan `null`. Jika terisi, mengembalikan elemen pertama via `_items.first`. Kompleksitas waktu adalah `O(1)`.
   - **Penanganan Nilai Null:** Serupa dengan `pop()`, jika antrean menyimpan elemen bernilai `null`, pengecekan `isEmpty` diperlukan untuk membedakan antara antrean kosong dan elemen terdepan yang bernilai `null`.

4. **`bool get isEmpty`**
   - **Tujuan:** Getter boolean untuk memeriksa apakah antrean tidak memiliki elemen sama sekali (`_items.isEmpty`). Kompleksitas waktu adalah `O(1)`.

5. **`bool get isNotEmpty`**
   - **Tujuan:** Getter boolean untuk memeriksa apakah antrean memiliki setidaknya satu elemen (`_items.isNotEmpty`). Kompleksitas waktu adalah `O(1)`.

6. **`int get length`**
   - **Tujuan:** Getter integer untuk mengetahui jumlah total elemen yang sedang mengantre (`_items.length`). Kompleksitas waktu adalah `O(1)`.

7. **`void clear()`**
   - **Tujuan:** Mengosongkan seluruh antrean secara sekaligus menggunakan `_items.clear()`. Kompleksitas waktu adalah `O(1)`.

8. **`@override String toString()`**
   - **Tujuan:** Mengubah representasi internal antrean menjadi format teks representatif sehingga mudah dicetak ke terminal dengan `print()`.

### Alur Eksekusi Fungsi `main()`

Fungsi `main()` mengilustrasikan siklus hidup antrean melalui tiga tahap demonstrasi terstruktur:

1. **Tahap 1: Enqueue Elemen**
   - Objek antrean bertipe data string dibuat: `final antrian = Queue<String>();`.
   - Menambahkan `'Andi'`, `'Budi'`, dan `'Cici'` secara berurutan.
   - Setelah setiap penambahan, isi antrean dicetak ke layar (`[Andi]`, `[Andi, Budi]`, `[Andi, Budi, Cici]`).
   - Menampilkan total antrean (`length` bernilai `3`) dan elemen terdepan melalui `peek()` yang bernilai `'Andi'`.

2. **Tahap 2: Pop Elemen**
   - Memanggil `antrian.pop()` pertama: mengambil `'Andi'`. Antrean tersisa `[Budi, Cici]`.
   - Memanggil `antrian.pop()` kedua: mengambil `'Budi'`. Antrean tersisa `[Cici]`.
   - Memanggil `antrian.pop()` ketiga: mengambil `'Cici'`. Antrean menjadi kosong `[]`.
   - Urutan keluarnya data tepat mengikuti prinsip FIFO (`Andi` -> `Budi` -> `Cici`).

3. **Tahap 3: Uji Batas (Edge Case saat Antrean Kosong)**
   - Memanggil `antrian.pop()` saat antrean sudah tidak berisi elemen.
   - Nilai yang dikembalikan adalah `null` tanpa menimbulkan crash program atau *unhandled exception*.
   - Properti `antrian.isEmpty` dievaluasi dan menghasilkan nilai boolean `true`.

> **Catatan Kelengkapan:** Metode `clear()` dan getter `isNotEmpty` disediakan oleh kelas `Queue<T>` sebagai utilitas tambahan yang siap digunakan pengembang, meskipun alur simulasi pada `main()` berfokus pada verifikasi operasi inti (`enqueue`, `pop`, `peek`, dan `isEmpty`).

---

## Tabel Ringkasan Operasi dan Kompleksitas

| Operasi | Metode di `queue.dart` | Kompleksitas Waktu | Kompleksitas Ruang | Penjelasan |
| :--- | :--- | :---: | :---: | :--- |
| **Enqueue** | `enqueue(T item)` | `O(1)` amortized | `O(1)` per elemen | Menambahkan data ke indeks terakhir list internal. |
| **Dequeue / Pop** | `pop()` | `O(n)` | `O(1)` | Menghapus elemen indeks ke-0, menggeser seluruh elemen berikutnya ke depan. |
| **Peek** | `peek()` | `O(1)` | `O(1)` | Mengakses elemen pertama tanpa memodifikasi memori list. |
| **Cek Kosong** | `isEmpty` / `isNotEmpty` | `O(1)` | `O(1)` | Mengevaluasi status keterisian list internal. |
| **Hitung Panjang** | `length` | `O(1)` | `O(1)` | Membaca atribut panjang elemen list internal. |
| **Kosongkan** | `clear()` | `O(1)` / `O(n)` GC | `O(1)` | Menghapus seluruh referensi elemen pada list internal (waktu `O(1)` untuk reset panjang list; `O(n)` untuk dereferensi memori oleh Garbage Collector). |

*Kompleksitas ruang (space complexity) total dari struktur antrean adalah `O(n)`, di mana `n` adalah jumlah elemen yang sedang tersimpan dalam `_items`.*

### Analisis Efisiensi dan Alternatif Produksi

1. **Analisis `List.removeAt(0)`:**
   Pada implementasi `Queue` sederhana di `queue.dart`, operasi `pop()` memanfaatkan metode bawaan Dart `_items.removeAt(0)`. Karena `List` di Dart berbasis array kontigu dalam memori, menghapus elemen di indeks ke-0 mengharuskan seluruh `n - 1` elemen berikutnya digeser satu indeks ke kiri. Oleh karena itu, kompleksitas waktunya adalah `O(n)`.
2. **Kesesuaian untuk Praktikum & Pembelajaran:**
   Untuk keperluan tugas praktikum pemrograman dan pemahaman dasar algoritma struktur data FIFO, pendekatan ini sangat intuitif, tidak memerlukan ketergantungan pustaka luar, dan kodenya ringkas untuk dipelajari.
3. **Rekomendasi untuk Aplikasi Produksi:**
   Pada aplikasi berskala besar dengan volume antrean ribuan hingga jutaan transaksi per detik, disarankan menggunakan koleksi antrean bawaan Dart dari pustaka `dart:collection`:
   - **`ListQueue<E>`**: Menggunakan struktur data *circular buffer* yang dapat mengembang secara dinamis, sehingga operasi penambahan (*enqueue*) maupun pengambilan (*dequeue*) beroperasi dalam waktu konstan `O(1)` amortized.
   - **`DoubleLinkedQueue<E>`**: Menggunakan struktur *doubly linked list*, memungkinkan penambahan dan penghapusan di kedua ujung antrean dengan waktu konstan `O(1)` tanpa pergeseran memori array.

---

## Prasyarat dan Cara Menjalankan Program

### Prasyarat

- **Dart SDK** versi 3.0 atau yang lebih baru (dapat terpasang secara mandiri atau melalui paket Flutter SDK).
- Terminal atau konsol shell (PowerShell, Command Prompt / CMD, Bash, atau terminal bawaan IDE seperti VS Code / Antigravity IDE).

### Verifikasi Pemasangan Dart

Jalankan perintah berikut di terminal untuk memastikan Dart SDK telah terpasang dan dikenali oleh sistem operasi:

```bash
dart --version
```

### Langkah Menjalankan Program

1. Buka terminal dan navigasikan ke direktori proyek `QueueDart`:

   ```bash
   cd c:\Users\LOQ\testdrive_flutter\QueueDart
   ```

   *atau navigasi relatif jika terminal dibuka dari folder induk `testdrive_flutter`:*

   ```bash
   cd QueueDart
   ```

2. Jalankan berkas `queue.dart` dengan perintah:

   ```bash
   dart queue.dart
   ```

   *atau menggunakan subperintah `run`:*

   ```bash
   dart run queue.dart
   ```

3. Alternatif eksekusi dari direktori induk (`testdrive_flutter`):

   *Menggunakan slash (PowerShell / Bash):*

   ```bash
   dart QueueDart/queue.dart
   ```

   *atau menggunakan backslash (Command Prompt Windows):*

   ```cmd
   dart QueueDart\queue.dart
   ```

4. Verifikasi analisis statis kode (opsional untuk memastikan kode bebas galat):

   ```bash
   dart analyze queue.dart
   ```

---

## Dokumentasi dan Analisis Hasil Eksekusi (Folder `Screenshot`)

Folder `Screenshot` mendokumentasikan kode sumber dan bukti jalannya program di lingkungan Antigravity IDE:

### 1. Screenshot Kode Bagian 1 (`ss_code1.png`)

![Screenshot Kode 1](Screenshot/ss_code1.png)

- **Cakupan Baris:** Baris 1 sampai dengan baris 35 pada `queue.dart`.
- **Elemen yang Ditampilkan:**
  - Komentar dokumentasi prinsip FIFO.
  - Deklarasi kelas generik `Queue<T>` dan list privat `_items`.
  - Definisi fungsi `enqueue(T item)` untuk penambahan elemen.
  - Fungsi `pop()` lengkap dengan pengondisian nilai balik `null` jika antrean kosong.
  - Fungsi `peek()` untuk melihat elemen terdepan.
  - Properti *getter*: `isEmpty`, `isNotEmpty`, dan `length`.
- **Konteks Lingkungan IDE:** Ditampilkan pada editor Antigravity IDE (berbasis VS Code) dengan tema gelap, pewarnaan sintaks Dart aktif, dan penomoran baris yang rapi.

### 2. Screenshot Kode Bagian 2 (`ss_code2.png`)

![Screenshot Kode 2](Screenshot/ss_code2.png)

- **Cakupan Baris:** Baris 34 sampai dengan baris 66 pada `queue.dart`.
- **Elemen yang Ditampilkan:**
  - Metode `clear()` dan *override* metode `toString()`.
  - Penutup deklarasi kelas `Queue<T>`.
  - Permulaan fungsi `main()`.
  - Inisialisasi antrean objek string: `final antrian = Queue<String>();`.
  - Blok penambahan data (Enqueue): penambahan berturut-turut untuk nama `'Andi'`, `'Budi'`, dan `'Cici'`.
  - Pengecekan jumlah antrean (`antrian.length`) dan elemen terdepan (`antrian.peek()`).
- **Konteks Lingkungan IDE:** Panel penjelajah file (*Explorer*) di sisi kiri memperlihatkan struktur proyek `testdrive_flutter` beserta folder `Screenshot` dan berkas `queue.dart`. Di atas deklarasi `void main() {` tampak tombol aksi interaktif *CodeLens* (`Run | Debug`) khas integrasi ekstensi Dart di Antigravity IDE / VS Code, serta tajuk *sticky scroll* kelas `Queue<T>` pada baris teratas editor.

### 3. Screenshot Kode Bagian 3 (`ss_code3.png`)

![Screenshot Kode 3](Screenshot/ss_code3.png)

- **Cakupan Baris:** Baris 64 sampai dengan baris 83 pada `queue.dart`.
- **Elemen yang Ditampilkan:**
  - Blok pengambilan data (Pop): pemanggilan `antrian.pop()` sebanyak tiga kali yang mengeluarkan `'Andi'`, `'Budi'`, dan `'Cici'` secara bertahap.
  - Pencetakan status antrean yang berkurang setelah tiap operasi `pop`.
  - Pengujian penarikan elemen pada saat antrean telah kosong (`Pop saat antrian kosong`).
  - Validasi bahwa pemanggilan `pop()` pada kondisi kosong mengembalikan `null` dan pemeriksaan `antrian.isEmpty` menghasilkan `true`.
- **Konteks Lingkungan IDE:** Fitur *sticky scroll* editor mempertahankan tajuk `void main() {` di bagian atas editor saat menggulir ke bagian bawah kode.

### 4. Screenshot Terminal Eksekusi (`ss_run.png`)

![Screenshot Eksekusi](Screenshot/ss_run.png)

- **Aktivitas Terminal:** Eksekusi perintah `dart queue.dart` pada terminal PowerShell terintegrasi di lingkungan Antigravity IDE.
- **Konteks Direktori Kerja & Tata Letak:** Pada prompt terminal tertera `PS C:\Users\LOQ\testdrive_flutter> dart queue.dart`, yang menunjukkan perintah dijalankan saat sesi terminal berada di folder kerja `testdrive_flutter` tempat berkas `queue.dart` berada saat sesi praktikum. Tampilan editor terbagi menjadi dua bagian (*split layout*): panel atas menampilkan potongan kode fungsi `main()` (baris 48 s.d. 62) dan panel bawah menampilkan terminal PowerShell terintegrasi tempat proses eksekusi berlangsung.
- **Hasil Luaran (*Console Output*):**

  ```text
  PS C:\Users\LOQ\testdrive_flutter> dart queue.dart
  === Simulasi Queue (Antrian) ===

  -- Melakukan Enqueue --
  Enqueue Andi -> Antrian: [Andi]
  Enqueue Budi -> Antrian: [Andi, Budi]
  Enqueue Cici -> Antrian: [Andi, Budi, Cici]
  Jumlah antrian: 3
  Elemen terdepan (peek): Andi

  -- Melakukan Pop --
  Pop: Andi
  Antrian setelah pop: [Budi, Cici]
  Pop: Budi
  Antrian setelah pop: [Cici]
  Pop: Cici
  Antrian setelah pop: []

  -- Pop saat antrian kosong --
  Pop: null
  Apakah antrian kosong? true
  ```

- **Analisis Luaran:**
  1. Pada saat Enqueue, elemen baru selalu masuk ke indeks paling kanan / belakang, membentuk `[Andi, Budi, Cici]`.
  2. Nilai `peek` menunjukkan `'Andi'`, yaitu orang pertama yang mengantre, dengan jumlah antrean `3`.
  3. Pada saat Pop, elemen yang pertama keluar adalah `'Andi'`, kemudian `'Budi'`, dan terakhir `'Cici'`. Hal ini membuktikan implementasi FIFO berjalan tepat.
  4. Ketika antrean sudah kosong (`[]`), operasi `pop()` mengembalikan `null` secara aman dan `antrian.isEmpty` bernilai `true`.
