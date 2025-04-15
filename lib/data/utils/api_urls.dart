class ApiUrls {
  static final String _baseUrls = "http://35.73.30.144:2005/api/v1";
  static final String userRegistation = "$_baseUrls/Registration";
  static final String userLogin = "$_baseUrls/Login";
  static final String userUpdateProfile = "$_baseUrls/ProfileUpdate";
  static final String userProfileDetails = "$_baseUrls/ProfileDetails";
  static final String createTaskUrl = "$_baseUrls/createTask";
  static final String taskStatusCountUrl = "$_baseUrls/taskStatusCount";
  static final String newTaskListUrl = "$_baseUrls/listTaskByStatus/New";
  static final String progressTaskListUrl =
      "$_baseUrls/listTaskByStatus/Progress";
  static final String complatedTaskListUrl =
      "$_baseUrls/listTaskByStatus/Complated";
}
