import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/book.dart';
import '../bloc/book_bloc.dart';


class BookDetail extends StatefulWidget {
  final Book book;
  
  const BookDetail({super.key, required this.book});

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _judulController;
  late TextEditingController _hargaController;
  late TextEditingController _jumlahController;
  late TextEditingController _tanggalController;
  late TextEditingController _volumeController;
  late TextEditingController _penulisController;
  late TextEditingController _penerbitController;
  
  bool _isLoading = false;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    
    _judulController = TextEditingController(text: widget.book.judul);
    _hargaController = TextEditingController(text: widget.book.harga.toString());
    _jumlahController = TextEditingController(text: widget.book.jumlah.toString());
    _tanggalController = TextEditingController(text: widget.book.tanggalMasuk);
    _volumeController = TextEditingController(text: widget.book.volume.toString());
    _penulisController = TextEditingController(text: widget.book.penulis);
    _penerbitController = TextEditingController(text: widget.book.penerbit);
    
    try {
      _selectedDate = DateTime.parse(widget.book.tanggalMasuk);
    } catch (e) {
      _selectedDate = DateTime.now();
      _tanggalController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F1),
      appBar: AppBar(
        title: const Text('Edit Data Buku'),
        backgroundColor: const Color(0xFF5D4E37),
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF5D4E37),
                Color(0xFF8B6F47),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header section
            Center(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8D5C4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit_document,
                      size: 40,
                      color: Color(0xFF8B6F47),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Perbarui Informasi',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C2417),
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ubah detail buku yang diperlukan',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Form in card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Judul
                    _buildFormSection(
                      'Judul Buku',
                      _buildTextField(
                        controller: _judulController,
                        label: 'Masukkan judul buku',
                        icon: Icons.book_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Judul buku tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Penulis
                    _buildFormSection(
                      'Penulis',
                      _buildTextField(
                        controller: _penulisController,
                        label: 'Nama penulis',
                        icon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Penulis tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Penerbit
                    _buildFormSection(
                      'Penerbit',
                      _buildTextField(
                        controller: _penerbitController,
                        label: 'Nama penerbit',
                        icon: Icons.business_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Penerbit tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Divider
                    Container(
                      height: 1,
                      color: Colors.grey[300],
                      margin: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    const SizedBox(height: 12),
                    // Row: Harga and Stok
                    Row(
                      children: [
                        Expanded(
                          child: _buildFormSection(
                            'Harga (Rp)',
                            _buildTextField(
                              controller: _hargaController,
                              label: '0',
                              icon: Icons.attach_money,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tidak boleh kosong';
                                }
                                if (int.tryParse(value) == null || int.parse(value) <= 0) {
                                  return 'Angka tidak valid';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildFormSection(
                            'Jumlah Stok',
                            _buildTextField(
                              controller: _jumlahController,
                              label: '0',
                              icon: Icons.inventory_2_outlined,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Tidak boleh kosong';
                                }
                                if (int.tryParse(value) == null || int.parse(value) < 0) {
                                  return 'Angka tidak valid';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Volume
                    _buildFormSection(
                      'Volume (Halaman)',
                      _buildTextField(
                        controller: _volumeController,
                        label: '0',
                        icon: Icons.description_outlined,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Volume tidak boleh kosong';
                          }
                          if (int.tryParse(value) == null || int.parse(value) <= 0) {
                            return 'Volume harus berupa angka yang valid';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Tanggal Masuk
                    _buildFormSection(
                      'Tanggal Masuk',
                      TextFormField(
                        controller: _tanggalController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Pilih tanggal',
                          filled: true,
                          fillColor: const Color(0xFFFAF6F1),
                          prefixIcon: const Icon(Icons.calendar_today_outlined, color: Color(0xFF8B6F47)),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.edit_calendar, color: Color(0xFF8B6F47)),
                            onPressed: _selectDate,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF8B6F47), width: 2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2C2417),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tanggal masuk tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Submit Button
                    SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B6F47),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                'Perbarui Buku',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFormSection(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF8B6F47),
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        fillColor: const Color(0xFFFAF6F1),
        prefixIcon: Icon(icon, color: const Color(0xFF8B6F47)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF8B6F47), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF2C2417),
      ),
      validator: validator,
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF8B6F47),
              onPrimary: Colors.white,
              onSurface: Color(0xFF2C2417),
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _tanggalController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final bookUpdate = Book(
        id: widget.book.id,
        judul: _judulController.text.trim(),
        harga: int.parse(_hargaController.text),
        jumlah: int.parse(_jumlahController.text),
        tanggalMasuk: _tanggalController.text,
        volume: int.parse(_volumeController.text),
        penulis: _penulisController.text.trim(),
        penerbit: _penerbitController.text.trim(),
      );

      final result = await BookBloc.updateBook(bookUpdate);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            backgroundColor: result['success'] ? Colors.green : Colors.red,
          ),
        );

        if (result['success']) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Terjadi kesalahan sistem'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _hargaController.dispose();
    _jumlahController.dispose();
    _tanggalController.dispose();
    _volumeController.dispose();
    _penulisController.dispose();
    _penerbitController.dispose();
    super.dispose();
  }
}