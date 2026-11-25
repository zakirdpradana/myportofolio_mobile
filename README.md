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
- 18 Nov 2026 - Tutorial 9: Mengimplementasikan navigasi menggunakan drawer menu, menambahkan form untuk data pengalaman, dan melakukan refactor kode
- 23 Nov 2026 - Tugas 8: Menambahkan form untuk data pendidikan beserta navigasi antar halamannya, serta fitur tambahan berupa tombol reset form
- 25 Nov 2026 - Tutorial 10: Menghubungkan data experience dengan website Django menggunakan API endpoints, menyesuaikan Model dan Form untuk Experience, membuat halaman untuk login, serta menyiapkan CI/CD menggunakan GitHub Actions

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

---

### Tugas 8

1.  Perbedaan ketiga metode Navigator tersebut terletak pada cara masing-masing mengelola dan memanipulasi route di puncak stack. Metode Navigator.push() menambahkan route baru ke bagian paling atas stack agar halaman baru tersebut tampil di atas halaman sebelumnya. Sebaliknya, metode Navigator.pushReplacement() menghapus route aktif di puncak stack dan menggantinya secara langsung dengan route baru tanpa mengubah elemen stack di bawahnya. Sementara itu, metode Navigator.pop() menghapus route teratas untuk kembali ke halaman yang berada tepat di bawahnya.

    Untuk membuka formulir dari kartu aksi (ItemCard), metode yang digunakan adalah Navigator.push() dengan MaterialPageRoute yang mengarah ke FormPage. Metode ini memungkinkan pengguna tetap bisa kembali ke halaman menu sebelumnya melalui tombol Back atau metode Navigator.pop(). Sementara itu, opsi Home di drawer memanggil Navigator.pushReplacement() yang mengarah ke MyHomePage() pada properti onTap, sehingga route yang sedang aktif saat ini akan langsung digantikan oleh MyHomePage() tanpa menambah tumpukan halaman baru.

2.  Susunan Scaffold, AppBar, dan Drawer menjaga konsistensi antarmuka dengan menyediakan kerangka halaman standar untuk berbagai layar aplikasi yang menyatukan bilah atas (AppBar), menu navigasi samping (drawer), dan konten utama (body). Melalui struktur ini, AppBar menyeragamkan tampilan kepala halaman melalui pengaturan judul, warna latar belakang, dan gaya ikon. Sementara itu, komponen LeftDrawer beserta DrawerHeader-nya dapat digunakan ulang secara identik pada berbagai layar, baik pada halaman utama (MyHomePage), maupun halaman formulir (FormPage).   

    Contoh penggunaan warna tema di lebih dari satu halaman adalah penerapan Colors.indigo yang selaras dengan warna primer tema (Theme.of(context).colorScheme.primary) secara konsisten di berbagai halaman. Warna tema ini digunakan pada AppBar dan bingkai avatar di halaman utama (MyHomePage), latar belakang DrawerHeader di dalam LeftDrawer, serta pada AppBar, CheckboxListTile (activeColor), tombol OutlinedButton, dan tombol simpan ElevatedButton di halaman EducationFormPage.

3.  Tata letak yang memadukan widget Form, SingleChildScrollView, dan Column dipilih untuk formulir karena masing-masing memiliki fungsi terstruktur dalam mengelola antarmuka masukan pengguna. Widget Form berfungsi sebagai wadah terpusat untuk mengelola state dan validasi seluruh input field. Kemudian, di dalamnya, widget Column dengan CrossAxisAlignment.start menyusun kolom isian dan tombol secara vertikal dari atas ke bawah agar rapi dan mudah diikuti. 

    Ketika ruang layar terbatas, widget pengatur jarak, seperti Padding memberi ruang batas di sekeliling setiap elemen agar tidak berhimpitan dan SizedBox mengatur jarak pemisah antarkomponen. Sedangkan, widget penggulir SingleChildScrollView membungkus Column yang secara default tidak dapat di-scroll agar seluruh isi formulir tetap dapat digulir saat melebihi tinggi layar.

4.  Saat tombol Simpan ditekan, GlobalKey\<FormState\> yang terpasang pada atribut key milik widget Form berperan untuk mengakses state formulir agar pemanggilan metode validate() dapat mengeksekusi seluruh fungsi validator di setiap field input. Masing-masing validator kemudian memeriksa kelayakan nilai masukan dan mengembalikan teks pesan kesalahan jika tidak memenuhi syarat, atau mengembalikan null apabila seluruh input valid sebelum nantinya data diproses lebih lanjut. Sebagai contoh, masukan berupa teks kosong ("") atau yang hanya berisi karakter spasi ("   ") akan ditolak oleh logika validasi yang memeriksa kondisi null maupun string kosong setelah spasi dihapus (trim().isEmpty). Oleh karena itu, memilih jenis widget input atau tipe papan ketik saja belum cukup karena hal tersebut hanya mengatur antarmuka masukan pengguna tanpa mampu mencegah pengguna membiarkan kolom wajib tetap kosong, hanya mengisinya dengan spasi, atau mengirimkan data yang melanggar aturan validasi formulir.

**AI Disclosure**:
Saya menggunakan Gemini AI untuk membantu pengerjaan tugas ini. Secara umum, saya hanya menggunakan Gemini AI untuk mengusulkan saya ide, membuat kode yang sebelumnya belum diimplementasikan/dicontohkan di berkas tutorial, serta untuk mengoreksi/men-debug kode yang telah saya buat. Berikut ini penjelaskan lebih detailnya. Pertama, saya meminta Gemini AI untuk memberikan arahan dalam mengimplementasikan input tanggal pada education form. Kemudian, saya memintanya untuk memberikan saya saran dalam memilih warna untuk widget action card, serta ide untuk fitur tambahan. Terakhir, saya meminta Gemini AI untuk mengoreksi dan melakukan debugging terdahap kode yang telah saya buat. 

**Link**: https://share.gemini.google/b1guKVpze7Zn