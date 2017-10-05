<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="BIG5"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.sql.ResultSet" %>
<%@ page language="java" import="connect.ConnectToMySql" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Insert title here</title>
</head>
<body>
<%
  //String formName = request.getParameter("formName");
  String travelNo = request.getParameter("travelNo");
  String travelName = new String(request.getParameter("travelName").getBytes("ISO-8859-1"),"UTF-8");
  String datepicker01 = request.getParameter("datepicker01");
  String datepicker02 = request.getParameter("datepicker02");
  String datepicker03 = request.getParameter("datepicker03");
  String datepicker04 = request.getParameter("datepicker04");
  String travelQuantity = request.getParameter("travelQuantity");
  String selfPay = request.getParameter("selfPay");
  String room4Cost = request.getParameter("room4Cost");
  String room3Cost = request.getParameter("room3Cost");
  String room2Cost = request.getParameter("room2Cost");
  String room4Num = request.getParameter("room4Num");
  String room3Num = request.getParameter("room3Num");
  String room2Num = request.getParameter("room2Num");
  String vehicleNum = request.getParameter("vehicleNum");
  String tableNum = request.getParameter("tableNum");
  String travelDesc = request.getParameter("travelDesc");

  ConnectToMySql connObj = new ConnectToMySql();  
 	connObj.update("update travel set travelName ='" + travelName + "', travelDateStart = '" + datepicker01 + "', travelDateEnd = '" + datepicker02 + "', registerDateStart = '" + datepicker03 + "', registerDateEnd = '" + datepicker04 + "', travelDesc = '" + travelDesc + "', travelQuantity = '" + travelQuantity + "', selfPay = '" + selfPay + "', room4Cost = '" + room4Cost + "', room3Cost = '" + room3Cost + "', room2Cost = '" + room2Cost + "', room4Num = '" + room4Num + "', room3Num = '" + room3Num + "', room2Num = '" + room2Num + "', tableNum = '" + tableNum + "', vehicleNum = '" + vehicleNum + "' WHERE travelNo = '" + travelNo + "'");
	response.sendRedirect("adminTravelList.jsp");
%>
</body>
</html>