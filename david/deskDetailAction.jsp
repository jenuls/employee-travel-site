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
	String returnValue = new String(request.getParameter("returnValue").getBytes("ISO-8859-1"),"UTF-8");
	String travelName = new String(request.getParameter("travelName").getBytes("ISO-8859-1"),"UTF-8");
	String returnLuckValue = request.getParameter("returnLuckValue");
	String travelNo = request.getParameter("travelNo");
	String deskNo = request.getParameter("deskNo");
	String empNo = session.getAttribute("empNo").toString();
	String flag = request.getParameter("flag").toString();	
	ConnectToMySql connObj = new ConnectToMySql();
	String [] arr1 = returnValue.split(";");
	String sql = "update deskmember set ";
	String temp="";
	
  	SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	Date date = new Date();
	String strDate = sdFormat.format(date);

	for(int i=0;i<arr1.length;i++){
		if(i<9){
			temp = "0" + String.valueOf(i+1);
		}else{
			temp = String.valueOf(i+1);
		}
		if(arr1[i].equals("NA")){
			connObj.update("update deskmember set employeeNumber='NA',MemberName='NA',isTempFlag='N',writeDate='" + strDate + "' where travelNo='" + travelNo + "' and deskNo='" + deskNo + "' and deskDetailNo='" + temp + "'");
		}else if(!arr1[i].equals("N")){
			connObj.update("update deskmember set employeeNumber='" + empNo + "',MemberName='" + arr1[i] + "',isTempFlag='Y',writeDate='" + strDate + "' where travelNo='" + travelNo + "' and deskNo='" + deskNo + "' and deskDetailNo='" + temp + "'"); 	
		}
	}

 	temp="";
	
	String [] arr2 = returnLuckValue.split(";"); 
	for(int i=0;i<arr2.length;i++){
		if(arr2[i].equals("Y")){
			if(i<9){
				temp = "0" + String.valueOf(i+1);
			}else{
				temp = String.valueOf(i+1);
			}
			connObj.update("update deskmember set isSelect = '0' where travelNo='" + travelNo + "' and deskNo='" + deskNo + "' and deskDetailNo='" + temp + "'");
		}  	
	}
	if(flag.equals("0")){
		response.sendRedirect("selectDesk.jsp?flag=0&travelNo=" + travelNo + "&travelName=" + URLEncoder.encode(travelName,"UTF-8"));
	}else{
		response.sendRedirect("selectDesk.jsp?flag=1&travelNo=" + travelNo + "&travelName=" + URLEncoder.encode(travelName,"UTF-8"));
	}
%>
</body>
</html>