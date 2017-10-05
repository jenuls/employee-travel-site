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
  String deleteFlag = request.getParameter("deleteFlag");
  ConnectToMySql connObj = new ConnectToMySql(); 
  
  if(deleteFlag.equals("1")){
    String temp01DeleteList = request.getParameter("temp01DeleteList");
  	String temp02DeleteList = request.getParameter("temp02DeleteList");
 		String temp03DeleteList = request.getParameter("temp03DeleteList");
		if(temp01DeleteList!=""){ 
  		String[] tempArr1 = temp01DeleteList.split(";");
  		String[] tempArr2 = temp02DeleteList.split(";");
  		String[] tempArr3 = temp03DeleteList.split(";");
  	
  		for(int i=0;i<tempArr1.length;i++){
   			connObj.delete("delete from feedata where travelNo='" + travelNo + "' and rangeStart='" + tempArr1[i] + "' and rangeEnd='" + tempArr2[i] + "' and money='" + tempArr3[i] + "'");
  		}
  	}
	}else{
  	String temp01List = request.getParameter("temp01List");
  	String temp02List = request.getParameter("temp02List");
  	String temp03List = request.getParameter("temp03List");
  	String SqlStr="insert into feedata values ";
		if(temp01List!=""){
  		connObj.delete("delete from feedata where travelNo='" + travelNo + "'");
  		String[] arr1 = temp01List.split(";");
  		String[] arr2 = temp02List.split(";");
  		String[] arr3 = temp03List.split(";");
  		for(int i=0;i<arr1.length;i++){
  			if(i==0){
  				SqlStr = SqlStr + "('" + travelNo + "','" + arr1[i] + "','" + arr2[i] + "','" + arr3[i] + "')";
  			}else{
  				SqlStr = SqlStr + ",('" + travelNo + "','" + arr1[i] + "','" + arr2[i] + "','" + arr3[i] + "')";  	
  			}
  		}
  		connObj.insert(SqlStr);
  	}		
	}
  response.sendRedirect("feeSetting.jsp?travelNo=" + travelNo + "&travelName=" + URLEncoder.encode(travelName,"UTF-8"));
%>
</body>
</html>