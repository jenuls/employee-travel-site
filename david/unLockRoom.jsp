<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.sql.ResultSet" %>
<%@ page language="java" import="connect.ConnectToMySql" %>
<%@ page language="java" import="java.net.URLEncoder"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
  String travelName = new String(request.getParameter("travelName").getBytes("ISO-8859-1"),"UTF-8");
  String travelNo = request.getParameter("travelNo");
  String temp = request.getParameter("temp");
  ConnectToMySql connObj = new ConnectToMySql();
  String [] arr1 = temp.split(";");

  for(int i=0;i<arr1.length;i++){
  	connObj.update("update room set isSelect='0' where travelNo='" + travelNo + "' and roomNo='" + arr1[i] + "'");
  }
  
	response.sendRedirect("adminSetSettingList.jsp?flag=1&travelNo=" + travelNo + "&travelName=" + URLEncoder.encode(travelName,"UTF-8"));
%>
</body>
</html>