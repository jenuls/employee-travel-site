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
  String deskNo = request.getParameter("deskNo");
  ConnectToMySql connObj = new ConnectToMySql();
  
  

  String [] arr1 = temp.split(";");

	String temp01 = "";
  for(int i=0;i<arr1.length;i++){
  	if(Integer.parseInt(arr1[i])<10){
  		temp01 = "0" + arr1[i];
  	}else{
  		temp01 = arr1[i];
  	}
  	
  	connObj.update("update deskmember set isSelect='0' where travelNo='" + travelNo + "' and deskNo='" + deskNo + "' and deskDetailNo='" + temp01 + "'");
  }
	response.sendRedirect("adminDeskDetail.jsp?travelNo=" + travelNo + "&travelName=" + URLEncoder.encode(travelName,"UTF-8") + "&deskNo=" + deskNo);
%>
</body>
</html>