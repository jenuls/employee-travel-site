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
	<script src="js/creatRequestObj.js"></script>
  <script>
  //create XMLHttpRequest Object
  var request = null;
  request = creatRequestObj();
  if (request == null){
    //無法取得XMLHttpRequest物件時發出警告
    alert("Error creating request object!");
  }
	$(function() {
		$( "#datepicker" ).datepicker();
		$( "input:button").button();
	});
  function sendData() {
    var url = "checkPeople03.jsp?travelNo=" + document.getElementById("travelNo").value + "&travelName=" + encodeURI(document.getElementById("travelName").value) + "&empNo=" + document.getElementById("empNo").value + "&nameTemp=" + encodeURI(document.getElementById("nameTemp").value);
    request.open("GET", url, true);//開啟連線，選擇連線方式GET,POST
    request.onreadystatechange = getContents;//狀態完成時所要執行的函式
    request.send(null);//送出
  }

  function getContents() {
    if (request.readyState == 4) {//完成狀態有好幾種，4代表資料傳回完成
      var data = request.responseText;//取得傳回的資料存在變數中
      var resultValue = data.substring(data.indexOf("<context>")+9,data.indexOf("</context>"));
      if(resultValue=="0"){
      	alert("您新增的人員並沒有存在於個人資料，謝謝。");
      	return false;
      }else if(resultValue=="1"){
      	alert("您新增的人員並沒有存在於親屬資料，謝謝。");
      	return false;      	
      }else if(resultValue=="2"){
      	document.forms[0].submit();
      }
    }
  }

	function submitFn(){
		if(document.getElementById("empNo").value == ""){
			alert("請填入工號，謝謝。");
			return false;
		}
		if(document.getElementById("nameTemp").value == ""){
			alert("請填入姓名，謝謝。");
			return false;
		}
		sendData();
	}
	
	function returnFn(){
		window.location.href="adminRegisterList.jsp?travelNo=" + document.forms[0].travelNo.value + "&travelName=" + document.forms[0].travelName.value;			
	}
	</script>
	<title>增加報名人員</title>
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
<form name="myForm" action="addRegisterPeopleAction.jsp" method="post">
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
					<span class="titletext">增加報名人員</span>
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
			<div class="bodytext" style="padding:1px" align="justify">
          <table class="FormTable">
            <%
              out.write("<tr>");
              out.write("<td class='FormTDH' style='width:10%'>工號</td>");
              out.write("<td class='FormTDH' style='width:40%'><input id='empNo' name='empNo' type='text' style='width:90%' value=''></td>");
              out.write("<td class='FormTDH' style='width:10%'>姓名</td>");
              out.write("<td class='FormTDH' style='width:40%'><input id='nameTemp' name='nameTemp' type='text' style='width:90%' value=''></td>");
              out.write("</tr>");
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