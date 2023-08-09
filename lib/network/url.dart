class urls{
  urls._();
  static const String _baseurls = 'https://task.teamrabbil.com/api/v1';
  static String registrarion = '$_baseurls/registration';
  static String login = '$_baseurls/login';
  static String addnewtask = '$_baseurls/createTask';
  static String taskstatus = '$_baseurls/taskStatusCount';
  static String newadttask = '$_baseurls/listTaskByStatus/New';
  static String compleatedtask = '$_baseurls/listTaskByStatus/Completed';
  static String progesstask = '$_baseurls/listTaskByStatus/Progress';
  static String cancledtask = '$_baseurls/listTaskByStatus/Cancel';
  static String deletetask(String id) => '$_baseurls/deleteTask/$id';
  static String updatetask(String id,String status) => '$_baseurls/updateTaskStatus/$id/$status';
  static String profileupdate = '$_baseurls/profileUpdate';
}