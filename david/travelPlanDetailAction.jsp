<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.sql.ResultSet" %>
<%@ page language="java" import="connect.ConnectToMySql" %>
<%@ page language="java" import="java.text.*" %>
<%@ page language="java" import="myutil.DateUtil" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
  ConnectToMySql connObj = new ConnectToMySql();
  String empNo = session.getAttribute("empNo").toString();
  String empCName = session.getAttribute("empCName").toString();
  //String age = request.getParameter("age").toString();
  String travelNo = request.getParameter("travelNo").toString();
  
   connObj.update("update registration set money='" + String.valueOf(money) + "',isTempFlag='N' where travelNo='" + travelNo + "' and employeeNo ='" + empNo + "' and name='" + empCName + "'");
	connObj.update("update registration set isTempFlag='N' where travelNo='" + travelNo + "' and employeeNo ='" + empNo + "'");
	
	connObj.update("update roommember set isTempFlag='N' where travelNo='" + travelNo + "' and employeeNumber='" + empNo + "'");
	connObj.update("update deskmember set isTempFlag='N' where travelNo='" + travelNo + "' and employeeNumber='" + empNo + "'");
	connObj.update("update vehiclemember set isTempFlag='N' where travelNo='" + travelNo + "' and employeeNumber='" + empNo + "'");
	
	response.sendRedirect("registerSuccessAlert.jsp");
%>
</body>
</html>