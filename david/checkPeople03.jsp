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
  String travelNo = request.getParameter("travelNo").toString();
  String empNo = request.getParameter("empNo").toString();
  String travelName = new String(request.getParameter("travelName").getBytes("ISO-8859-1"),"UTF-8");
  String nameTemp = new String(request.getParameter("nameTemp").getBytes("ISO-8859-1"),"UTF-8");

	ConnectToMySql connObj = new ConnectToMySql();
  
  ArrayList<String> al01 = new ArrayList<String>();
  al01 = connObj.select("select COUNT(employeeNo) from personaldata where employeeNo='" + empNo + "'");

  ArrayList<String> al02 = new ArrayList<String>();
  al02 = connObj.select("select COUNT(employeeNo) from personaldata where employeeNo='" + empNo + "' and name='" + nameTemp + "'");
  
  ArrayList<String> al03 = new ArrayList<String>();
  al03 = connObj.select("select COUNT(employeeNumber) from relativesdata where employeeNumber ='" + empNo + "' and name='" + nameTemp + "'");

  int temp01 = Integer.parseInt(al01.get(0));
  int temp02 = Integer.parseInt(al02.get(0));
  int temp03 = Integer.parseInt(al03.get(0));
  String temp="";
  
  if(temp01 == 0){
  	temp = "0";
	}else{
		if(temp02 == 0){
			if(temp03 == 0){
				temp = "1";
			}else{
				temp = "2";
			}
		}else{
			temp = "2";
		}
	}
	
  out.write("<context>");
  out.write(temp);
  out.write("</context>"); 
%>
</body>
</html>