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
	<script>
		$(function() {
			$( "input:button").button();
		});
	function deleteP(){
		var obj01=document.getElementsByName("selectedFlag");
		var temp01="";
		for(var i=0;i<obj01.length;i++){
			if(obj01[i].checked){
				if(temp01==""){
					temp01 = obj01[i].value;
				}else{
					temp01 = temp01 + "," + obj01[i].value;
				}
			}
		}
		document.getElementById("selectedValue").value = temp01; 
		if(temp01==""){
			alert("請選擇欲刪除的資料，謝謝");
			return false;
		}
		document.forms[0].submit();
	}
	
	function addP(){
		window.location.href="addRegisterPeople.jsp?travelNo=" + document.forms[0].travelNo.value + "&travelName=" + document.forms[0].travelName.value;
	}
	</script>
	<title>報名人員管理</title>
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
    al01 = connObj.select("select employeeNo,name,temp from registration where travelNo='" + travelNo +"'");
    ArrayList<String> adminArrList = new ArrayList<String>();
    adminArrList = connObj.select("select EmpNo from admin");
	
	%>
</head>
<body>
<form name="myForm" action="adminRegisterListAction.jsp" method="post">
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
				<div align="right" class="smallgraytext" style="padding:9px;"></div>
			</div>
			<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
			<div id="contenttext01">
				<div style="padding:0px;vertical-align:middle">
					<% out.write("<span class='titletext'>" + travelName + "-報名人員管理</span>"); %>
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
			<div class="bodytext" style="padding:1px" align="justify">
        <div style="font-size:85%"><input type="button" onclick="addP()" value="新增"/><input type="button" onclick="deleteP()" value="刪除"/></div>
          <table class="FormTable">
            <%
              if(al01.size()!=0){
                out.write("<tr>");
                out.write("<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'></td>");
                out.write("<td class='FormTDH' style='width:30%;background:#BBBBBB;color:#FFFFFF;padding:3px'>員工工號</td>");
                out.write("<td class='FormTDH' style='width:30%;background:#BBBBBB;color:#FFFFFF;padding:3px'>員工名稱</td>");
                out.write("<td class='FormTDH' style='width:30%;background:#BBBBBB;color:#FFFFFF;padding:3px'>報名完成</td>");
                out.write("</tr>");
                String[] arr = null;
                for(int i=0;i<al01.size();i++){
                  arr = al01.get(i).split(";");
                  if(arr[2].equals("1")){
                  	out.write("<tr>");
                  	out.write("<td class='FormTDH' style='width:10%;padding:3px'><input name='selectedFlag' type='checkbox' value='" + arr[0] + ";" + arr[1] + "'></td>");
                  	out.write("<td class='FormTDH' style='width:30%;padding:3px'>" + arr[0] + "</td>");
                  	out.write("<td class='FormTDH' style='width:30%;padding:3px'>" + arr[1] + "</td>");
										out.write("<td class='FormTDH' style='width:30%;padding:3px'>是</td>");
                  	out.write("</tr>");                  
                  }else{
                  	out.write("<tr>");
                  	out.write("<td class='Temp' style='width:10%;padding:3px'><input name='selectedFlag' type='checkbox' value='" + arr[0] + ";" + arr[1] + "'></td>");
                  	out.write("<td class='Temp' style='width:30%;padding:3px'>" + arr[0] + "</td>");
                  	out.write("<td class='Temp' style='width:30%;padding:3px'>" + arr[1] + "</td>");
                  	out.write("<td class='Temp' style='width:30%;padding:3px'>否</td>");
                  	out.write("</tr>");
                  }
                }               
              }else{
                  out.write("<tr><td>目前無報名人員資料........</td></tr>");
              }       
            %>
          </table>        
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
		<input id="selectedValue" name="selectedValue" type="text" style="display:none" value="">
	</div>
</form>
</body>
</html>