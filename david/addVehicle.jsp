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
	<script>
		$(function() {
			$( "input:button").button();
		});
		
		function submitF(typeFlag){
			if(typeFlag=="T"){
				var temp01="";
				if(document.getElementById("context1").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context1").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context1").value;						
					}					
				}
				if(document.getElementById("context2").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context2").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context2").value;						
					}					
				}
				if(document.getElementById("context3").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context3").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context3").value;						
					}					
				}
				if(document.getElementById("context4").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context4").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context4").value;						
					}					
				}
				if(document.getElementById("context5").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context5").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context5").value;						
					}					
				}
				if(document.getElementById("context6").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context6").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context6").value;						
					}					
				}
				if(document.getElementById("context7").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context7").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context7").value;						
					}					
				}
				if(document.getElementById("context8").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context8").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context8").value;						
					}					
				}
				if(document.getElementById("context9").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context9").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context9").value;						
					}					
				}
				if(document.getElementById("context10").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context10").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context10").value;						
					}					
				}
				if(document.getElementById("context11").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context11").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context11").value;						
					}					
				}
				if(document.getElementById("context12").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context12").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context12").value;						
					}					
				}
				if(document.getElementById("context13").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context13").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context13").value;						
					}					
				}
				if(document.getElementById("context14").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context14").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context14").value;						
					}					
				}
				if(document.getElementById("context15").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context15").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context15").value;						
					}					
				}
				if(document.getElementById("context16").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context16").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context16").value;						
					}					
				}
				if(document.getElementById("context17").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context17").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context17").value;						
					}					
				}
				if(document.getElementById("context18").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context18").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context18").value;						
					}					
				}
				if(document.getElementById("context19").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context19").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context19").value;						
					}					
				}
				if(document.getElementById("context20").value!=""){
					if(temp01==""){
						temp01 = document.getElementById("context20").value;
					}else{
						temp01 = temp01 + ";" + document.getElementById("context20").value;						
					}					
				}
							
			}
			document.getElementById("inputList").value = temp01;
			document.forms[0].submit();
		}
	</script>
	<title>新增車輛</title>
	<%
		if(session.getAttribute("empNo") == null){
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request,response);
			return;
		}
    String empNo = session.getAttribute("empNo").toString();
    String travelNo = request.getParameter("travelNo");
    String travelName = new String(request.getParameter("travelName").getBytes("ISO-8859-1"),"UTF-8");
    ConnectToMySql connObj = new ConnectToMySql();
    ArrayList<String> adminArrList = new ArrayList<String>();
    adminArrList = connObj.select("select EmpNo from admin");
	%>
</head>
<body>
<form name="myForm" action="addVehicleAction.jsp" method="post">
	<div id="page" align="center">
		<div id="content" style="width:800px">
			<div id="logo">
				<div style="margin-top:70px" class="whitetitle">KYE</div>
			</div>
			<div id="topheader">
				<div align="left" class="bodytext"></div>
				<% out.write("<div style='text-align:right'>嗨, " + session.getAttribute("empCName") + "您好</div>"); %>
			</div>
			<%
				String flag = "0";
				for(int i=0;i<adminArrList.size();i++){
					if(adminArrList.get(i).equals(empNo)){
						flag = "1";
					}
				}
				if(flag.equals("1")){
					out.write("<div id='menu'>");
					out.write("<div align='right' class='smallwhitetext' style='padding:9px;'>");
          out.write("<a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerPersonalDetail.jsp'>查詢</a> | <a href='adminTravelList.jsp'>系統維護</a>");
					out.write("</div>");
					out.write("</div>");	
				}else{
					out.write("<div id='menu'>");
					out.write("<div align='right' class='smallwhitetext' style='padding:9px;'>");
          out.write("<a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerPersonalDetail.jsp'>查詢</a>");
					out.write("</div>");
					out.write("</div>");					
				}
			%>
			<div id="submenu">
				<div align="right" class="smallgraytext" style="padding:9px;">
          
        </div>
			</div>
			<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
			<div id="contenttext01">
				<div style="padding:0px;vertical-align:middle">
					<span class="titletext">新增車輛</span>
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
				<div class="bodytext" style="padding:1px" align="justify">
					<div class="FontStyle02">請輸入車輛編號</div>
          <table class="FormTable">
            <%
            	out.write("<tr>");
              out.write("<td class='FormTDC' style='width:30%'><input id='context1' type='text' value=''></td>");
              out.write("<td class='FormTDC' style='width:30%'><input id='context2' type='text' value=''></td>");
              out.write("<td class='FormTDC' style='width:30%'><input id='context3' type='text' value=''></td>");
              out.write("<td class='FormTDC' style='width:30%'><input id='context4' type='text' value=''></td>");
              out.write("<td class='FormTDC' style='width:30%'><input id='context5' type='text' value=''></td>");
            	out.write("</tr>");
            	out.write("<tr>");
							out.write("<td class='FormTDC' style='width:30%'><input id='context6' type='text' value=''></td>");
							out.write("<td class='FormTDC' style='width:30%'><input id='context7' type='text' value=''></td>");
							out.write("<td class='FormTDC' style='width:30%'><input id='context8' type='text' value=''></td>");
							out.write("<td class='FormTDC' style='width:30%'><input id='context9' type='text' value=''></td>");
							out.write("<td class='FormTDC' style='width:30%'><input id='context10' type='text' value=''></td>");
            	out.write("</tr>");
            	out.write("</tr>");
            	out.write("<tr>");
							out.write("<td class='FormTDC' style='width:30%'><input id='context11' type='text' value=''></td>");
							out.write("<td class='FormTDC' style='width:30%'><input id='context12' type='text' value=''></td>");
							out.write("<td class='FormTDC' style='width:30%'><input id='context13' type='text' value=''></td>");
							out.write("<td class='FormTDC' style='width:30%'><input id='context14' type='text' value=''></td>");
							out.write("<td class='FormTDC' style='width:30%'><input id='context15' type='text' value=''></td>");
            	out.write("</tr>");
            	out.write("</tr>");
            	out.write("<tr>");
							out.write("<td class='FormTDC' style='width:30%'><input id='context16' type='text' value=''></td>");
							out.write("<td class='FormTDC' style='width:30%'><input id='context17' type='text' value=''></td>");
							out.write("<td class='FormTDC' style='width:30%'><input id='context18' type='text' value=''></td>");
							out.write("<td class='FormTDC' style='width:30%'><input id='context19' type='text' value=''></td>");
							out.write("<td class='FormTDC' style='width:30%'><input id='context20' type='text' value=''></td>");
            	out.write("</tr>");
            %>
          </table>  
        </div>	
        <div style="font-size:65%">
          <input type="button" onclick="submitF('T')" value="確定"/>&nbsp;&nbsp;&nbsp;<input type="button" onclick="submitF('F')" value="離開"/>
          <br /><br />
        </div>
        <div style="border:1px solid #333333;width:100%"></div>
			</div>
			<div id="footer" class="smallgraytext">
				<%
					if(flag.equals("1")){
          	out.write("<a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerPersonalDetail.jsp'>查詢</a> | <a href='adminTravelList.jsp'>系統維護</a>");
					}else{
          	out.write("<a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerPersonalDetail.jsp'>查詢</a>");				
					}
				%>
			</div>
		</div>
		<% out.write("<input id='travelNo' name='travelNo' type='text' style='display:none' value='" + travelNo + "'>"); %>
		<% out.write("<input id='travelName' name='travelName' type='text' style='display:none' value='" + travelName + "'>"); %>
		<input id="inputList" name="inputList" style="display:none" value="">
	</div>
</form>
</body>
</html>