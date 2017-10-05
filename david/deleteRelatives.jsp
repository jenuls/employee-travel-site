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
 	String empNo = session.getAttribute("empNo").toString();
 	String tempDeleteList = request.getParameter("tempDeleteList").toString();
 	String[] arr = tempDeleteList.split(";");

	if(tempDeleteList!=""){
		String Sql = "delete from relativesdata where employeeNumber='" + empNo + "' and idNumber in (";
    for(int i=0;i<arr.length;i++){
    	if(i==0){
    		Sql = Sql + "'" + arr[i] + "'";
    	}else{
				Sql = Sql + ",'" + arr[i] + "'";    		
    	}
    }
    Sql = Sql + ")";
  	connObj.delete(Sql);
	}

	response.sendRedirect("relativesDataList.jsp");
%>
</body>
</html>