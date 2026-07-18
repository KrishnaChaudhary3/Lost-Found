import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';

class ReportItemPage extends StatefulWidget {
  const ReportItemPage({super.key});

  @override
  State<ReportItemPage> createState() => _ReportItemPageState();
}

class _ReportItemPageState extends State<ReportItemPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String selectedType = 'lost';
  bool isLoading = false;
  bool isFetchingLocation = false;

  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  double? latitude;
  double? longitude;

  // ---------------- IMAGE PICKING ----------------

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1200,
      );
      if (picked != null) {
        setState(() => selectedImage = File(picked.path));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not access camera/gallery: $e")),
      );
    }
  }

  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            if (selectedImage != null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Remove photo', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => selectedImage = null);
                },
              ),
          ],
        ),
      ),
    );
  }

  // ---------------- LOCATION ----------------

  Future<void> _useCurrentLocation() async {
    setState(() => isFetchingLocation = true);

    try {

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showLocationError("Please turn on location services");
        return;
      }


      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showLocationError("Location permission denied");
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        _showLocationError("Location permission permanently denied. Enable it in app settings.");
        return;
      }


      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );

      latitude = position.latitude;
      longitude = position.longitude;


      try {
        final geocoder = Geocoding();
        final placemarks = await geocoder.placemarkFromCoordinates(latitude!, longitude!);
        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          final address = [place.name, place.street, place.locality]
              .where((part) => part != null && part.isNotEmpty)
              .join(', ');
          locationController.text = address.isNotEmpty
              ? address
              : '${latitude!.toStringAsFixed(5)}, ${longitude!.toStringAsFixed(5)}';
        }
      } catch (_) {
        // Reverse geocoding failed (e.g. no internet) — fall back to raw coordinates
        locationController.text = '${latitude!.toStringAsFixed(5)}, ${longitude!.toStringAsFixed(5)}';
      }

      setState(() {});
    } catch (e) {
      _showLocationError("Could not get location: $e");
    } finally {
      if (mounted) setState(() => isFetchingLocation = false);
    }
  }

  void _showLocationError(String message) {
    if (!mounted) return;
    setState(() => isFetchingLocation = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // ---------------- SUBMIT ----------------

  Future<void> submitReport() async {
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a title for the item")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      String? uploadedImageUrl;
      if (selectedImage != null) {
        uploadedImageUrl = await ApiService.uploadImage(selectedImage!);
      }

      final reportData = {
        "title": titleController.text.trim(),
        "description": descController.text.trim(),
        "location": locationController.text.trim(),
        "lat": latitude,
        "lng": longitude,
        "type": selectedType,
        "category": "general",
        "imageUrl": uploadedImageUrl,
      };

      final success = await ApiService.submitReport(reportData);

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Item reported successfully")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to submit report")),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to connect to backend: $e")),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Report Item")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: _showImageSourceSheet,
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: selectedImage != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(selectedImage!, fit: BoxFit.cover, width: double.infinity, height: 180),
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo, size: 40, color: Colors.grey.shade600),
                      const SizedBox(height: 8),
                      Text("Tap to add a photo", style: TextStyle(color: Colors.grey.shade600)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Item Title',
                  prefixIcon: Icon(Icons.title),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description_outlined),
                ),
              ),
              const SizedBox(height: 12),

              // Location field with GPS button
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  prefixIcon: const Icon(Icons.location_on_outlined),
                  suffixIcon: isFetchingLocation
                      ? const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                      : IconButton(
                    icon: const Icon(Icons.my_location),
                    tooltip: 'Use current location',
                    onPressed: _useCurrentLocation,
                  ),
                ),
              ),
              if (latitude != null && longitude != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "📍 GPS location attached",
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ),
                ),

              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedType,
                items: const [
                  DropdownMenuItem(value: 'lost', child: Text('Lost')),
                  DropdownMenuItem(value: 'found', child: Text('Found')),
                ],
                onChanged: (value) {
                  setState(() => selectedType = value!);
                },
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : submitReport,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                      : const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
