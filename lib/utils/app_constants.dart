
import '../data/model/language_model.dart';
import 'images.dart';

class AppConstants {
  static const String APP_NAME = 'Tracking';
  static const String APP_VERSION = "1.0.0";

  // API paths
  static const String BASE_URL = 'http://timesheet-dev.oceantech.com.vn';
  static const String CATEGORY_URI = '/api/v1/categories';
  static const String BANNER_URI = '/api/v1/banners';
  static const String STORE_ITEM_URI = '/api/v1/items/latest';
  static const String POPULAR_ITEM_URI = '/api/v1/items/popular';
  static const String REVIEWED_ITEM_URI = '/api/v1/items/most-reviewed';
  static const String SEARCH_ITEM_URI = '/api/v1/items/details/';
  static const String SUB_CATEGORY_URI = '/api/v1/categories/childes/';
  static const String CATEGORY_ITEM_URI = '/api/v1/categories/items/';
  static const String CATEGORY_STORE_URI = '/api/v1/categories/stores/';
  static const String CONFIG_URI = '/mita/public/config-app';
  static const String LOGIN_URI = '/timesheet/oauth/token';
  static const String TRACKING = '/timesheet/api/v1/reports/page';
  static const String MEMBER = '/timesheet/api/v1/members/page';
  static const String TEAM = '/timesheet/api/v1/teams/page';
  static const String PROJECT = '/timesheet/api/v1/projects/page';
  static const String USER = '/timesheet/api/v1/users/page';
  static const String SIGN_UP = '/mita/public/sign';
  static const String LOG_OUT = '/mita/oauth/logout';
  static const String GET_USER = '/mita/users/get-user-current';
  static const String CHECK_TOKEN = '/timesheet/oauth/check_token';
  static const String GET_ALLOCATION_VOUCHERS = '/asvn/api/v1/instruments-and-tools/allocation-vouchers/page?pageIndex=1&pageSize=10';

  // Shared Key
  static const String THEME = '6ammart_theme';
  static const String TOKEN = 'access_token';
  static const String COUNTRY_CODE = '6ammart_country_code';
  static const String LANGUAGE_CODE = '6ammart_language_code';
  static const String CART_LIST = '6ammart_cart_list';
  static const String USER_PASSWORD = '6ammart_user_password';
  static const String USER_ADDRESS = '6ammart_user_address';
  static const String USER_NUMBER = '6ammart_user_number';
  static const String USER_COUNTRY_CODE = '6ammart_user_country_code';
  static const String NOTIFICATION = '6ammart_notification';
  static const String SEARCH_HISTORY = '6ammart_search_history';
  static const String INTRO = '6ammart_intro';
  static const String NOTIFICATION_COUNT = '6ammart_notification_count';

  static const String TOPIC = 'all_zone_customer';
  static const String ZONE_ID = 'zoneId';
  static const String MODULE_ID = 'moduleId';
  static const String LOCALIZATION_KEY = 'X-localization';


  // Shared Key
  static const String CUSTOMER_COUNTRY_CODE =
      'customer_country_code'; //not in project
  static const String SEARCH_ADDRESS = 'search_address';
  static const String CONFIG = 'config';
  static const String CUSTOMER_NAME = 'customer_name';
  static const String CUSTOMER_NUMBER = 'customer_number';
  static const String CUSTOMER_QR_CODE = 'customer_qr_code';
  static const String SEND_MONEY_SUGGEST_LIST = 'send_money_suggest';
  static const String REQUEST_MONEY_SUGGEST_LIST = 'request_money_suggest';
  static const String RECENT_AGENT_LIST = 'recent_agent_list';

  static const String PENDING = 'pending';
  static const String APPROVED = 'approved';
  static const String DENIED = 'denied';
  static const String CASH_IN = 'cash_in';
  static const String CASH_OUT = 'cash_out';
  static const String SEND_MONEY = 'send_money';
  static const String RECEIVED_MONEY = 'received_money';
  static const String ADMIN_CHARGE = 'admin_charge';
  static const String ADD_MONEY = 'add_money';

  static const int BALANCE_INPUT_LEN = 10;

  //Dropdown buttons options
  static const List<int> pageSizes = [10, 20, 30, 50];
  static const List<String> projectStatusOptions = ['WORKING', 'PENDING', 'FINISH'];
  static const List<String> positionList = ['DEV FE', 'DEV BE', 'DEV FULLSTACK', 'TESTER'];
  static const List<String> genderList = ['MALE', 'FEMALE', 'LGBT', 'OTHER'];
  static const List<String> typeList = ['LEADER', 'DEPUTY LEADER', 'MEMBER'];
  static const List<String> statusList = ['STAFF', 'INTERNSHIP'];
  static const List<String> skillList = ['LEADER', 'L0', 'L1', 'L2', 'L3', 'L4'];

  // Delivery Tips
  static List<int> tips = [5000, 10000, 20000, 50000];
  static List<String> tipsTitle = ['5.000', '10.000', '20.000', '50.000'];

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.vietnam,
        languageName: 'Việt Nam',
        countryCode: 'VN',
        languageCode: 'vi'),
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
  ];
}
