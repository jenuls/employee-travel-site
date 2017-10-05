<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.sql.ResultSet" %>
<%@ page language="java" import="connect.ConnectToMySql" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
<%
  String empNo = session.getAttribute("empNo").toString();
  String empCName = session.getAttribute("empCName").toString();
  String travelNo = request.getParameter("travelNo").toString();

	ConnectToMySql connObj = new ConnectToMySql(); 
  
  ArrayList<String> al01 = new ArrayList<String>();
  al01 = connObj.select("select COUNT(employeeNo) from registration where employeeNo='" + empNo + "'");
  
  ArrayList<String> al02 = new ArrayList<String>();
  al02 = connObj.select("select COUNT(employeeNumber) from roommember where employeeNumber ='" + empNo + "'");

  int temp01 = Integer.parseInt(al01.get(0));
  int temp02 = Integer.parseInt(al02.get(0));
  String temp="";
  
  if(temp01 == 0){
  	temp = "0";
	}else if(temp01 < temp02){
  	temp = "1";
  }else if(temp01 == temp02){
  	temp = "2";
  }else if(temp01 > temp02){
  	temp = "3";
  }

  out.write("<context>");
  out.write(temp);
  out.write("</context>");  
%>
</body>
</html>