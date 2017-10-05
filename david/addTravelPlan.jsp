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
		$( "#datepicker01" ).datepicker();
		$( "#datepicker02" ).datepicker();
		$( "#datepicker03" ).datepicker();
		$( "#datepicker04" ).datepicker();
		$( "#datepicker05" ).datepicker();
		$( "#datepicker06" ).datepicker();
		$( "input:button").button();
		//$( "a", ".demo" ).click(function() { return false; });
	});
	</script>
	<title>行程規劃詳細資料</title>
	<%
		if(session.getAttribute("empNo") == null){
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request,response);
			return;
		}
    String empNo = session.getAttribute("empNo").toString();
    ConnectToMySql connObj = new ConnectToMySql();
    ArrayList<String> adminArrList = new ArrayList<String>();
    adminArrList = connObj.select("select EmpNo from admin");
	%>
</head>
<body>
<form name="myForm" action="addTravelPlanAction.jsp" method="post">
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
					<span class="titletext">行程規劃詳細資料</span>
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
				<div class="bodytext" style="padding:1px" align="justify">
          <table class="FormTable">
            <%
            	out.write("<tr>");
              out.write("<td class='FormTDH' style='width:20%'>行程編號</td>");
              out.write("<td class='FormTDC' style='width:30%'><input id='travelNo' name='travelNo' type='text' value=''></td>");
              out.write("<td class='FormTDH' style='width:20%'>行程名稱</td>");
              out.write("<td class='FormTDC' style='width:30%'><input id='travelName' name='travelName' type='text' value=''></td>");
            	out.write("</tr>");
            	out.write("<tr>");
              out.write("<td class='FormTDH' style='width:20%'>行程日期【開始】</td>");
              out.write("<td class='FormTDC' style='width:30%'><input id='datepicker01' name='datepicker01' type='text' value=''></td>");
              out.write("<td class='FormTDH' style='width:20%'>行程日期【結束】</td>");
              out.write("<td class='FormTDC' style='width:30%'><input id='datepicker02' name='datepicker02' type='text' value=''></td>");              
            	out.write("</tr>");
            	out.write("<tr>");
              out.write("<td class='FormTDH' style='width:20%'>報名日期【開始】</td>");
              out.write("<td class='FormTDC' style='width:30%'><input id='datepicker03' name='datepicker03' type='text' value=''></td>");
              out.write("<td class='FormTDH' style='width:20%'>報名日期【結束】</td>");
              out.write("<td class='FormTDC' style='width:30%'><input id='datepicker04' name='datepicker04' type='text' value=''></td>");
            	out.write("</tr>");                       
            	out.write("<tr>");
              out.write("<td class='FormTDH' style='width:20%'>行程人數</td>");
              out.write("<td class='FormTDC' style='width:30%'><input id='travelQuantity' name='travelQuantity' type='text' value=''></td>");
              out.write("<td class='FormTDH' style='width:20%'>自費金額</td>");
              out.write("<td class='FormTDC' style='width:30%'><input id='selfPay' name='selfPay' type='text' value=''></td>");
            	out.write("</tr>");
            	out.write("<tr>");
              out.write("<td class='FormTDH' style='width:20%'>房間追加費用</td>");
              out.write("<td class='FormTDC' style='width:30%'>4人：<input id='room4Cost' name='room4Cost' type='text' value=''><br />3人：<input id='room3Cost' name='room3Cost' type='text' value=''><br />2人：<input id='room2Cost' name='room2Cost' type='text' value=''>");
              out.write("</td>");
              out.write("<td class='FormTDH' style='width:20%'>房間數量</td>");
              out.write("<td class='FormTDC' style='width:30%'>4人：<input id='room4Num' name='room4Num' type='text' value=''><br />3人：<input id='room3Num' name='room3Num' type='text' value=''><br />2人：<input id='room2Num' name='room2Num' type='text' value=''>");
              out.write("</td>");
            	out.write("</tr>");
            	out.write("<tr>");
              out.write("<td class='FormTDH' style='width:20%'>車輛數量</td>");
              out.write("<td class='FormTDC' style='width:30%'><input id='vehicleNum' name='vehicleNum' type='text' value=''></td>");
              out.write("<td class='FormTDH' style='width:20%'>餐桌數量</td>");
              out.write("<td class='FormTDC' style='width:30%'><input id='tableNum' name='tableNum' type='text' value=''></td>");
           		out.write("</tr>");
            	out.write("<tr>");
              out.write("<td class='FormTDH' style='width:20%'>行程說明</td>");
              out.write("<td class='FormTDC' style='width:80%' colspan='3'><input id='travelDesc' name='travelDesc' type='text' value=''></td>");
            	out.write("</tr>");    
            %>
          </table>  
        </div>	
        <div style="font-size:65%">
          <input type="button" onclick="document.forms[0].submit();" value="確定"/>&nbsp;&nbsp;&nbsp;<input type="button" onclick="window.location.href='adminTravelList.jsp'" value="離開"/>
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
	</div>
</form>
</body>
</html>