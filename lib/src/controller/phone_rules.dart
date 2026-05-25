class PhoneRules {
  final String countryCode;
  final int minLength;
  final int maxLength;
  final List<String> allowedPrefixes;
  final bool removeLeadingZero;
  final String countryName;
  final String isoCode;
  final String flagEmoji;

  const PhoneRules({
    required this.countryCode,
    required this.minLength,
    required this.maxLength,
    required this.allowedPrefixes,
    required this.removeLeadingZero,
    required this.countryName,
    required this.isoCode,
    required this.flagEmoji,
  });

  // قواعد جميع دول العالم
  static const Map<String, PhoneRules> rules = {
    // ==================== أفريقيا ====================
    
    // مصر
    '20': PhoneRules(
      countryCode: '20',
      minLength: 10,
      maxLength: 10,
      allowedPrefixes: ['10', '11', '12', '15'],
      removeLeadingZero: true,
      countryName: 'Egypt',
      isoCode: 'EG',
      flagEmoji: '🇪🇬',
    ),
    
    // المغرب
    '212': PhoneRules(
      countryCode: '212',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['6', '7', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79'],
      removeLeadingZero: true,
      countryName: 'Morocco',
      isoCode: 'MA',
      flagEmoji: '🇲🇦',
    ),
    
    // الجزائر
    '213': PhoneRules(
      countryCode: '213',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['5', '6', '7', '55', '56', '57', '58', '59', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79'],
      removeLeadingZero: true,
      countryName: 'Algeria',
      isoCode: 'DZ',
      flagEmoji: '🇩🇿',
    ),
    
    // تونس
    '216': PhoneRules(
      countryCode: '216',
      minLength: 8,
      maxLength: 8,
      allowedPrefixes: ['2', '5', '9', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '90', '91', '92', '93', '94', '95', '96', '97', '98', '99'],
      removeLeadingZero: true,
      countryName: 'Tunisia',
      isoCode: 'TN',
      flagEmoji: '🇹🇳',
    ),
    
    // ليبيا
    '218': PhoneRules(
      countryCode: '218',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['9', '91', '92', '93', '94', '95', '96', '97', '98', '99'],
      removeLeadingZero: true,
      countryName: 'Libya',
      isoCode: 'LY',
      flagEmoji: '🇱🇾',
    ),
    
    // السودان
    '249': PhoneRules(
      countryCode: '249',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['9', '10', '11', '12', '90', '91', '92', '93', '94', '95', '96', '97', '98', '99'],
      removeLeadingZero: true,
      countryName: 'Sudan',
      isoCode: 'SD',
      flagEmoji: '🇸🇩',
    ),
    
    // جنوب أفريقيا
    '27': PhoneRules(
      countryCode: '27',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['6', '7', '8', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '80', '81', '82', '83', '84', '85', '86', '87', '88', '89'],
      removeLeadingZero: true,
      countryName: 'South Africa',
      isoCode: 'ZA',
      flagEmoji: '🇿🇦',
    ),
    
    // نيجيريا
    '234': PhoneRules(
      countryCode: '234',
      minLength: 10,
      maxLength: 10,
      allowedPrefixes: ['7', '8', '9', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '80', '81', '82', '83', '84', '85', '86', '87', '88', '89', '90', '91', '92', '93', '94', '95', '96', '97', '98', '99'],
      removeLeadingZero: true,
      countryName: 'Nigeria',
      isoCode: 'NG',
      flagEmoji: '🇳🇬',
    ),
    
    // كينيا
    '254': PhoneRules(
      countryCode: '254',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['7', '1', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79'],
      removeLeadingZero: true,
      countryName: 'Kenya',
      isoCode: 'KE',
      flagEmoji: '🇰🇪',
    ),
    
    // غانا
    '233': PhoneRules(
      countryCode: '233',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['2', '5', '20', '23', '24', '26', '27', '28', '50', '54', '55', '56', '57', '59'],
      removeLeadingZero: true,
      countryName: 'Ghana',
      isoCode: 'GH',
      flagEmoji: '🇬🇭',
    ),
    
    // إثيوبيا
    '251': PhoneRules(
      countryCode: '251',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['9', '91', '92', '93', '94', '95', '96', '97', '98', '99'],
      removeLeadingZero: true,
      countryName: 'Ethiopia',
      isoCode: 'ET',
      flagEmoji: '🇪🇹',
    ),
    
    // ==================== آسيا ====================
    
    // السعودية
    '966': PhoneRules(
      countryCode: '966',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['5', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59'],
      removeLeadingZero: true,
      countryName: 'Saudi Arabia',
      isoCode: 'SA',
      flagEmoji: '🇸🇦',
    ),
    
    // الإمارات
    '971': PhoneRules(
      countryCode: '971',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['50', '52', '54', '55', '56', '58'],
      removeLeadingZero: true,
      countryName: 'United Arab Emirates',
      isoCode: 'AE',
      flagEmoji: '🇦🇪',
    ),
    
    // الكويت
    '965': PhoneRules(
      countryCode: '965',
      minLength: 8,
      maxLength: 8,
      allowedPrefixes: ['5', '6', '9', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '90', '91', '92', '93', '94', '95', '96', '97', '98', '99'],
      removeLeadingZero: false,
      countryName: 'Kuwait',
      isoCode: 'KW',
      flagEmoji: '🇰🇼',
    ),
    
    // قطر
    '974': PhoneRules(
      countryCode: '974',
      minLength: 8,
      maxLength: 8,
      allowedPrefixes: ['3', '5', '6', '7', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79'],
      removeLeadingZero: false,
      countryName: 'Qatar',
      isoCode: 'QA',
      flagEmoji: '🇶🇦',
    ),
    
    // البحرين
    '973': PhoneRules(
      countryCode: '973',
      minLength: 8,
      maxLength: 8,
      allowedPrefixes: ['3', '6', '9', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '90', '91', '92', '93', '94', '95', '96', '97', '98', '99'],
      removeLeadingZero: false,
      countryName: 'Bahrain',
      isoCode: 'BH',
      flagEmoji: '🇧🇭',
    ),
    
    // عمان
    '968': PhoneRules(
      countryCode: '968',
      minLength: 8,
      maxLength: 8,
      allowedPrefixes: ['7', '9', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '90', '91', '92', '93', '94', '95', '96', '97', '98', '99'],
      removeLeadingZero: false,
      countryName: 'Oman',
      isoCode: 'OM',
      flagEmoji: '🇴🇲',
    ),
    
    // الأردن
    '962': PhoneRules(
      countryCode: '962',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['7', '77', '78', '79'],
      removeLeadingZero: true,
      countryName: 'Jordan',
      isoCode: 'JO',
      flagEmoji: '🇯🇴',
    ),
    
    // لبنان
    '961': PhoneRules(
      countryCode: '961',
      minLength: 8,
      maxLength: 8,
      allowedPrefixes: ['3', '7', '70', '71', '76', '78', '79', '81'],
      removeLeadingZero: true,
      countryName: 'Lebanon',
      isoCode: 'LB',
      flagEmoji: '🇱🇧',
    ),
    
    // فلسطين
    '970': PhoneRules(
      countryCode: '970',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['5', '56', '57', '58', '59'],
      removeLeadingZero: true,
      countryName: 'Palestine',
      isoCode: 'PS',
      flagEmoji: '🇵🇸',
    ),
    
    // العراق
    '964': PhoneRules(
      countryCode: '964',
      minLength: 10,
      maxLength: 10,
      allowedPrefixes: ['7', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79'],
      removeLeadingZero: true,
      countryName: 'Iraq',
      isoCode: 'IQ',
      flagEmoji: '🇮🇶',
    ),
    
    // سوريا
    '963': PhoneRules(
      countryCode: '963',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['9', '93', '94', '95', '96', '98', '99'],
      removeLeadingZero: true,
      countryName: 'Syria',
      isoCode: 'SY',
      flagEmoji: '🇸🇾',
    ),
    
    // اليمن
    '967': PhoneRules(
      countryCode: '967',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['7', '70', '71', '73', '77'],
      removeLeadingZero: true,
      countryName: 'Yemen',
      isoCode: 'YE',
      flagEmoji: '🇾🇪',
    ),
    
    // الهند
    '91': PhoneRules(
      countryCode: '91',
      minLength: 10,
      maxLength: 10,
      allowedPrefixes: ['6', '7', '8', '9', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '80', '81', '82', '83', '84', '85', '86', '87', '88', '89', '90', '91', '92', '93', '94', '95', '96', '97', '98', '99'],
      removeLeadingZero: false,
      countryName: 'India',
      isoCode: 'IN',
      flagEmoji: '🇮🇳',
    ),
    
    // باكستان
    '92': PhoneRules(
      countryCode: '92',
      minLength: 10,
      maxLength: 10,
      allowedPrefixes: ['3', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39'],
      removeLeadingZero: true,
      countryName: 'Pakistan',
      isoCode: 'PK',
      flagEmoji: '🇵🇰',
    ),
    
    // تركيا
    '90': PhoneRules(
      countryCode: '90',
      minLength: 10,
      maxLength: 10,
      allowedPrefixes: ['5', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59'],
      removeLeadingZero: true,
      countryName: 'Turkey',
      isoCode: 'TR',
      flagEmoji: '🇹🇷',
    ),
    
    // إيران
    '98': PhoneRules(
      countryCode: '98',
      minLength: 10,
      maxLength: 10,
      allowedPrefixes: ['9', '90', '91', '92', '93', '99'],
      removeLeadingZero: true,
      countryName: 'Iran',
      isoCode: 'IR',
      flagEmoji: '🇮🇷',
    ),
    
    // أفغانستان
    '93': PhoneRules(
      countryCode: '93',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['7', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79'],
      removeLeadingZero: true,
      countryName: 'Afghanistan',
      isoCode: 'AF',
      flagEmoji: '🇦🇫',
    ),
    
    // ماليزيا
    '60': PhoneRules(
      countryCode: '60',
      minLength: 9,
      maxLength: 10,
      allowedPrefixes: ['1', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19'],
      removeLeadingZero: true,
      countryName: 'Malaysia',
      isoCode: 'MY',
      flagEmoji: '🇲🇾',
    ),
    
    // إندونيسيا
    '62': PhoneRules(
      countryCode: '62',
      minLength: 9,
      maxLength: 12,
      allowedPrefixes: ['8', '81', '82', '83', '85', '87', '88', '89'],
      removeLeadingZero: true,
      countryName: 'Indonesia',
      isoCode: 'ID',
      flagEmoji: '🇮🇩',
    ),
    
    // الفلبين
    '63': PhoneRules(
      countryCode: '63',
      minLength: 10,
      maxLength: 10,
      allowedPrefixes: ['9', '90', '91', '92', '93', '94', '95', '96', '97', '98', '99'],
      removeLeadingZero: true,
      countryName: 'Philippines',
      isoCode: 'PH',
      flagEmoji: '🇵🇭',
    ),
    
    // فيتنام
    '84': PhoneRules(
      countryCode: '84',
      minLength: 9,
      maxLength: 10,
      allowedPrefixes: ['3', '5', '7', '8', '9', '32', '33', '34', '35', '36', '37', '38', '39', '52', '56', '58', '59', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79', '81', '82', '83', '84', '85', '86', '87', '88', '89', '90', '91', '92', '93', '94', '95', '96', '97', '98', '99'],
      removeLeadingZero: true,
      countryName: 'Vietnam',
      isoCode: 'VN',
      flagEmoji: '🇻🇳',
    ),
    
    // تايلاند
    '66': PhoneRules(
      countryCode: '66',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['6', '8', '9', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '80', '81', '82', '83', '84', '85', '86', '87', '88', '89', '90', '91', '92', '93', '94', '95', '96', '97', '98', '99'],
      removeLeadingZero: true,
      countryName: 'Thailand',
      isoCode: 'TH',
      flagEmoji: '🇹🇭',
    ),
    
    // الصين
    '86': PhoneRules(
      countryCode: '86',
      minLength: 11,
      maxLength: 11,
      allowedPrefixes: ['1', '13', '14', '15', '16', '17', '18', '19'],
      removeLeadingZero: true,
      countryName: 'China',
      isoCode: 'CN',
      flagEmoji: '🇨🇳',
    ),
    
    // اليابان
    '81': PhoneRules(
      countryCode: '81',
      minLength: 10,
      maxLength: 10,
      allowedPrefixes: ['7', '8', '9', '70', '80', '90'],
      removeLeadingZero: true,
      countryName: 'Japan',
      isoCode: 'JP',
      flagEmoji: '🇯🇵',
    ),
    
    // كوريا الجنوبية
    '82': PhoneRules(
      countryCode: '82',
      minLength: 10,
      maxLength: 10,
      allowedPrefixes: ['1', '10', '11'],
      removeLeadingZero: true,
      countryName: 'South Korea',
      isoCode: 'KR',
      flagEmoji: '🇰🇷',
    ),
    
    // ==================== أوروبا ====================
    
    // بريطانيا
    '44': PhoneRules(
      countryCode: '44',
      minLength: 10,
      maxLength: 10,
      allowedPrefixes: ['7', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79'],
      removeLeadingZero: true,
      countryName: 'United Kingdom',
      isoCode: 'GB',
      flagEmoji: '🇬🇧',
    ),
    
    // ألمانيا
    '49': PhoneRules(
      countryCode: '49',
      minLength: 10,
      maxLength: 11,
      allowedPrefixes: ['15', '16', '17', '151', '152', '155', '157', '159', '160', '162', '163', '170', '171', '172', '173', '174', '175', '176', '177', '178', '179'],
      removeLeadingZero: true,
      countryName: 'Germany',
      isoCode: 'DE',
      flagEmoji: '🇩🇪',
    ),
    
    // فرنسا
    '33': PhoneRules(
      countryCode: '33',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['6', '7', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79'],
      removeLeadingZero: true,
      countryName: 'France',
      isoCode: 'FR',
      flagEmoji: '🇫🇷',
    ),
    
    // إيطاليا
    '39': PhoneRules(
      countryCode: '39',
      minLength: 10,
      maxLength: 10,
      allowedPrefixes: ['3', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39'],
      removeLeadingZero: true,
      countryName: 'Italy',
      isoCode: 'IT',
      flagEmoji: '🇮🇹',
    ),
    
    // إسبانيا
    '34': PhoneRules(
      countryCode: '34',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['6', '7', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79'],
      removeLeadingZero: true,
      countryName: 'Spain',
      isoCode: 'ES',
      flagEmoji: '🇪🇸',
    ),
    
    // هولندا
    '31': PhoneRules(
      countryCode: '31',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['6', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69'],
      removeLeadingZero: true,
      countryName: 'Netherlands',
      isoCode: 'NL',
      flagEmoji: '🇳🇱',
    ),
    
    // بلجيكا
    '32': PhoneRules(
      countryCode: '32',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['4', '45', '46', '47', '48', '49'],
      removeLeadingZero: true,
      countryName: 'Belgium',
      isoCode: 'BE',
      flagEmoji: '🇧🇪',
    ),
    
    // سويسرا
    '41': PhoneRules(
      countryCode: '41',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['7', '74', '75', '76', '77', '78', '79'],
      removeLeadingZero: true,
      countryName: 'Switzerland',
      isoCode: 'CH',
      flagEmoji: '🇨🇭',
    ),
    
    // النمسا
    '43': PhoneRules(
      countryCode: '43',
      minLength: 10,
      maxLength: 11,
      allowedPrefixes: ['6', '64', '65', '66', '67', '68', '69'],
      removeLeadingZero: true,
      countryName: 'Austria',
      isoCode: 'AT',
      flagEmoji: '🇦🇹',
    ),
    
    // السويد
    '46': PhoneRules(
      countryCode: '46',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['7', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79'],
      removeLeadingZero: true,
      countryName: 'Sweden',
      isoCode: 'SE',
      flagEmoji: '🇸🇪',
    ),
    
    // النرويج
    '47': PhoneRules(
      countryCode: '47',
      minLength: 8,
      maxLength: 8,
      allowedPrefixes: ['4', '9', '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '90', '91', '92', '93', '94', '95', '96', '97', '98', '99'],
      removeLeadingZero: false,
      countryName: 'Norway',
      isoCode: 'NO',
      flagEmoji: '🇳🇴',
    ),
    
    // الدنمارك
    '45': PhoneRules(
      countryCode: '45',
      minLength: 8,
      maxLength: 8,
      allowedPrefixes: ['2', '3', '4', '5', '6', '7', '8', '9'],
      removeLeadingZero: false,
      countryName: 'Denmark',
      isoCode: 'DK',
      flagEmoji: '🇩🇰',
    ),
    
    // فنلندا
    '358': PhoneRules(
      countryCode: '358',
      minLength: 9,
      maxLength: 10,
      allowedPrefixes: ['4', '5', '40', '41', '44', '45', '46', '50', '51'],
      removeLeadingZero: true,
      countryName: 'Finland',
      isoCode: 'FI',
      flagEmoji: '🇫🇮',
    ),
    
    // بولندا
    '48': PhoneRules(
      countryCode: '48',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['5', '6', '7', '8', '50', '51', '53', '57', '60', '66', '69', '72', '73', '78', '79', '88'],
      removeLeadingZero: false,
      countryName: 'Poland',
      isoCode: 'PL',
      flagEmoji: '🇵🇱',
    ),
    
    // روسيا
    '7': PhoneRules(
      countryCode: '7',
      minLength: 10,
      maxLength: 10,
      allowedPrefixes: ['9', '90', '91', '92', '93', '94', '95', '96', '97', '98', '99'],
      removeLeadingZero: true,
      countryName: 'Russia',
      isoCode: 'RU',
      flagEmoji: '🇷🇺',
    ),
    
    // اليونان
    '30': PhoneRules(
      countryCode: '30',
      minLength: 10,
      maxLength: 10,
      allowedPrefixes: ['6', '69'],
      removeLeadingZero: true,
      countryName: 'Greece',
      isoCode: 'GR',
      flagEmoji: '🇬🇷',
    ),
    
    // البرتغال
    '351': PhoneRules(
      countryCode: '351',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['9', '91', '92', '93', '96'],
      removeLeadingZero: false,
      countryName: 'Portugal',
      isoCode: 'PT',
      flagEmoji: '🇵🇹',
    ),
    
    // جمهورية التشيك
    '420': PhoneRules(
      countryCode: '420',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['6', '7', '60', '61', '62', '63', '64', '65', '66', '67', '68', '69', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79'],
      removeLeadingZero: false,
      countryName: 'Czech Republic',
      isoCode: 'CZ',
      flagEmoji: '🇨🇿',
    ),
    
    // المجر
    '36': PhoneRules(
      countryCode: '36',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['20', '30', '31', '50', '70'],
      removeLeadingZero: true,
      countryName: 'Hungary',
      isoCode: 'HU',
      flagEmoji: '🇭🇺',
    ),
    
    // رومانيا
    '40': PhoneRules(
      countryCode: '40',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['7', '70', '71', '72', '73', '74', '75', '76', '77', '78', '79'],
      removeLeadingZero: true,
      countryName: 'Romania',
      isoCode: 'RO',
      flagEmoji: '🇷🇴',
    ),
    
    // ==================== أمريكا الشمالية ====================
    
    // الولايات المتحدة
    '1': PhoneRules(
      countryCode: '1',
      minLength: 10,
      maxLength: 10,
      allowedPrefixes: ['2', '3', '4', '5', '6', '7', '8', '9'],
      removeLeadingZero: false,
      countryName: 'United States',
      isoCode: 'US',
      flagEmoji: '🇺🇸',
    ),
    
    // كندا
    '1_ca': PhoneRules(  // نفس كود أمريكا
      countryCode: '1',
      minLength: 10,
      maxLength: 10,
      allowedPrefixes: ['2', '3', '4', '5', '6', '7', '8', '9'],
      removeLeadingZero: false,
      countryName: 'Canada',
      isoCode: 'CA',
      flagEmoji: '🇨🇦',
    ),
    
    // المكسيك
    '52': PhoneRules(
      countryCode: '52',
      minLength: 10,
      maxLength: 10,
      allowedPrefixes: ['1', '2', '3', '4', '5', '6', '7', '8', '9'],
      removeLeadingZero: false,
      countryName: 'Mexico',
      isoCode: 'MX',
      flagEmoji: '🇲🇽',
    ),
    
    // ==================== أمريكا الجنوبية ====================
    
    // البرازيل
    '55': PhoneRules(
      countryCode: '55',
      minLength: 11,
      maxLength: 11,
      allowedPrefixes: ['1', '9', '11', '12', '13', '14', '15', '16', '17', '18', '19'],
      removeLeadingZero: false,
      countryName: 'Brazil',
      isoCode: 'BR',
      flagEmoji: '🇧🇷',
    ),
    
    // الأرجنتين
    '54': PhoneRules(
      countryCode: '54',
      minLength: 10,
      maxLength: 10,
      allowedPrefixes: ['9', '11', '15', '22', '23', '24', '26', '34', '35', '38', '54'],
      removeLeadingZero: false,
      countryName: 'Argentina',
      isoCode: 'AR',
      flagEmoji: '🇦🇷',
    ),
    
    // كولومبيا
    '57': PhoneRules(
      countryCode: '57',
      minLength: 10,
      maxLength: 10,
      allowedPrefixes: ['3', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39'],
      removeLeadingZero: false,
      countryName: 'Colombia',
      isoCode: 'CO',
      flagEmoji: '🇨🇴',
    ),
    
    // تشيلي
    '56': PhoneRules(
      countryCode: '56',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['9', '22', '23', '32', '33', '34', '35', '41', '42', '43', '44', '45', '51', '52', '53', '55', '56', '57', '58', '61', '62', '63', '64', '65', '67', '71', '72', '73', '75', '76', '82', '83', '85', '87', '88', '91', '92', '93', '94', '95', '96', '97', '98', '99'],
      removeLeadingZero: false,
      countryName: 'Chile',
      isoCode: 'CL',
      flagEmoji: '🇨🇱',
    ),
    
    // ==================== أوقيانوسيا ====================
    
    // أستراليا
    '61': PhoneRules(
      countryCode: '61',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['4', '40', '41', '42', '43', '44', '45', '46', '47', '48', '49'],
      removeLeadingZero: true,
      countryName: 'Australia',
      isoCode: 'AU',
      flagEmoji: '🇦🇺',
    ),
    
    // نيوزيلندا
    '64': PhoneRules(
      countryCode: '64',
      minLength: 9,
      maxLength: 9,
      allowedPrefixes: ['2', '20', '21', '22', '27', '29'],
      removeLeadingZero: true,
      countryName: 'New Zealand',
      isoCode: 'NZ',
      flagEmoji: '🇳🇿',
    ),
  };

  static PhoneRules? getRules(String countryCode) {
    // لكندا نفس كود أمريكا
    if (countryCode == '1') {
      return rules['1'];
    }
    return rules[countryCode];
  }

  static bool isValidNumber(String countryCode, String nationalNumber) {
    final rule = getRules(countryCode);
    if (rule == null) return true;
    
    final length = nationalNumber.length;
    if (length < rule.minLength || length > rule.maxLength) return false;
    
    // التحقق من بداية الرقم
    for (final prefix in rule.allowedPrefixes) {
      if (nationalNumber.startsWith(prefix)) {
        return true;
      }
    }
    
    return false;
  }
  
  static String? getErrorMessage(String countryCode, String nationalNumber) {
    final rule = getRules(countryCode);
    if (rule == null) return null;
    
    final length = nationalNumber.length;
    if (length < rule.minLength) {
      return '${rule.countryName} phone number must be at least ${rule.minLength} digits';
    }
    if (length > rule.maxLength) {
      return '${rule.countryName} phone number must not exceed ${rule.maxLength} digits';
    }
    
    return 'Invalid ${rule.countryName} phone number format';
  }
}