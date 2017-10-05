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
	String travelNo = request.getParameter("travelNo").toString();
	//String roomType = request.getParameter("roomType").toString();
	String roomNo = request.getParameter("roomNo").toString();
	String empNo = session.getAttribute("empNo").toString();
	String flag = request.getParameter("flag").toString();
	ConnectToMySql connObj = new ConnectToMySql();
	String [] arr = returnValue.split(";");
	String sql = "update roommember set ";

	SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	Date date = new Date();
	String strDate = sdFormat.format(date);
  
	for(int i=0;i<arr.length;i++){
		if(arr[i].equals("NA")){
			connObj.update("update roommember set employeeNumber='NA',MemberName='NA',isTempFlag='N',writeDate='" + strDate + "' where travelNo='" + travelNo + "' and roomNo='" + roomNo + "' and roomDetailNo='0" + (i+1) + "'");
		}else if(!arr[i].equals("N")){
			connObj.update("update roommember set employeeNumber='" + empNo + "',MemberName='" + arr[i] + "',isTempFlag='Y',writeDate='" + strDate + "' where travelNo='" + travelNo + "' and roomNo='" + roomNo + "' and roomDetailNo='0" + (i+1) + "'"); 	
		}
	}
	connObj.update("update room set isSelect = '0' where travelNo='" + travelNo + "' and roomNo='" + roomNo + "'");
	//response.sendRedirect("selectRoom.jsp?travelNo=" + travelNo + "&roomNo=" + roomNo);
	if(flag.equals("0")){
		response.sendRedirect("selectRoom.jsp?flag=0&travelNo=" + travelNo + "&travelName=" + URLEncoder.encode(travelName,"UTF-8"));
	}else{
		response.sendRedirect("selectRoom.jsp?flag=1&travelNo=" + travelNo + "&travelName=" + URLEncoder.encode(travelName,"UTF-8"));
	}
%>
</body>
</html>