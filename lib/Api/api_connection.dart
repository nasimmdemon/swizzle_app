class Api {
  static const hostUrl = "http://localhost";
  static const hostConnect = "$hostUrl/swizzle";
  static const hostConnectUser = "$hostConnect/user";
  static const hostConnectAdmin = "$hostConnect/admin";

  //App version if availible or not
  static const appStatus = "$hostConnectUser/app_status.php";

  //signup

  static const signUp = "$hostConnectUser/signup.php";
  static const validateEmail = "$hostConnectUser/validate_email.php";

  //Login

  static const login = "$hostConnectUser/login.php";

  //Admin

  static const adminUpload = "$hostConnectAdmin/upload.php";
  static const statistics = "$hostConnectAdmin/statistics/";
  static const totalCustomers =
      "$hostConnectAdmin/statistics/total_customers.php";
  static const totalOrders = "$hostConnectAdmin/statistics/total_orders.php";
  static const totalAmounts = "$hostConnectAdmin/statistics/total_revinew.php";

  //items

  static const flashSaleItems = "$hostConnectUser/flash_sale.php";
  static const latestItems = "$hostConnectUser/latest_products.php";
  static const variableItem = "$hostConnectUser/variableItem.php";

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
  //Shipping
  static const readUserInfo = "$hostConnectUser/readUserInfo.php";
  static const addUserInfo = "$hostConnectUser/addUserInfo.php";

  // Order

  static const addOrderInfo = "$hostConnectUser/order/add.php";
  static const readOrderInfo = "$hostConnectUser/order/get.php";
  static const readCompletedOrderInfo =
      "$hostConnectUser/order/get_completed.php";
  static const cancelOrder = "$hostConnectUser/order/cancel.php";

  //coupon
  static const couponCodes = "$hostConnectUser/coupon.php";
}
