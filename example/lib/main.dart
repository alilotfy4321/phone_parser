import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_phone_parser/smart_phone_parser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Phone Parser - Enhanced Examples',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const PhoneParserEnhancedScreen(),
    );
  }
}

class PhoneParserEnhancedScreen extends StatefulWidget {
  const PhoneParserEnhancedScreen({super.key});

  @override
  State<PhoneParserEnhancedScreen> createState() => _PhoneParserEnhancedScreenState();
}

class _PhoneParserEnhancedScreenState extends State<PhoneParserEnhancedScreen> {
  // 3 Controllers for 3 different shapes
  late PhoneParserController _controller1; // Shape 1: Default
  late PhoneParserController _controller2; // Shape 2: Separated containers
  late PhoneParserController _controller3; // Shape 3: Custom with titles

  @override
  void initState() {
    super.initState();
    
    // Controller for Shape 1 (Default)
    _controller1 = PhoneParserController(
      config: const PhoneParserConfig(
        defaultCountryCode: '20',
        defaultFlagEmoji: '🇪🇬',
        defaultIsoCode: 'EG',
        defaultCountryName: 'Egypt',
      ),
    );
    
    // Controller for Shape 2 (Separated containers)
    _controller2 = PhoneParserController(
      config: const PhoneParserConfig(
        defaultCountryCode: '966',
        defaultFlagEmoji: '🇸🇦',
        defaultIsoCode: 'SA',
        defaultCountryName: 'Saudi Arabia',
      ),
    );
    
    // Controller for Shape 3 (Custom with titles)
    _controller3 = PhoneParserController(
      config: const PhoneParserConfig(
        defaultCountryCode: '1',
        defaultFlagEmoji: '🇺🇸',
        defaultIsoCode: 'US',
        defaultCountryName: 'United States',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Parser - 3 Different Shapes'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==============================================================
            // SHAPE 1: DEFAULT BUILDER (Simple and quick)
            // ==============================================================
            _buildShapeTitle('Shape 1: Default Builder', 
                'Simple - just provide controller and options'),
            const SizedBox(height: 12),
            
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Just use PhoneParserBuilder directly
                    PhoneParserBuilder(
                      controller: _controller1,
                      labelText: 'Mobile Number',
                      hintText: 'Enter your phone number',
                      radius: 12,
                      backgroundColor: Colors.grey.shade50,
                      borderColor: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 12),
                    
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _showData(_controller1, 'Shape 1'),
                            icon: const Icon(Icons.info),
                            label: const Text('Show Data'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _controller1.clear(),
                            icon: const Icon(Icons.clear),
                            label: const Text('Clear'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // ==============================================================
            // SHAPE 2: SEPARATED CONTAINERS (Country code and number separated)
            // ==============================================================
            _buildShapeTitle('Shape 2: Separated Containers', 
                'Country picker and number input are separate'),
            const SizedBox(height: 12),
            
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    PhoneParserBuilder(
                      controller: _controller2,
                      builder: (context, controller, status, showCountrySelector) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Separated Country Code Container
                            GestureDetector(
                              onTap: showCountrySelector,
                              child: Container(
                                height: 56,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.deepPurple.shade200),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      status.flagEmoji,
                                      style: const TextStyle(fontSize: 22),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '+${status.countryCode}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.deepPurple,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            
                            // Separated Number Input Container
                            Expanded(
                              child: Container(
                                height: 56,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: TextFormField(
                                  controller: controller.textController,
                                  keyboardType: TextInputType.phone,
                                  style: const TextStyle(fontSize: 16),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: const InputDecoration(
                                    hintText: 'Enter number',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _showData(_controller2, 'Shape 2'),
                            icon: const Icon(Icons.info),
                            label: const Text('Show Data'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              final uae = _MyCountry(
                                dialCode: '971',
                                flag: '🇦🇪',
                                isoCode: 'AE',
                                name: 'UAE',
                              );
                              _controller2.setCountry(uae);
                            },
                            icon: const Icon(Icons.public),
                            label: const Text('Switch UAE'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // ==============================================================
            // SHAPE 3: CUSTOM WITH TITLES (Professional form layout)
            // ==============================================================
            _buildShapeTitle('Shape 3: Custom with Titles', 
                'Professional form with labels and helper text'),
            const SizedBox(height: 12),
            
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    PhoneParserBuilder(
                      controller: _controller3,
                      builder: (context, controller, status, showCountrySelector) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title with flag
                            Row(
                              children: [
                                Text(
                                  status.flagEmoji,
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Phone Number',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            
                            // Country selector with title
                            const Text(
                              'Country Code',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(height: 4),
                            GestureDetector(
                              onTap: showCountrySelector,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Text(status.flagEmoji, style: const TextStyle(fontSize: 20)),
                                    const SizedBox(width: 8),
                                    Text('+${status.countryCode}',
                                        style: const TextStyle(fontWeight: FontWeight.bold)),
                                    const Spacer(),
                                    const Icon(Icons.arrow_drop_down, size: 20),
                                  ],
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Phone number input with title
                            const Text(
                              'Phone Number',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(height: 4),
                            TextFormField(
                              controller: controller.textController,
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(fontSize: 16),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                hintText: 'Enter your number',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _showData(_controller3, 'Shape 3'),
                            icon: const Icon(Icons.info),
                            label: const Text('Show Data'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _controller3.clear(),
                            icon: const Icon(Icons.clear),
                            label: const Text('Clear'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // ==============================================================
            // Live Data Display for all shapes
            // ==============================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📊 Live Data from All Shapes:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  
                  // Shape 1 Data
                  ValueListenableBuilder<ParsedPhone>(
                    valueListenable: _controller1,
                    builder: (context, phone, _) {
                      return _buildDataTile('Shape 1 (Default)', phone);
                    },
                  ),
                  
                  const Divider(),
                  
                  // Shape 2 Data
                  ValueListenableBuilder<ParsedPhone>(
                    valueListenable: _controller2,
                    builder: (context, phone, _) {
                      return _buildDataTile('Shape 2 (Separated)', phone);
                    },
                  ),
                  
                  const Divider(),
                  
                  // Shape 3 Data
                  ValueListenableBuilder<ParsedPhone>(
                    valueListenable: _controller3,
                    builder: (context, phone, _) {
                      return _buildDataTile('Shape 3 (With Titles)', phone);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShapeTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildDataTile(String title, ParsedPhone phone) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('   Country: ${phone.countryName} ${phone.flagEmoji}'),
          Text('   Code: +${phone.countryCode}'),
          Text('   Number: ${phone.nationalNumber.isEmpty ? "Empty" : phone.nationalNumber}'),
          Text('   Full: ${phone.fullNumber.isEmpty ? "Empty" : phone.fullNumber}'),
        ],
      ),
    );
  }

  void _showData(PhoneParserController controller, String title) {
    final phone = controller.value;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$title Data'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${phone.flagEmoji} ${phone.countryName}'),
            const SizedBox(height: 8),
            Text('ISO Code: ${phone.isoCode}'),
            Text('Country Code: +${phone.countryCode}'),
            Text('National Number: ${phone.nationalNumber.isEmpty ? "Empty" : phone.nationalNumber}'),
            Text('Full Number: ${phone.fullNumber.isEmpty ? "Empty" : phone.fullNumber}'),
            Text('Valid: ${phone.isValid ? "Yes ✓" : "No ✗"}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }
}

// Simple implementation of PickedCountryContract
class _MyCountry implements PickedCountryContract {
  @override
  final String dialCode;
  @override
  final String flag;
  @override
  final String isoCode;
  @override
  final String name;
  
  _MyCountry({
    required this.dialCode,
    required this.flag,
    required this.isoCode,
    required this.name,
  });
}