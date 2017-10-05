<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.sql.ResultSet" %>
<%@ page language="java" import="connect.ConnectToMySql" %>
<%@ page language="java" import="connect.TravelBean" %>
<%@ page language="java" import="myutil.DateUtil" %>
<%@ page language="java" import="myutil.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
  String empNo = session.getAttribute("empNo").toString();
  String relation = new String(request.getParameter("relation").getBytes("ISO-8859-1"),"UTF-8");
  String idNo = request.getParameter("id").toString();
  String name = new String(request.getParameter("name").getBytes("ISO-8859-1"),"UTF-8");
  String gender = new String(request.getParameter("gender").getBytes("ISO-8859-1"),"UTF-8");
  String birthday = request.getParameter("birthday").toString();
  String address = new String(request.getParameter("address").getBytes("ISO-8859-1"),"UTF-8");

  int age = DateUtil.getAge(birthday);
  ConnectToMySql connObj = new ConnectToMySql();
  ArrayList<String> al01 = new ArrayList<String>();  
  al01 = connObj.select("select employeeNumber from relativesdata where employeeNumber='" + empNo + "' and idNumber='" + idNo + "'"); 
  if (al01.size()==0){
    connObj.insert("insert into relativesdata (employeeNumber, relatives, name, idNumber, gender, age, birthday, address) values ('" + empNo + "','" + relation + "','" + name + "','" + idNo + "','" + gender + "','" + age + "','" + birthday + "','" + address + "')");
	}else{
    connObj.update("update relativesdata set employeeNumber ='" + empNo + "', relatives = '" + relation + "', name = '" + name + "', idNumber = '" + idNo + "', gender = '" + gender + "', age = '" + age + "', birthday = '" + birthday + "', address = '" + address + "' where employeeNumber = '" + empNo + "' and idNumber='" + idNo + "'");
  }
  response.sendRedirect("relativesDataList.jsp");
%>
</body>
</html>