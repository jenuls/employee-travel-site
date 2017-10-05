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
  String returnValue01 = new String(request.getParameter("returnValue01").getBytes("ISO-8859-1"),"UTF-8");
  String returnValue02 = new String(request.getParameter("returnValue02").getBytes("ISO-8859-1"),"UTF-8");
  String travelName = new String(request.getParameter("travelName").getBytes("ISO-8859-1"),"UTF-8");
  String returnLuckValue = request.getParameter("returnLuckValue");
  String travelNo = request.getParameter("travelNo");
  String deskNo = request.getParameter("deskNo");
  String empNo = session.getAttribute("empNo").toString();
  ConnectToMySql connObj = new ConnectToMySql();
  String [] arr01 = returnValue01.split(";");
  String [] arr02 = returnValue02.split(";");
  String sql = "update deskmember set ";
	String temp="";
  for(int i=0;i<arr01.length;i++){
  	if(i<9){
  		temp = "0" + String.valueOf(i+1);
  	}else{
  		temp = String.valueOf(i+1);
  	}
  		
  	if(arr01[i].equals("NA")){
  		connObj.update("update deskmember set employeeNumber='NA',MemberName='NA' where travelNo='" + travelNo + "' and deskNo='" + deskNo + "' and deskDetailNo='" + temp + "'");
  	}else if(!arr01[i].equals("N")){
  		connObj.update("update deskmember set employeeNumber='" + arr01[i] + "',MemberName='" + arr02[i] + "' where travelNo='" + travelNo + "' and deskNo='" + deskNo + "' and deskDetailNo='" + temp + "'"); 	
  	}
  }
 
 	temp="";
	String [] arr03 = returnLuckValue.split(";"); 
  for(int i=0;i<arr03.length;i++){
  	if(arr03[i].equals("Y")){
  	  if(i<9){
  			temp = "0" + String.valueOf(i+1);
  		}else{
  			temp = String.valueOf(i+1);
  		}
  		connObj.update("update deskmember set isSelect = '0' where travelNo='" + travelNo + "' and deskNo='" + deskNo + "' and deskDetailNo='" + temp + "'");
  	}  	
  }
	response.sendRedirect("adminSetSettingList.jsp?travelNo=" + travelNo + "&travelName=" + URLEncoder.encode(travelName,"UTF-8"));
%>
</body>
</html>