<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="connect.TravelBean" %>
<%@ page language="java" import="myutil.*" %>
<%
	if(session.getAttribute("empNo") == null){
		RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
		dispatcher.forward(request,response);
		return;
	}
	String empNo = session.getAttribute("empNo").toString();
	TravelBean  trBean = new TravelBean();
	boolean isAdmin = trBean.isAdmin(empNo);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="css/style.css" type="text/css" />
	<link rel="stylesheet" href="css/jquery.ui.all.css" type="text/css">

	<script src="js/jquery-1.6.2.js"></script>
	<script src="js/jquery.bgiframe-2.1.2.js"></script>
	<script src="js/jquery.ui.core.js"></script>
	<script src="js/jquery.ui.widget.js"></script>
	<script src="js/jquery.ui.mouse.js"></script>
	<script src="js/jquery.ui.button.js"></script>
	<script src="js/jquery.ui.draggable.js"></script>
	<script src="js/jquery.ui.position.js"></script>
	<script src="js/jquery.ui.resizable.js"></script>
	<script src="js/jquery.ui.dialog.js"></script>
	<script src="js/jquery.effects.core.js"></script>
	<script src="js/jquery.ui.datepicker.js"></script>
	
	<title>親屬資料</title>
	
</head>
<body>
<form name="myForm" action="addRelativesDataAction.jsp" method="post">
	<div id="page" align="center">
		<div id="content" style="width:800px">
			<div id="logo">
				<div style="margin-top:70px" class="whitetitle">KYE</div>
			</div>
			<div id="topheader">
				<div align="left" class="bodytext"></div>
				<div style='text-align:right'>嗨, <%=session.getAttribute("empCName")%> 您好</div>
			</div>
			<div id='menu'>
                <div align='right' class='smallwhitetext' style='padding:9px;'>
                    <a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerPersonalDetail.jsp'>查詢</a> | <a href='adminTravelList.jsp' admin="true" >系統維護</a>
                </div>
			</div>
			<div id="submenu">
				<div align="right" class="smallgraytext" style="padding:9px;">
          			<a href="personalData.jsp">個人資料</a> | <a href="relativesDataList.jsp">親屬資料</a>
        		</div>
			</div>
			<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
			<div id="contenttext01">
				<div style="padding:0px;vertical-align:middle">
					<span class="titletext">親屬基本資料</span>
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
			<div class="bodytext" style="padding:1px" align="justify">
          <table class="FormTable">
              <tr>
				  <td class='FormTDH' style='width:20%'>關係</td>
				  <td class='FormTDH' style='width:30%'><input id='relation01' name='relation' type='radio' checked value='直系'>直系&nbsp;&nbsp;<input id='relation02' name='relation' type='radio' value='親友'>親友</td>
				  <td class='FormTDH' style='width:20%'>身份證字號</td>
				  <td class='FormTDH' style='width:30%'><input id='id' name='id' type='text' style='width:90%' value=''></td>
              </tr>
              <tr>
				  <td class='FormTDH' style='width:20%'>姓名</td>
				  <td class='FormTDH' style='width:30%'><input id='name' name='name' type='text' style='width:90%' value=''></td>
				  <td class='FormTDH' style='width:20%'>性別</td>
				  <td class='FormTDH' style='width:30%'><input id='gender01' name='gender' type='radio' checked value='男'>男&nbsp;&nbsp;<input id='gender02' name='gender' type='radio' value='女'>女</td>
              </tr>
              <tr>
				  <td class='FormTDH' style='width:20%'>生日</td>
				  <td class='FormTDH' style='width:80%' colspan='3'><input id='birthday' name='birthday' type='text' style='width:90%' value=''></td>
              </tr>
              <tr>
				  <td class='FormTDH' style='width:20%'>地址</td>
				  <td class='FormTDH' style='width:80%' colspan='3'><input id='address' name='address' type='text' style='width:96.5%' value=''></td>
              </tr>             
          </table>        
        </div>
        <div style="font-size:65%">
          <input type="button" onclick="submitFn();" value="確定"/>&nbsp;&nbsp;&nbsp;<input type="button" onclick="window.location.href='relativesDataList.jsp'" value="取消"/>
          <br /><br />
        </div>	
        <div style="border:1px solid #333333;width:100%"></div>
			</div>
			<div id="footer" class="smallgraytext">
				<a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerPersonalDetail.jsp'>查詢</a> | <a href='adminTravelList.jsp' admin="true">系統維護</a>

			</div>
		</div>
	</div>
</form>
</body>
</html>

<script>
$(document).ready(function()
{
	if($(":hidden[name='isAdmin']").val() == "false")
	{
		$("[admin='true']").hide(); 	
	}
	
	$( "#birthday" ).datepicker
	({
		changeMonth:true
	   ,changeYear: true
	  
	});
	
	$( "input:button").button();
	
		
	
}); //end of $(document).ready(function()
		
function submitFn(){
	if($.trim(document.forms[0].id.value)==""){
		alert("請填寫身分證字號，謝謝。");
		return false;
	}
	if($.trim(document.forms[0].name.value)==""){
		alert("請填寫姓名，謝謝。");
		return false;
	}
	if($.trim(document.forms[0].birthday.value)==""){
		alert("請選擇生日，謝謝。");
		return false;
	}
	if($.trim(document.forms[0].address.value)==""){
		alert("請填寫地址，謝謝。");
		return false;
	}
	document.forms[0].submit();
}
	</script>