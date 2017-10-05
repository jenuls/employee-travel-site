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
  String datepicker1 = request.getParameter("datepicker1");
  String datepicker2 = request.getParameter("datepicker2");
  String isRegister = request.getParameter("isRegister");
  String deleteRegister = request.getParameter("deleteRegister"); 

  ConnectToMySql connObj = new ConnectToMySql(); 
  connObj.update("update travel set displayStartDate = '" + datepicker1 + "',displayEndDate='" + datepicker2 + "',isRegister='" + isRegister + "' where travelNo='" + travelNo + "'");
	if(deleteRegister.equals("1")){
		connObj.delete("delete from registration where travelNo='" + travelNo + "'");
		connObj.update("update room set isSelect = '0' where travelNo='" + travelNo + "'");
		connObj.update("update roommember set employeeNumber='NA', MemberName='NA' where travelNo='" + travelNo + "'");
		connObj.update("update deskmember set employeeNumber='NA', MemberName='NA',isSelect='0' where travelNo='" + travelNo + "'");
		connObj.update("update vehiclemember set employeeNumber='NA', MemberName='NA',isSelect='0' where travelNo='" + travelNo + "'");
		/*isSelect 
		connObj.delete("delete from registration where travelNo='" + travelNo + "'");
		connObj.delete("delete from room where travelNo='" + travelNo + "'");
		connObj.delete("delete from roommember where travelNo='" + travelNo + "'");
		connObj.delete("delete from desk where travelNo='" + travelNo + "'");
		connObj.delete("delete from deskmember where travelNo='" + travelNo + "'");
		connObj.delete("delete from vehicle where travelNo='" + travelNo + "'");
		connObj.delete("delete from vehiclemember where travelNo='" + travelNo + "'");
		*/
	}

  response.sendRedirect("adminTravelList.jsp?travelNo=" + travelNo + "&travelName=" + URLEncoder.encode(travelName,"UTF-8"));
%>
</body>
</html>