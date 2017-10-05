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
	<script src="js/creatRequestObj.js"></script>
<style>
		label, input { display:inline; }
		input.text { margin-bottom:12px; width:95%; padding: .4em; }
		fieldset { padding:0; border:0; margin-top:25px; }
		h1 { font-size: 1.2em; margin: .6em 0; }
		div#users-contain { width: 350px; margin: 20px 0; }
		div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
		div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
		.ui-dialog .ui-state-error { padding: .3em; }
		.validateTips { border: 1px solid transparent; padding: 0.3em; }
	</style>

	<script>
	$(function() {
		$( "#dialog-form" ).dialog({
			autoOpen: false,
			height: 350,
			width: 350,
			modal: true,
			buttons: {
        "送出報名": function() {
          //document.myForm.submit();
          sendData();
				},
				"取消": function() {
					$( this ).dialog( "close" );
				}			
			},
			close: function() {
				allFields.val( "" ).removeClass( "ui-state-error" );
			}
		});
 
		$( "#register" )
			.button()
			.click(function() {
				$( "#dialog-form" ).dialog( "open" );
			});
		$( "input:button").button();
	});

  function chk_Click(){
    var objArr = document.getElementsByName("relativesList");
    var selectedList = "";
    for(var i=0;i<objArr.length;i++){
      if(objArr[i].checked){
        if(selectedList==""){
          selectedList = objArr[i].value;
        }else{
          selectedList = selectedList + ";" + objArr[i].value;
        }
      }
    }
    document.getElementById("checkbox_selected").value = selectedList;
  }
  
  //create XMLHttpRequest Object
  var request = null;
  request = creatRequestObj();
  if (request == null){
    //無法取得XMLHttpRequest物件時發出警告
    alert("Error creating request object!");
  }

  //Send data to Server
  function sendData() {  
    var url = "selectPeople.jsp?travelNo=" + document.getElementById("travelNo").value + "&selectPeople=" + encodeURI(document.getElementById("checkbox_selected").value);
    request.open("GET", url, true);//開啟連線，選擇連線方式GET,POST
    request.onreadystatechange = getContents;//狀態完成時所要執行的函式
    request.send(null);//送出
  }

  function getContents() {
    if (request.readyState == 4) {//完成狀態有好幾種，4代表資料傳回完成
      var data = request.responseText;//取得傳回的資料存在變數中
      $( "#dialog-form" ).dialog( "close" );
      //var resultValue = data.substring(data.indexOf("<context>")+9,data.indexOf("</context>"));
    }
  }
  
  function sendDataO() {
    var url = "checkPeople.jsp?travelNo=" + document.getElementById("travelNo").value;
    request.open("GET", url, true);//開啟連線，選擇連線方式GET,POST
    request.onreadystatechange = getContentsO;//狀態完成時所要執行的函式
    request.send(null);//送出
  }

  function getContentsO() {
    if (request.readyState == 4) {//完成狀態有好幾種，4代表資料傳回完成
      var data = request.responseText;//取得傳回的資料存在變數中
      var resultValue = data.substring(data.indexOf("<context>")+9,data.indexOf("</context>"));
      if(resultValue=="0"){
      	alert("您尚未選擇旅遊人員，謝謝。");
      	return false;
      }else if(resultValue=="1"){
      	alert("房間位置大於報名人數，請將多選房間位置清除，謝謝。");
      	return false;      	
      }else if(resultValue=="2"){
      	document.forms[0].submit();
      }else if(resultValue=="3"){
      	alert("人員尚未選擇完畢，請確認人員全部皆有房間位置，謝謝。");
      	return false;
      }
    }
  }
	function selectRoom(){
		if(document.forms[0].checkbox_selected.value==""){
			if(document.forms[0].registerFlag.value=="0"){
				alert("請先選擇參加人員，謝謝。");
				return false;
			}
		}
		window.location.href="selectRoom.jsp?flag=1&travelNo=" + document.forms[0].travelNo.value + "&travelName=" + document.forms[0].travelName.value;	
	}
	function selectDesk(){
		if(document.forms[0].checkbox_selected.value==""){
			if(document.forms[0].registerFlag.value=="0"){
				alert("請先選擇參加人員，謝謝。");
				return false;			
			}
		}
		window.location.href="selectDesk.jsp?flag=1&travelNo=" + document.forms[0].travelNo.value + "&travelName=" + document.forms[0].travelName.value;	
	}
	function selectVehicle(){
		if(document.forms[0].checkbox_selected.value==""){
			if(document.forms[0].registerFlag.value=="0"){
				alert("請先選擇參加人員，謝謝。");
				return false;			
			}
		}
		window.location.href="selectVehicle.jsp?flag=1&travelNo=" + document.forms[0].travelNo.value + "&travelName=" + document.forms[0].travelName.value;			
	}
	
	function submitFn(){
		sendDataO();
	}
	</script>
	<title>行程規劃詳細資料</title>
	<%
		if(session.getAttribute("empNo") == null){
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request,response);
			return;
		}
    String empNo = session.getAttribute("empNo").toString();
    String empCName = session.getAttribute("empCName").toString();
    String travelNo = request.getParameter("travelNo");
    ConnectToMySql connObj = new ConnectToMySql();  
    ArrayList<String> al01 = new ArrayList<String>();
    al01 = connObj.select("select travelNo,travelName,travelDateStart,travelDateEnd,registerDateStart,registerDateEnd,travelQuantity,selfPay,room4Cost,room3Cost,room2Cost,room4Num,room3Num,room2Num,vehicleNum,tableNum,travelDesc,isRegister from travel where travelNo='" + travelNo + "'");
    String[] arr = al01.get(0).split(";");
    //取得親屬資料
    ArrayList<String> al02 = new ArrayList<String>();
    al02 = connObj.select("select relatives,name,age from relativesdata where employeeNumber='" + empNo + "'");
    System.out.println(al02.size());
    ArrayList<String> adminArrList = new ArrayList<String>();
    adminArrList = connObj.select("select EmpNo from admin");
    ArrayList<String> registerFlag = new ArrayList<String>();
    registerFlag = connObj.select("select COUNT(employeeNo) from registration where travelNo='" + travelNo + "' and employeeNo='" + empNo + "'");
	%>
