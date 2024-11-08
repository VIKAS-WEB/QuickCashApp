import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickcash/Screens/UserProfileScreen/DocumentsScreen/model/documentsApi.dart';
import '../../../constants.dart';
import '../../../util/apiConstants.dart';
import '../../../util/auth_manager.dart';

class DocumentsScreens extends StatefulWidget {
  const DocumentsScreens({super.key});

  @override
  State<DocumentsScreens> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreens> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DocumentsApi _documentsApi = DocumentsApi();

  String selectedRole = 'Select ID Of Individual'; // Default value for dropdown
  String? imagePath;
  String? documentPhotoFrontUrl;

  // Add Text controllers
  final TextEditingController _documentsNoController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    mDocumentsApi();  // Fetch data on initialization
  }

  Future<void> mDocumentsApi() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await _documentsApi.documentsApi();

      if (response.documentsDetails?.isNotEmpty ?? false) {
        final document = response.documentsDetails!.first;

        // Check if the document photo URL is not null
        if (document.documentPhotoFront != null) {
          documentPhotoFrontUrl =
          '${ApiConstants.baseImageUrl}${AuthManager.getUserId()}/${document.documentPhotoFront}';
        }

        // Check if the document number is not null
        if (document.documentsNo != null) {
          _documentsNoController.text = document.documentsNo!;
        }

        // Set the selected role (document type) based on the fetched data
        if (document.documentsType != null) {
          setState(() {
            selectedRole = document.documentsType!; // Set the dropdown value
          });
        }
      }

      print('Document Type: ${response.documentsDetails?.first.documentsType}');
      print('Document Number: ${response.documentsDetails?.first.documentsNo}');
      print('Document Photo: ${response.documentsDetails?.first.documentPhotoFront}');

    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: defaultPadding),

                    if (isLoading)
                      const CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    // Show loading indicator
                    if (errorMessage != null) // Show error message if there's an error
                      Text(errorMessage!,
                          style: const TextStyle(color: Colors.red)),
                    const SizedBox(
                      height: defaultPadding,
                    ),

                    // Document Image Section
                    Card(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: imagePath != null
                                ? Image.file(
                              File(imagePath!),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 250,
                            )
                                : Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmN0el3AEK0rjTxhTGTBJ05JGJ7rc4_GSW6Q&s',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 250,
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                final XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery);

                                if (image != null) {
                                  setState(() {
                                    imagePath = image.path; // Store the image path
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Image selected')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('No image selected.')),
                                  );
                                }
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.edit,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Document ID Number
                    const SizedBox(height: defaultPadding),
                    TextFormField(
                      controller: _documentsNoController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      cursorColor: kPrimaryColor,
                      onSaved: (value) {},
                      readOnly: false,
                      style: const TextStyle(color: kPrimaryColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Document ID No';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Document ID No",
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(),
                        ),
                      ),
                    ),

                    // Document Type (Dropdown)
                    const SizedBox(height: 25),
                    DropdownButtonFormField<String>(
                      value: selectedRole, // Set the dropdown value to selectedRole
                      style: const TextStyle(color: kPrimaryColor),
                      decoration: InputDecoration(
                        labelText: 'ID Of Individual',
                        labelStyle: const TextStyle(color: kPrimaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(),
                        ),
                      ),
                      items: ['Select ID Of Individual', 'Passport', 'Driving License']
                          .map((String role) {
                        return DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedRole = newValue!; // Update selected role
                        });
                      },
                    ),

                    // Update Button
                    const SizedBox(height: 35),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          if (selectedRole == "Select ID Of Individual") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please Select ID Of Individual')),
                            );
                          } else if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Form submitted successfully!')),
                            );
                          }
                        },
                        child: const Text('Update', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
