<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.sql.ResultSet" %>
<%@ page language="java" import="connect.ConnectToMySql" %>
<%@ page language="java" import="java.text.*" %>

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
	String selectPeople = new String(request.getParameter("selectPeople").getBytes("ISO-8859-1"),"UTF-8");
  
    SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	Date date = new Date();
	String strDate = sdFormat.format(date);
  
	if(!selectPeople.equals("")){
		String[] arr = selectPeople.split(";");
		ConnectToMySql connObj = new ConnectToMySql();
 		String sqlStr = "insert into registration values ";
		for(int i=0;i<arr.length;i++){
			if(i==0){
				sqlStr = sqlStr + "('" + travelNo + "','" + empNo + "','" + arr[i] + "','0','0','Y','" + strDate + "')";
			}else{
				sqlStr = sqlStr + ",('" + travelNo + "','" + empNo + "','" + arr[i] + "','0','0','Y','" + strDate + "')";
			} 	
		}
  	
		connObj.delete("delete from registration where employeeNo='" + empNo + "'");
		connObj.update("update roommember set employeeNumber='NA',memberName='NA' where employeeNumber='" + empNo + "'");
		connObj.update("update deskmember set employeeNumber='NA',memberName='NA',isSelect='0' where employeeNumber='" + empNo + "'");
		connObj.update("update vehiclemember set employeeNumber='NA',memberName='NA',isSelect='0' where employeeNumber='" + empNo + "'");
		connObj.insert(sqlStr);  
  }
%>
</body>
</html>