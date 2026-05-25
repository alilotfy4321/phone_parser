import 'package:example/simple_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:smart_phone_parser/smart_phone_parser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Phone Parser Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Multiple controllers for different examples
  final simpleController = SmartPhoneController();
  final profileController = SmartPhoneController();
  final favoritesController = SmartPhoneController();
  final formController = SmartPhoneController();
  final dialogController = SmartPhoneController();
  final customStyleController = SmartPhoneController();
  final minimalController = SmartPhoneController();
  final maskController = SmartPhoneController();

  final _formKey = GlobalKey<FormState>();
  String _submittedNumber = '';

  @override
  void initState() {
    super.initState();
    // Load default number for profile example
    profileController.setFullNumber('+201234567890');
  }

  @override
  void dispose() {
    simpleController.dispose();
    profileController.dispose();
    favoritesController.dispose();
    formController.dispose();
    dialogController.dispose();
    customStyleController.dispose();
    minimalController.dispose();
    maskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(  //this work with your local lang    if you need to test wrap with Directionality!!
        appBar: AppBar(
          title: const Text('Smart Phone Parser - All Examples'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Basic'),
              Tab(text: 'Features'),
              Tab(text: 'Styles'),
              Tab(text:'login'),
              Tab(text: 'Format'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildBasicTab(),
            _buildFeaturesTab(),
            _buildStylesTab(),
            LoginScreen(),
            _buildFormatTab(),
          ],
        ),
      ),
    );
  }

  // ==================== TAB 1: BASIC ====================

  Widget _buildBasicTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCard(
            title: '✨ Minimal Example',
            subtitle: 'Just 2 lines of code',
            icon: Icons.code,
            color: Colors.blue,
            child: Column(
              children: [
                SmartPhoneField(
                  controller: simpleController,
                  hintText: 'Enter your phone number',
                ),
                const SizedBox(height: 12),
                ValueListenableBuilder<ParsedPhone>(
                  valueListenable: simpleController,
                  builder: (context, phone, _) {
                    return _buildInfoCard(phone);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildCard(
            title: '📱 Profile Edit',
            subtitle: 'Load number from API automatically',
            icon: Icons.person,
            color: Colors.green,
            child: Column(
              children: [
                SmartPhoneField(
                  controller: profileController,
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            profileController.setFullNumber('+201234567890'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('🇪🇬 Egypt'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            profileController.setFullNumber('+966512345678'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text('🇸🇦 Saudi'),
                      ),
                    ),
                    
                  ],
                ),
                const SizedBox(height: 12),
                ValueListenableBuilder<ParsedPhone>(
                  valueListenable: profileController,
                  builder: (context, phone, _) {
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${phone.flagEmoji} ${phone.country.name}'),
                          Text(phone.dialCode),
                          Text(
                            phone.nationalNumber.isEmpty
                                ? "..."
                                : phone.nationalNumber,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildCard(
            title: '🏷️ With Labels',
            subtitle: 'Label and Helper Text',
            icon: Icons.label,
            color: Colors.purple,
            child: SmartPhoneField(
              controller: SmartPhoneController(),
              labelText: 'Mobile Number',
              hintText: 'Enter your mobile number',
              helperText: 'We will send verification code to this number',
              prefixIcon: const Icon(Icons.phone),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== TAB 2: FEATURES ====================

  Widget _buildFeaturesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCard(
            title: '⭐ Favorite Countries',
            subtitle: 'Pin frequently used countries at the top',
            icon: Icons.star,
            color: Colors.amber,
            child: Column(
              children: [
                SmartPhoneField(
                  controller: favoritesController,
                  labelText: 'Phone Number',
                  favoriteCountries: const ['EG', 'SA', 'AE', 'US', 'GB'],
                  hintText: 'Enter your number',
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '⭐ Favorite countries appear at the top of the country picker',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildCard(
            title: '✅ Form Validation',
            subtitle: 'With Form widget validation',
            icon: Icons.check_circle,
            color: Colors.green,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SmartPhoneField(
                    controller: formController,
                    labelText: 'Phone Number *',
                    hintText: 'Enter a valid international number',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required';
                      }
                      if (!formController.isValid) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _submittedNumber = formController.fullNumber;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('✅ Valid number!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 45),
                    ),
                  ),
                  if (_submittedNumber.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('✅ Submitted: $_submittedNumber'),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildCard(
            title: '📱 Dialog Picker',
            subtitle: 'Alternative to Bottom Sheet',
            icon: Icons.arrow_drop_up,
            color: Colors.purple,
            child: Column(
              children: [
                SmartPhoneField(
                  controller: dialogController,
                  labelText: 'Phone Number',
                  pickerType: CountryPickerType.dialog,
                  hintText: 'Tap country to change',
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '📱 Great for tablets and web platforms',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== TAB 3: STYLES ====================
  
  Widget _buildStylesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCard(
            title: '🎨 Custom Styling',
            subtitle: 'Custom colors and borders',
            icon: Icons.palette,
            color: Colors.deepPurple,
            child: SmartPhoneField(
              controller: customStyleController,
              labelText: 'Custom Design',
              hintText: 'Enter your number',
              theme: const SmartPhoneTheme(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderColor: Colors.deepPurple,
                focusedBorderColor: Colors.deepPurple,
                backgroundColor: Color(0xFFEDE7F6),
                flagSize: 28,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildCard(
            title: '🎯 Minimal Style',
            subtitle: 'Clean, no borders',
            icon: Icons.minimize,
            color: Colors.grey,
            child: SmartPhoneField(
              controller: minimalController,
              hintText: 'Phone number',
              theme: const SmartPhoneTheme(
                backgroundColor: Colors.transparent,
                borderColor: Colors.transparent,
                focusedBorderColor: Colors.transparent,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildCard(
            title: '🔧 Custom Builder',
            subtitle: '100% UI control',
            icon: Icons.build,
            color: Colors.orange,
            child: SmartPhoneField.custom(
              controller: customStyleController,
              builder: (context, controller, phone, openPicker) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF9800), Color(0xFFE65100)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: openPicker,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          child: Row(
                            children: [
                              Text(
                                phone.flagEmoji,
                                style: const TextStyle(fontSize: 28),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                phone.dialCode,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      Expanded(
                        child: TextField(
                          controller: controller.textController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Enter number',
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ==================== TAB 4: FORMAT ====================

  Widget _buildFormatTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCard(
            title: '🎨 Format Examples',
            subtitle: 'Different formatting options',
            icon: Icons.format_align_left,
            color: Colors.indigo,
            child: Column(
              children: [
                SmartPhoneField(
                  controller: maskController,
                  labelText: 'Enter phone number',
                  hintText: '+201234567890',
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder<ParsedPhone>(
                  valueListenable: maskController,
                  builder: (context, phone, _) {
                    if (!phone.isValid) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          '📝 Enter a valid number to see formatting options',
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return Column(
                      children: [
                        _buildFormatRow('E.164', PhoneFormatter.toE164(phone)),
                        _buildFormatRow(
                          'Readable',
                          PhoneFormatter.toReadable(phone),
                        ),
                        _buildFormatRow('Local', PhoneFormatter.toLocal(phone)),
                        _buildFormatRow(
                          'Mask ### #### ####',
                          PhoneFormatter.withMask(phone, mask: '### #### ####'),
                        ),
                        _buildFormatRow(
                          'Mask ##-###-####',
                          PhoneFormatter.withMask(phone, mask: '##-###-####'),
                        ),
                        _buildFormatRow(
                          'Mask (###) ###-####',
                          PhoneFormatter.withMask(
                            phone,
                            mask: '(###) ###-####',
                          ),
                        ),
                        _buildFormatRow(
                          'Country Format',
                          PhoneFormatter.withCountryFormat(phone),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== HELPER WIDGETS ====================

  Widget _buildCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(ParsedPhone phone) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text('🌍 Country: ${phone.country.phoneCode} ${phone.flagEmoji}'),
          const SizedBox(height: 4),
          Text(
            '📞 Full Number: ${phone.fullNumber.isEmpty ? "..." : phone.fullNumber}',
          ),
          const SizedBox(height: 4),
          Text('✅ Valid: ${phone.isValid ? "Yes ✅" : "No ❌"}'),
        ],
      ),
    );
  }

  Widget _buildFormatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(6),
              ),
              child: SelectableText(
                value,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}