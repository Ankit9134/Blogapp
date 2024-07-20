const String ICONS_PATH = 'assets/icons';
const String IMAGE_PATH = 'assets/images';
const String JSON_PATH = 'assets/json';

sealed class AssetsManager{

  static const String menu = "$ICONS_PATH/menu-icon.png";
  static const String home = "$ICONS_PATH/home-icon.png";
  static const String bookmark_black = "$ICONS_PATH/bookmark-black-icon.png";
  static const String bookmark_white = "$ICONS_PATH/bookmark-white-icon.png";
  static const String notification = "$ICONS_PATH/notification-icon.png";

  static const String image = "$IMAGE_PATH/image.jpg";
  static const String defaultAccount = "$IMAGE_PATH/default_account.png";
  static const String withoutImage = "$IMAGE_PATH/without_image.png";

}

sealed class JsonManager{

  static const String writting = "$JSON_PATH/writting.json";
  static const String excluir = "$JSON_PATH/excluir.json";

}
