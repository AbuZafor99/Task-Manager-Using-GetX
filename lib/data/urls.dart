class Urls{
  static const String _baseUrl="http://35.73.30.144:2005/api/v1";

  static const String registrationUrl="$_baseUrl/Registration";
  static const String loginUrl="$_baseUrl/Login";
  static const String createNewTaskUrl="$_baseUrl/createTask";
  static const String getNewTasksUrl="$_baseUrl/listTaskByStatus/New";
  static const String getProgressTasksUrl="$_baseUrl/listTaskByStatus/Progress";
  static const String getCompletedTasksUrl="$_baseUrl/listTaskByStatus/Completed";
  static const String getCancelledTasksUrl="$_baseUrl/listTaskByStatus/Cancelled";
  static const String taskStatusCountUrls="$_baseUrl/taskStatusCount";
}