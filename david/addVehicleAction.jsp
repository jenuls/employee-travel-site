<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.sql.ResultSet" %>
<%@ page language="java" import="connect.ConnectToMySql" %>
<%@ page language="java" import="java.net.URLEncoder"%>
<%@ page language="java" import="java.text.*" %>

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
  String inputList = request.getParameter("inputList").toString();

  SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
  Date date = new Date();
  String strDate = sdFormat.format(date);
  
  if(!inputList.equals("")){
  	String[] arr = inputList.split(";");
  	String SqlStr1="insert into vehicle values ";
  	String SqlStr2="insert into vehiclemember values ";
  	//預設為40人一輛，可修改人數，修改vehicleType變數即可以。
  	int vehicleType = 40;
  	String temp="";
  	for(int i=0;i<arr.length;i++){
  		if(i==0){
  			SqlStr1 = SqlStr1 + "('" + arr[i] + "','" + travelNo + "')";
  			for(int t=1;t<=vehicleType;t++){
  				if(t<10){
  					temp = "0" + String.valueOf(t);
  				}else{
  					temp = String.valueOf(t);
  				}
  				if(t==1){
  					SqlStr2 = SqlStr2 + "('" + travelNo + "','" + arr[i] + "','" + temp + "','NA','NA','0','N','" + strDate + "')";
  				}else{
  					SqlStr2 = SqlStr2 + ",('" + travelNo + "','" + arr[i] + "','" + temp + "','NA','NA','0','N','" + strDate + "')";
  				}  		
  			}
  		}else{
  			SqlStr1 = SqlStr1 + ",('" + arr[i] + "','" + travelNo + "')";
  			for(int t=1;t<=vehicleType;t++){
  				if(t<10){
  					temp = "0" + String.valueOf(t);
  				}else{
  					temp = String.valueOf(t);
  				}
  				SqlStr2 = SqlStr2 + ",('" + travelNo + "','" + arr[i] + "','" + temp + "','NA','NA','0','N','" + strDate + "')";
  			}
  		}
  	}

  	ConnectToMySql connObj = new ConnectToMySql(); 
  	connObj.insert(SqlStr1);
  	connObj.insert(SqlStr2);
	}else{
	
	}
  response.sendRedirect("adminSetSettingList.jsp?travelNo=" + travelNo + "&travelName=" + URLEncoder.encode(travelName,"UTF-8"));
%>
</body>
</html>