<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.sql.ResultSet" %>
<%@ page language="java" import="connect.ConnectToMySql" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="css/style.css" type="text/css" />
	<link rel="stylesheet" href="css/jquery.ui.all.css" type="text/css">
	<script src="js/jquery-1.6.2.js"></script>
	<script src="js/jquery.ui.core.js"></script>
	<script src="js/jquery.ui.widget.js"></script>
	<script src="js/jquery.ui.datepicker.js"></script>
	<script src="js/jquery.ui.button.js"></script>
	<title>登入</title>
		<script>
	$(function() {
		$( "input:button").button();
	});
	</script>
</head>
<body>
<form name="input" action="loginAction.jsp" method="post">
	<div id="page" align="center">
    <table class="FormTable">
      <tr>
      <td style="width:50%">帳號：<input id="userId" name="userId" style="width:200px" type="text"></td>
      </tr>
      <tr>
      <td style="width:50%">密碼：<input id="password" name="password" style="width:200px" type="password"></td>
      </tr>
    </table>
    <br />
    <div style="font-size:65%">
      <input type="button" onclick="document.forms[0].submit();" value="登入"/>&nbsp;&nbsp;&nbsp;<input type="button" onclick="bb()" value="取消"/>
    </div>        
	</div>
</form>
</body>
</html>