</head>
<body>
<%
  out.write("<div id='dialog-form' title='親屬列表' style='font-size:11px'>");
  out.write("<p class='validateTips'>請選擇同行親屬</p>");
  out.write("<form>");
  out.write("<fieldset>");
  String temp="";
  String tempFlag="0";
  out.write("<input type='checkbox' style='border:none' onclick='chk_Click()' name='relativesList' id='relativesList' value='" + empCName + "' />" + empCName + "【員工】<br />");
  if(al02.size()!=0){
    for(int i=0;i<al02.size();i++){
    	String[] arr2 = al02.get(i).split(";");
      out.write("<input type='checkbox' style='border:none' onclick='chk_Click()' name='relativesList' id='relativesList' value='" + arr2[1] + "' />" + arr2[1] + "【" + arr2[0] + "】<br />");
      
      if(arr2[0].equals("直系")){
      	if(tempFlag.equals("0")){
      		tempFlag="1";
      		continue;
      	}
      	if(tempFlag.equals("1")){
      		if(temp==""){
      			temp = arr2[2];
    			}else{
    				temp = temp + ";" + arr2[2];	
    			}
      	}
      }else{
      	if(temp==""){
      		temp = arr2[2];
    		}else{
    			temp = temp + ";" + arr2[2];
    		}
      }
    }        
  }else{
    out.write("<span>無親屬資料.....</span>");
  }
  out.write("</fieldset>");
  out.write("</form>");
  out.write("</div>");
