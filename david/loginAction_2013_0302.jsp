<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.sql.ResultSet" %>
<%@ page language="java" import="connect.ConnectToMySql" %>
<%@ page language="java" import="common.LdapVerification" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
<title>Insert title here</title>
</head>
<body>
<%
  String userId = request.getParameter("userId");
  String password = request.getParameter("password");
  //String empId = request.getParameter("password");

  LdapVerification LdapObj = new LdapVerification();
  String [] resultValue = LdapObj.LDAP_AUTH_AD("ldap://127.0.0.1:389",userId,password);
               
  if(resultValue[0].equals("0")){
    session.setAttribute("empNo",userId);
    ConnectToMySql connObj = new ConnectToMySql();
    ArrayList<String> al01 = new ArrayList<String>();
    al01 = connObj.select("select employeeNo,name  from personaldata where employeeNo='" + userId + "'");
    if(al01.size()==0){
      response.sendRedirect("addPersonalData.jsp?empNo=" + userId);    
    }else{
      String[] arr = al01.get(0).split(";");
      session.setAttribute("empCName",arr[1]);
      response.sendRedirect("index.jsp");     
    }
  }else{
    response.sendRedirect("login.jsp");
  }

%>
</body>
</html>