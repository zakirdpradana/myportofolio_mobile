# Portofolio Mobile App - Tugas Mata Kuliah Pemrograman Berbasis Platform

**Nama**        : Muhammad Zaki Radipradana  
**NPM**         : 2506599541  
**Kelas**       : PBP D  

---

## Deskripsi Proyek
Proyek ini adalah sebuah portofolio pribadi berbasis aplikasi mobile yang dibangun secara bertahap dan nantinya akan menjadi luaran akhir mahasiswa dari mata kuliah Pemrograman Berbasis Platform (PBP) di Fakultas Ilmu Komputer, Universitas Indonesia. Aplikasi ini baru dapat berfungsi untuk menampilkan profil saya. Namun kedepannya, akan ditambahkan fitur-fitur lain yang dapat menunjang portofolio ini, sehingga dapat lebih lengkap lagi. 

---

## Progress Mingguan
- 11 Nov 2026 - Tutorial 8: Melakukan setup dan inisialisasi project
- 16 Nov 2026 - Tugas 7: Mengubah profil portofolio, membuat tombol aksi Lihat Pendidikan, mengubah tombol Lihat Proyek dan Tambah Proyek menjadi Lihat Pengalaman dan Tambah Pengalaman, mengubah warna tombol aksi, dan menambahkan widget profile/avatar image 

---

### Tugas 7

1.  Dalam Flutter, widget tree adalah struktur hierarkis menyerupai pohon yang memetakan seluruh susunan elemen antarmuka pengguna (UI) dalam sebuah aplikasi. Susunan hierarkis ini dimulai dari widget akar (root) di bagian paling atas yang kemudian bercabang ke berbagai sub-komponen UI yang lebih spesifik di bawahnya.

    Hubungan induk-anak (parent-child) antar-widget bekerja melalui mekanisme tata letak yang mengikuti prinsip "constraints go down, sizes go up, parent sets position". Widget induk akan meneruskan batasan dimensi widget ke bawah kepada widget anak. Setelah menerima batasan tersebut, widget anak menentukan ukurannya sendiri dan mengirimkan informasi ukuran tersebut kembali ke atas kepada induknya, yang kemudian bertugas menentukan posisi koordinat akhir tempat widget anak tersebut ditampilkan di layar.

2.  Berikut ini adalah widget yang saya gunakan dalam proyek ini:

    #### A. Custom Widgets
    | Nama Widget | Fungsi |
    | :--- | :--- |
    | **`MyApp`** | Widget akar yang membungkus keseluruhan aplikasi dan dipanggil pertama kali oleh fungsi `main()`. Widget ini mengatur konfigurasi dasar aplikasi melalui `MaterialApp`. |
    | **`MyHomePage`** | Widget halaman utama yang menyusun seluruh tampilan beranda aplikasi, mulai dari `AppBar`, foto profil, informasi pemilik portofolio, hingga tombol-tombol menu. |
    | **`InfoCard`** | Widget kartu kustom untuk menampilkan informasi pemilik portofolio dalam bentuk kartu yang terdiri atas judul (`title`) dan isi (`content`), seperti NPM, nama, dan kelas. |
    | **`ItemCard`** | Widget kartu menu interaktif yang menampilkan ikon dan nama menu berdasarkan objek `ItemHomepage`. Widget ini juga menangani interaksi pengguna dengan menampilkan `SnackBar` ketika kartu ditekan. |

    #### B. Built-in Widgets
    | Nama Widget | Fungsi |
    | :--- | :--- |
    | **`MaterialApp`** | Mengatur konfigurasi dasar aplikasi berbasis Material Design. |
    | **`Scaffold`** | Menyediakan struktur dasar tata letak halaman aplikasi. |
    | **`AppBar`** | Menampilkan bagian atas halaman yang berisi judul aplikasi dan warna latar belakang sesuai dengan tema utama. |
    | **`SingleChildScrollView`** | Membungkus konten halaman agar dapat digulir secara vertikal ketika konten melebihi ukuran layar, sehingga mengurangi risiko terjadinya overflow. |
    | **`Column`** | Menyusun beberapa widget anak secara vertikal dari atas ke bawah. Digunakan untuk menyusun konten utama halaman, informasi pada `InfoCard`, serta ikon dan teks pada `ItemCard`. |
    | **`Row`** | Menyusun ketiga widget `InfoCard` secara horizontal dalam satu baris dengan jarak yang merata. |
    | **`GridView.count`** | Menampilkan kumpulan `ItemCard` dalam tata letak grid dengan jumlah kolom yang ditentukan melalui `crossAxisCount`. |
    | **`Container`** | Berfungsi sebagai wadah untuk mengatur ukuran, padding, dan dekorasi widget. |
    | **`Padding`** | Memberikan ruang kosong di antara batas luar widget dan widget anaknya, sehingga tata letak memiliki jarak yang lebih rapi. |
    | **`SizedBox`** | Memberikan ruang kosong dengan ukuran tertentu untuk mengatur jarak antar-widget. |
    | **`Center`** | Memposisikan widget anak di bagian tengah area yang tersedia. |
    | **`Text`** | Menampilkan elemen teks pada aplikasi. |
    | **`CircleAvatar`** | Menampilkan foto profil pengguna dalam bentuk lingkaran. |
    | **`Card`** | Menampilkan informasi pengguna dalam bentuk kartu dengan tampilan Material Design. |
    | **`Material`** | Menyediakan permukaan dengan tampilan Material Design, termasuk warna latar belakang dan sudut melengkung (`borderRadius`) pada `ItemCard`. |
    | **`Icon`** | Menampilkan ikon grafis yang merepresentasikan setiap menu berdasarkan properti `item.icon`. |
    | **`InkWell`** | Membuat `ItemCard` dapat merespons sentuhan pengguna melalui properti `onTap` dan memberikan ripple effect ketika ditekan. |
    | **`SnackBar`** | Menampilkan pesan notifikasi sementara di bagian bawah layar setiap kali pengguna menekan salah satu tombol `ItemCard`. |

