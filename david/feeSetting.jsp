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
		
		function submitFn(sbumitType){
			if(sbumitType=="S"){
				var temp01Arr = document.getElementsByName("rangeStart");
				var temp02Arr = document.getElementsByName("rangeEnd");
				var temp03Arr = document.getElementsByName("money");
				var temp01 = "";
				var temp02 = "";
				var temp03 = "";
				for(var i=0;i<temp01Arr.length;i++){
					if(temp01==""){
						temp01 = temp01Arr[i].value;
						temp02 = temp02Arr[i].value;
						temp03 = temp03Arr[i].value;	
					}else{
						temp01 = temp01 + ";" + temp01Arr[i].value;
						temp02 = temp02 + ";" + temp02Arr[i].value;
						temp03 = temp03 + ";" + temp03Arr[i].value;
					}
				}
				document.getElementById("temp01List").value = temp01;
				document.getElementById("temp02List").value = temp02;
				document.getElementById("temp03List").value = temp03;
			}
			document.forms[0].submit();	
		}
		
		function deleteFee(){
			var obj=document.getElementsByName("feeChb");
			var tempArr;
			var temp01="";
			var temp02="";
			var temp03="";
			
			for(var i=0;i<obj.length;i++){
				if(obj[i].checked){
					tempArr = obj[i].value.split(";");
					if(temp01==""){
						temp01 = tempArr[0];
						temp02 = tempArr[1];
						temp03 = tempArr[2];
					}else{
						temp01 = temp01 + ";" + tempArr[0];
						temp02 = temp02 + ";" + tempArr[1];
						temp03 = temp03 + ";" + tempArr[2];				
					}
				}
			}
			document.getElementById("temp01DeleteList").value = temp01;
			document.getElementById("temp02DeleteList").value = temp02;
			document.getElementById("temp03DeleteList").value = temp03;
			if(temp01=="" && temp02=="" && temp03==""){
				alert("請選擇欲刪除的資料，謝謝");
				return false;
			}
			document.getElementById("deleteFlag").value = "1";
			document.forms[0].submit();
		}
		function addFee(){
			window.location.href="addFeeSetting.jsp?travelNo=" + document.forms[0].travelNo.value + "&travelName=" + document.forms[0].travelName.value;
		}
		function returnFn(){
			window.location.href="adminTravelList.jsp?travelNo=" + document.forms[0].travelNo.value + "&travelName=" + document.forms[0].travelName.value;
		}
	</script>
	<title>費用設定</title>
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
    al01 = connObj.select("select rangeStart,rangeEnd,money from feedata where travelNo='" + travelNo + "'  order by cast(rangeStart as unsigned) asc");
    ArrayList<String> adminArrList = new ArrayList<String>();
    adminArrList = connObj.select("select EmpNo from admin");
	%>
</head>
<body>
<form name="myForm" action="feeSettingAction.jsp" method="post">
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
					<% out.write("<span class='titletext'>" + travelName + "-費用設定</span>"); %>
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
			<div class="bodytext" style="padding:1px" align="justify">
					<div style="font-size:85%"><input type="button" onclick="addFee();" value="新增"><input type="button" onclick="deleteFee();" value="刪除"></div>
          <table class="FormTable">
            <%
              if(al01.size()!=0){
                out.write("<tr>");
                out.write("<td class='FormTDH' style='width:10%'></td>");
                out.write("<td class='FormTDH' style='width:30%'>年齡區間【開始】</td>");
                out.write("<td class='FormTDH' style='width:30%'>年齡區間【結束】</td>");
                out.write("<td class='FormTDH' style='width:30%'>付費金額</td>");                
                out.write("</tr>");
                String[] arr = null;
                for(int i=0;i<al01.size();i++){
               		arr = al01.get(i).split(";");
               		out.write("<tr>");
									out.write("<td class='FormTDH' style='width:10%;padding:3px'><input name='feeChb' type='checkbox' value='" + arr[0] + ";" + arr[1] + ";" + arr[2] + "'></td>");
              		out.write("<td class='FormTDC' style='width:30%'><input name='rangeStart' type='text' value='" + arr[0] + "'></td>");
              		out.write("<td class='FormTDC' style='width:30%'><input name='rangeEnd' type='text' value='" + arr[1] + "'></td>");
            			out.write("<td class='FormTDC' style='width:30%'><input name='money' type='text' value='" + arr[2] + "'></td>");
            			out.write("</tr>");
                }          
              }else{
                out.write("<tr><td>無費用設定維護檔，請新增，謝謝。</td></tr>");
              }
            %>
          </table>        
        </div>
        <div style="font-size:65%">
          <input type="button" onclick="submitFn('S');" value="確定"/>&nbsp;&nbsp;&nbsp;<input type="button" onclick="returnFn();" value="返回"/>
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
		<input type="text" id="temp01List" name="temp01List" style="display:none" value="">
		<input type="text" id="temp02List" name="temp02List" style="display:none" value="">
		<input type="text" id="temp03List" name="temp03List" style="display:none" value="">
		<input type="text" id="temp01DeleteList" name="temp01DeleteList" style="display:none" value="">
		<input type="text" id="temp02DeleteList" name="temp02DeleteList" style="display:none" value="">
		<input type="text" id="temp03DeleteList" name="temp03DeleteList" style="display:none" value="">
		<input type="text" id="deleteFlag" name="deleteFlag" style="display:none" value="0">
	</div>
</form>
</body>
</html>