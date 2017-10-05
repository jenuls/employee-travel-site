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
  String two = request.getParameter("two");
  String three = request.getParameter("three");
  String four = request.getParameter("four");
  
  ConnectToMySql connObj = new ConnectToMySql(); 
 	connObj.update("update roomfeedata set two='" + two + "',three='" + three + "',four='" + four + "' where travelNo='" + travelNo + "'");
  response.sendRedirect("adminTravelList.jsp?travelNo=" + travelNo + "&travelName=" + URLEncoder.encode(travelName,"UTF-8"));
%>
</body>
</html>