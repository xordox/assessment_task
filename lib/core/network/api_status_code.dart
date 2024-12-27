abstract class ApiStatusCode {
  // Success
  static const int status200 = 200;

  // No content
  static const int status204 = 204;

  // Bad Request
  static const int status400 = 400;

  // 401 Unauthorized
  static const int status401 = 401;

  // 403 Other user logged in
  static const int status403 = 403;

  // 404 Not found
  static const int status404 = 404;

  // The request could not be processed because of conflict in the request,
  static const int status409 = 409;

  // 503 Represent the Maintenance Mode
  static const int status503 = 503;

  // 498 Represent auth token expire
  static const int status498 = 498;
}