%>
<form name="myForm" action="travelPlanDetailAction.jsp" method="post">
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
          out.write("<a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerDetail.jsp'>查詢</a> | <a href='adminTravelList.jsp'>系統維護</a>");
					out.write("</div>");
					out.write("</div>");	
				}else{
					out.write("<div id='menu'>");
					out.write("<div align='right' class='smallwhitetext' style='padding:9px;'>");
          out.write("<a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerDetail.jsp'>查詢</a>");
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
					<br />
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
				<div class="bodytext" style="padding:1px" align="justify">
          <table class="FormTable">
            <%
              out.write("<tr>");
              out.write("<td class='FormTDH' style='width:20%'>行程編號</td>");
              out.write("<td class='FormTDH' style='width:30%'>" + arr[0] + "</td>");
              out.write("<td class='FormTDH' style='width:20%'>行程名稱</td>");
              out.write("<td class='FormTDH' style='width:30%'>" + arr[1] + "</td>");
              out.write("</tr>");
              out.write("<tr>");
              out.write("<td class='FormTDH' style='width:20%'>行程日期</td>");
              out.write("<td class='FormTDH' style='width:30%'>" + arr[2] + "~" + arr[3] + "</td>");
              out.write("<td class='FormTDH' style='width:20%'>報名日期</td>");
              out.write("<td class='FormTDH' style='width:30%'>" + arr[4] + "~" + arr[5] + "</td>");
              out.write("</tr>");
              out.write("<tr>");
              out.write("<td class='FormTDH' style='width:20%'>行程人數</td>");
              out.write("<td class='FormTDH' style='width:30%'>" + arr[6] + "</td>");
              out.write("<td class='FormTDH' style='width:20%'>自費金額</td>");
              out.write("<td class='FormTDH' style='width:30%'>" + arr[7] + "</td>");
              out.write("</tr>");
              out.write("<tr>");
              out.write("<td class='FormTDH' style='width:20%'>房間追加費用</td>");
              out.write("<td class='FormTDH' style='width:30%'>4人房【" + arr[8] + "】&nbsp;3人房【" + arr[9] + "】&nbsp;2人房【" + arr[10] + "】</td>");
              out.write("<td class='FormTDH' style='width:20%'>房間數量</td>");
              out.write("<td class='FormTDH' style='width:30%'>4人房【" + arr[11] + "】&nbsp;3人房【" + arr[12] + "】&nbsp;2人房【" + arr[13] + "】</td>");
              out.write("</tr>");
              out.write("<tr>");
              out.write("<td class='FormTDH' style='width:20%'>車輛數量</td>");
              out.write("<td class='FormTDH' style='width:30%'>" + arr[14] + "</td>");
              out.write("<td class='FormTDH' style='width:20%'>餐桌數量</td>");
              out.write("<td class='FormTDH' style='width:30%'>" + arr[15] + "</td>");
              out.write("</tr>");              
             	out.write("<tr>");
              out.write("<td class='FormTDH' style='width:20%'>公告</td>");
              out.write("<td class='FormTDH' style='width:30%'><a href='file/temp.doc'>101年國內旅遊公告</a></td>");
              out.write("<td class='FormTDH' style='width:20%'>行程文件</td>");
              out.write("<td class='FormTDH' style='width:30%'><a href='file/2011A001-01.pdf'>昆盈企業-花蓮蝴蝶谷二日行程(1月13日修正2)</a></td>");
              out.write("</tr>");         
            %>
          </table>
        </div>
        <br />
        <%
        	if(arr[17].equals("1")){
        	out.write("<div style='font-size:65%'>");
        	out.write("<input id='register' type='button' onclick='' value='選人'/>&nbsp;&nbsp;→&nbsp;&nbsp;");
        	out.write("<input type='button' onclick='selectRoom();' value='選房'/>&nbsp;&nbsp;→&nbsp;&nbsp;");
        	out.write("<input type='button' onclick='selectDesk();' value='選桌'/>&nbsp;&nbsp;→&nbsp;&nbsp;");
        	out.write("<input type='button' onclick='selectVehicle();' value='選車'/>&nbsp;&nbsp;&nbsp;&nbsp;<br /><br />");
        	out.write("<input type='button' onclick='submitFn();' value='確定'/>&nbsp;&nbsp;&nbsp;&nbsp;");
        	out.write("<input type='button' onclick=\"window.location.href='index.jsp'\" value='取消'/>&nbsp;&nbsp;&nbsp;&nbsp;");
        	out.write("</div><br />");     
        	}
        %>
        <div style="border:1px solid #333333;width:100%"></div>
			</div>
			<div id="footer" class="smallgraytext">
				<%
					if(flag.equals("1")){
          	out.write("<a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerDetail.jsp'>查詢</a> | <a href='adminTravelList.jsp'>系統維護</a>");
					}else{
          	out.write("<a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerDetail.jsp'>查詢</a>");				
					}
				%>
			</div>
		</div>
	</div>
	<% out.write("<input id='travelNo' name='travelNo' type='text' style='display:none' value='" + travelNo + "'>"); %>
	<% out.write("<input id='age' name='age' type='text' style='display:none1' value='" + temp + "'>"); %>
	<% out.write("<input id='travelName' name='travelName' type='' style='display:none' value='" + arr[1] + "'>"); %>
	<% out.write("<input id='registerFlag' name='registerFlag' type='' style='display:none' value='" + registerFlag.get(0) + "'>"); %>
  <input id="checkbox_selected" name="checkbox_selected" style="display:none" value="">
</form>
</body>
</html>