3.  MaterialApp berfungsi untuk mengatur konfigurasi dasar aplikasi serta serta menyediakan berbagai fitur penting dalam membangun aplikasi berbasis Google Material Design, seperti pengaturan tema, navigasi dan routing, pengaturan judul aplikasi, serta lokalisasi bahasa. Widget ini umumnya ditempatkan sebagai root widget agar seluruh konfigurasi dan fitur global tersebut dapat diwariskan secara otomatis ke seluruh elemen di dalam widget tree.

4.  StatelessWidget dan StatefulWidget dibedakan berdasarkan kemampuannya untuk mengelola perubahan state. StatelessWidget adalah widget yang bersifat statis/immutable dan tidak memiliki state yang dapat berubah selama widget tersebut ditampilkan. Tampilan yang dihasilkan hanya bergantung pada parameter yang diterima saat widget dibuat. Sebaliknya, StatefulWidget adalah widget bersifat dinamis/mutable dan memiliki state yang dapat berubah selama aplikasi berjalan. Perubahan tersebut dapat diperbarui menggunakan fungsi setState(), sehingga Flutter akan membangun ulang tampilan widget sesuai dengan kondisi terbaru.

    StatelessWidget sebaiknya digunakan ketika tampilan bersifat statis dan tidak memerlukan perubahan data secara langsung, misalnya untuk menampilkan teks, ikon, atau informasi tetap. Sementara itu, StatefulWidget digunakan ketika widget perlu merespons interaksi pengguna atau perubahan data, seperti formulir input atau tombol untuk mengubah status tampilan.

5.  BuildContext adalah objek yang merepresentasikan posisi suatu widget dalam widget tree. Objek ini penting karena memungkinkan sebuah widget untuk mengakses informasi dan layanan yang disediakan oleh widget-widget di atasnya. BuildContext umumnya digunakan dalam metode build sebagai parameter untuk mengakses informasi dari widget tree serta menentukan bagaimana tampilan widget akan dibangun.

6.  Hot reload adalah fitur Flutter yang memungkinkan developer menerapkan perubahan kode ke aplikasi yang sedang berjalan tanpa harus memulai ulang aplikasi dari awal dengan mempertahankan state yang sedang berjalan. Berbeda halnya dengan hot restart. Hot restart akan memulai ulang aplikasi dari awal dengan menjalankan kembali kode program, sehingga seluruh state yang tersimpan selama aplikasi berjalan akan direset dan aplikasi membutuhkan waktu yang lebih lama untuk menginisasi ulang. 

    Hot reload tidak selalu dapat digunakan untuk semua perubahan kode. Kita perlu melakukan hot restart ketika kode yang diubah berkaitan dengan inisialisasi awal aplikasi, variabel global atau static, atau struktur tertentu yang memerlukan eksekusi ulang dari awal. Sementara itu, full restart diperlukan ketika perubahan melibatkan kode native Android/iOS, seperti konfigurasi Gradle, perubahan pada file AndroidManifest.xml, atau penambahan plugin native yang membutuhkan proses kompilasi ulang aplikasi.

**AI Disclosure**:
Pada tugas 7 ini saya dibantu oleh Gemini AI. Diawal, saya meminta AI untuk menjabarkan hal dan kode apa saja yang perlu saya implementasikan pada tugas 7 ini. Kemudian, untuk setiap minimal checklist yang ada di berkas tugas, saya meminta AI untuk memeriksa kesesuaian dari kode yang telah saya buat. Saya juga meminta AI untuk menyesuaikan tata letak, warna, dan icon dari widget yang ada di project saya. Terakhir, saya meminta AI untuk membuatkan kode dari widget avatar/profile image.

**Link**: https://share.gemini.google/rgvDRwq00BJo