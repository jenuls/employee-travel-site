<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="common.CopyOfFileUploadFile" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Insert title here</title>
</head>
<body>
<!-- import java class -->

<%
//String ss = request.getParameter("datepicker01");
CopyOfFileUploadFile dd = new CopyOfFileUploadFile();
String [] aa = dd.LDAP_AUTH_AD("ldap://127.0.0.1:389","11003691","123");
System.out.println(aa[0]);
%>
Hello!
</body>
</html>