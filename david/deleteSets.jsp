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
  ConnectToMySql connObj = new ConnectToMySql();
  String travelNo = request.getParameter("travelNo").toString();
  String travelName = request.getParameter("travelName").toString();
  String roomContext = request.getParameter("roomContext").toString();
  String deskContext = request.getParameter("deskContext").toString();
  String vehicleContext = request.getParameter("vehicleContext").toString();


	if(roomContext!=""){
		String Sql01 = "delete from room where travelNo='" + travelNo + "' and roomNo in (";
    String[] arr01 = roomContext.split(";");
    for(int i=0;i<arr01.length;i++){
    	if(i==0){
    		Sql01 = Sql01 + "'" + arr01[i] + "'";
    	}else{
				Sql01 = Sql01 + ",'" + arr01[i] + "'";    		
    	}
			connObj.update("delete from roommember where travelNo='" + travelNo + "' and roomNo='" + arr01[i] + "'");
    }
    Sql01 = Sql01 + ")";
  	connObj.delete(Sql01);
	}
	
	
	if(deskContext!=""){
		String Sql02 = "delete from desk where travelNo='" + travelNo + "' and deskNo in (";	
    String[] arr02 = deskContext.split(";");
    for(int i=0;i<arr02.length;i++){
    	if(i==0){
    		Sql02 = Sql02 + "'" + arr02[i] + "'";
    	}else{
				Sql02 = Sql02 + ",'" + arr02[i] + "'";    		
    	}
			connObj.update("delete from deskmember where travelNo='" + travelNo + "' and deskNo='" + arr02[i] + "'");
    }
    Sql02 = Sql02 + ")";
  	connObj.delete(Sql02);
	}
	

	if(vehicleContext!=""){
		String Sql03 = "delete from vehicle where travelNo='" + travelNo + "' and vehicleNo in (";
    String[] arr03 = vehicleContext.split(";");
    for(int i=0;i<arr03.length;i++){
    	if(i==0){
    		Sql03 = Sql03 + "'" + arr03[i] + "'";
    	}else{
				Sql03 = Sql03 + ",'" + arr03[i] + "'";    		
    	}
			connObj.update("delete from vehiclemember where travelNo='" + travelNo + "' and vehicleNo='" + arr03[i] + "'");
    }
    Sql03 = Sql03 + ")";
  	connObj.delete(Sql03);
	}
	response.sendRedirect("adminSetSettingList.jsp?travelNo=" + travelNo + "&travelName=" + travelName);
%>
</body>
</html>