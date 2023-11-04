class Api {
  static const hostUrl = "http://localhost";
  static const hostConnect = "$hostUrl/swizzle";
  static const hostConnectUser = "$hostConnect/user";
  static const hostConnectAdmin = "$hostConnect/admin";

  //signup

  static const signUp = "$hostConnectUser/signup.php";
  static const validateEmail = "$hostConnectUser/validate_email.php";

  //Login

  static const login = "$hostConnectUser/login.php";

  //Admin

  static const adminUpload = "$hostConnectAdmin/upload.php";

  //items

  static const flashSaleItems = "$hostConnectUser/flash_sale.php";
  static const latestItems = "$hostConnectUser/latest_products.php";

  //slider

  static const sliderImages = "$hostConnectAdmin/slider.php";

  //cart
  static const addToCart = "$hostConnectUser/addToCart.php";
  static const readUserCart = "$hostConnectUser/readUserCart.php";
  static const updateQuantity = "$hostConnectUser/updateQuantity.php";
  static const checkIfItemInCart = "$hostConnectUser/checkIfItemInCart.php";
  static const removeSingleCart = "$hostConnectUser/removeSingleCart.php";
  static const reduceCartQuantity = "$hostConnectUser/reduceCartQuantity.php";

  //wishlist

  static const addToFavourite = "$hostConnectUser/favourite/add.php";
  static const validateFavourite = "$hostConnectUser/favourite/validate.php";
  static const removeFavourite = "$hostConnectUser/favourite/remove.php";
  static const itemSearch = "$hostConnectUser/search.php";
  static const readUserFavourite =
      "$hostConnectUser/favourite/readUserFavourite.php";
}
