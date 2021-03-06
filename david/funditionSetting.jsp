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
		$( "#datepicker1" ).datepicker();
		$( "#datepicker2" ).datepicker();
		$( "input:button").button();
	});
	function returnFn(){
		window.location.href="adminTravelList.jsp?travelNo=" + document.forms[0].travelNo.value + "&travelName=" + document.forms[0].travelName.value;
	}
		
	function submitFn(){
		if(document.forms[0].datepicker1.value==""){
			alert("顯示時間【開始】不得為空，謝謝。");
			return false;
		}
		
		if(document.forms[0].datepicker2.value==""){
			alert("顯示時間【結束】不得為空，謝謝。");
			return false;
		}
		
		document.forms[0].submit();
	}
	</script>
	<title>功能設定</title>
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
    ArrayList<String> al01 = new ArrayList<String>();
    al01 = connObj.select("select displayStartDate,displayEndDate,isRegister from travel where travelNo='" + travelNo + "'");
    String[] arr = al01.get(0).split(";");
    ArrayList<String> adminArrList = new ArrayList<String>();
    adminArrList = connObj.select("select EmpNo from admin");
	%>
</head>
<body>
<form name="myForm" action="funditionSettingAction.jsp" method="post">
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
					<% out.write("<span class='titletext'>" + travelName + "-功能設定</span>"); %>
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
			<div class="bodytext" style="padding:1px" align="justify">
          <table class="FormTable">
            <%
              if(al01.size()!=0){
                out.write("<tr>");
                out.write("<td class='FormTDH' style='width:20%'>顯示時間【開始】</td>");
                out.write("<td class='FormTDH' style='width:30%'><input id='datepicker1' name='datepicker1' type='text' style='width:90%' value='" + arr[0] + "'></td>");
                out.write("<td class='FormTDH' style='width:20%'>顯示時間【結束】</td>");
                out.write("<td class='FormTDH' style='width:30%'><input id='datepicker2' name='datepicker2' type='text' style='width:90%' value='" + arr[1] + "'></td>");
                out.write("</tr>");
                out.write("<tr>");
                out.write("<td class='FormTDH' style='width:20%'>開放報名</td>");
                if(arr[2].equals("1")){
                  out.write("<td class='FormTDH' style='width:30%'><input name='isRegister' type='radio' checked value='1'>是&nbsp;&nbsp;<input name='isRegister' type='radio' value='0'>否</td>");                  
                }else{
                  out.write("<td class='FormTDH' style='width:30%'><input name='isRegister' type='radio' value='1'>是&nbsp;&nbsp;<input name='isRegister' type='radio' checked value='0'>否</td>");              
                }
                out.write("<td class='FormTDH' style='width:20%'>清除所有報名</td>");
                out.write("<td class='FormTDH' style='width:30%'><input name='deleteRegister' type='radio' value='1'>是&nbsp;&nbsp;<input name='deleteRegister' type='radio' checked value='0'>否</td>");
                out.write("</tr>");         
              }else{
                out.write("<tr><td><a href='#' onclick='alert(\"ssss\");'>系統發生錯務，請聯絡目前程式維護人員，謝謝。</td></tr>");
              }
            %>
          </table>        
        </div>
        <div style="font-size:65%">
          <input type="button" onclick="submitFn();" value="確定"/>&nbsp;&nbsp;&nbsp;<input type="button" onclick="returnFn();" value="返回"/>
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
	</div>
</form>
</body>
</html>