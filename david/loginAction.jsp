<%@ page language="java" contentType="text/html; charset=UTF8"
	pageEncoding="UTF8"%>
<%@ page language="java" import="java.util.*"%>
<%@ page language="java" import="java.sql.ResultSet"%>
<%@ page language="java" import="connect.ConnectToMySql"%>
<%@ page language="java" import="common.LdapVerification"%>
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
    String ldap_url = this.getServletContext().getInitParameter("ldap_url");
    boolean loginOK = LdapObj.LDAP_AUTH_AD(ldap_url , userId, password);

    if (loginOK == true )
    {
        session.setAttribute("empNo", userId);
        ConnectToMySql connObj = new ConnectToMySql();
        ArrayList<String> al01 = new ArrayList<String>();
        al01 = connObj.select("select employeeNo,name  from personaldata where employeeNo='" + userId + "'");
       
        if (al01.size() == 0)//若沒有基本資料，就導入個人基本資料頁面，請使用者填寫資料。
        {
            response.sendRedirect("addPersonalData.jsp?empNo=" + userId);
        
        } else //有基本資料，進入旅遊報名頁面
        {
            String[] arr = al01.get(0).split(";");
            session.setAttribute("empCName", arr[1]);
     
            response.sendRedirect("index.jsp");
        }
    
    } else //認證失敗，導回登入頁 
    {
        response.sendRedirect("login.jsp");
    }
%>
</body>
</html>