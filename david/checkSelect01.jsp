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
  String travelNo = request.getParameter("travelNo");
  String roomNo = request.getParameter("roomNo");
  ArrayList<String> al01 = new ArrayList<String>();
  ConnectToMySql connObj = new ConnectToMySql();

  al01 = connObj.select("select isSelect from room Where travelNo='" + travelNo + "' and roomNo='" + roomNo + "'");
  out.write("<context>");
  out.write(al01.get(0));
  out.write("</context>");
%>
</body>
</html>