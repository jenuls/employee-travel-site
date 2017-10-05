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
  String empNo = strUtil.getPara( session.getAttribute("empNo").toString() );
  String id = strUtil.getPara(request.getParameter("id"));
  String name = new String(request.getParameter("name").getBytes("ISO-8859-1"),"UTF-8");
  String gender = new String(request.getParameter("gender").getBytes("ISO-8859-1"),"UTF-8");
  String birthday = strUtil.getPara(request.getParameter("birthday"));
  String address = new String(request.getParameter("address").getBytes("ISO-8859-1"),"UTF-8");
  TravelBean travBean = new  TravelBean();
 
  int age = DateUtil.getAge(birthday);

  ConnectToMySql connObj = new ConnectToMySql();
  String sql = "update personaldata set employeeNo ='" + empNo + "', name = '" + name + "', idNumber = '" + id + "', gender = '" + gender + "', age = '" + age + "', birthday = '" + birthday + "', address = '" + address + "' where employeeNo = '" + empNo + "'";
  connObj.update(sql);
  session.setAttribute("empCName",name.trim());
  response.sendRedirect("index.jsp");
%>
empNo=<%=empNo%><br>
id=<%=id%><br>
name=<%=name%><br>
age=<%=age%><br>
gender=<%=gender%><br>
birthday=<%=birthday%><br>
address=<%=address%><br>
sql=<%=sql%><br>
</body>
</html>