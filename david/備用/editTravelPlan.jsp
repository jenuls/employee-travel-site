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
          document.myForm.submit();
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
	</script>
	<title>行程規劃詳細資料</title>
	<%
    String travelNo = request.getParameter("travelNo");
    ConnectToMySql connObj = new ConnectToMySql();  
    ArrayList<String> al01 = new ArrayList<String>();
    al01 = connObj.select("select * from travel where travelNo='" + travelNo + "'");
    String[] arr = al01.get(0).split(";");
    
    //取得親屬資料
    String empNo = session.getAttribute("empNo").toString();
    ArrayList<String> al02 = new ArrayList<String>();
    al02 = connObj.select("select relatives,name from relativesdata where employeeNumber='" + empNo + "'");
	%>
</head>
<body>
<%
  out.write("<div id='dialog-form' title='親屬列表' style='font-size:11px'>");
  out.write("<p class='validateTips'>請選擇同行親屬</p>");
  out.write("<form>");
  out.write("<fieldset>");
  if(al02.size()!=0){
    String[] arr2 = al02.get(0).split(";");
    for(int i=0;i<al02.size();i++){
      out.write("<input type='checkbox' style='border:none' onclick='chk_Click()' name='relativesList' id='relativesList' value='" + arr2[1] + "' />" + arr2[1] + "【" + arr2[0] + "】");
    }        
  }else{
    out.write("<span>無親屬資料.....</span>");    
  }
  //out.write("<br /><input type='checkbox' style='border:none' onclick='chk_Click()' name='relativesList' id='relativesList' value='Test001' />Test001【親屬】");
  //out.write("<br /><input type='checkbox' style='border:none' onclick='chk_Click()' name='relativesList' id='relativesList' value='Test002' />Test002【親屬】");
  //out.write("<br /><input type='checkbox' style='border:none' onclick='chk_Click()' name='relativesList' id='relativesList' value='Test003' />Test003【親屬】");
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
			<div id="menu">
				<div align="right" class="smallwhitetext" style="padding:9px;">
          <a href="index.jsp">首頁</a> | <a href="personalData.jsp">基本資料維護</a> | <a href="registeredTravel.jsp">位置選定</a> | <a href="#">查詢</a> | <a href="#">系統維護</a>
				</div>
			</div>
			<div id="submenu">
				<div align="right" class="smallgraytext" style="padding:9px;">
        </div>
			</div>
			<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
			<div id="contenttext01">
				<div style="padding:0px;vertical-align:middle">
					<span class="titletext">行程規劃詳細資料</span>
          <span style="font-size:65%"><input id="register" type="button" value="報名"/></span>
					<br />
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
				<div class="bodytext" style="padding:1px" align="justify">
   
        </div>
        <div style="border:1px solid #333333;width:100%"></div>
			</div>
			<div id="footer" class="smallgraytext">
				<a href="index.jsp">首頁</a> | <a href="personalData.jsp">基本資料維護</a> | <a href="registeredTravel.jsp">位置選定</a> | <a href="#">查詢</a> | <a href="#">系統維護</a>
			</div>
		</div>
	</div>
	<% out.write("<input id='travelNo' name='travelNo' type='text' style='display:none' value='" + travelNo + "'>"); %>
  <input id="checkbox_selected" name="checkbox_selected" style="display:none" value="">
</form>
</body>
</html>