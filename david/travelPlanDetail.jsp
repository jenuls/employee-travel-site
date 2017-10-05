<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="connect.TravelBean" %>
<%@ page language="java" import="myutil.strUtil" %>
<%
		if(session.getAttribute("empNo") == null){
			response.sendRedirect("login.jsp");
			response.flushBuffer();
			return;
		}
    String empNo = session.getAttribute("empNo").toString();
    String empCName = session.getAttribute("empCName").toString();
    String travelNo = request.getParameter("travelNo");
	TravelBean  trBean = new TravelBean();
	String[] para = new String[30];
	para[0] = travelNo;
	Collection col = trBean.getTravel(para);  //取得旅程資料
	boolean isAdmin = trBean.isAdmin(empNo);
	String travelName = "";
	String travelDateStart = "";  //行程開始日期
	String travelDateEnd = "";  //行程結束日期
	String registerDateStart = ""; //報名開始日期
	String registerDateEnd = ""; //報名結束日期
	String travelQuantity = ""; //行程人數
	String selfPay = "";  //自費金額
	String room4Cost = ""; //4人房追加費用
	String room3Cost = ""; //3人房追加費用
	String room2Cost = ""; //2人房追加費用
	String room4Num = ""; //4人房數量
	String room3Num = ""; //3人房數量
	String room2Num = ""; //2人房數量
	String tableNum = "";  //餐桌數量
	String vehicleNum = ""; //車輛數量
	String isRegister = ""; //是否開放報名
	if(col != null && col.size() > 0)
	{
	 	Iterator it = col.iterator();
		HashMap hm = null;
		while(it.hasNext() )
		{
			hm = (HashMap)it.next();
			travelName = strUtil.getPara(hm.get("travelName"));
			travelDateStart = strUtil.getPara(hm.get("travelDateStart"));	
			travelDateEnd = strUtil.getPara(hm.get("travelDateEnd"));
			registerDateStart = strUtil.getPara(hm.get("registerDateStart"));	
			registerDateEnd = strUtil.getPara(hm.get("registerDateEnd"));		
			travelQuantity = strUtil.getPara(hm.get("travelQuantity"));	
			selfPay = strUtil.getPara(hm.get("selfPay"));	
			room4Cost = strUtil.getPara(hm.get("room4Cost"));
			room3Cost = strUtil.getPara(hm.get("room3Cost"));
			room2Cost = strUtil.getPara(hm.get("room2Cost"));
			room4Num = strUtil.getPara(hm.get("room4Num"));
			room3Num = strUtil.getPara(hm.get("room3Num"));
			room2Num = strUtil.getPara(hm.get("room2Num"));
			tableNum = strUtil.getPara(hm.get("tableNum"));
			vehicleNum = strUtil.getPara(hm.get("vehicleNum"));	
			isRegister = strUtil.getPara(hm.get("isRegister"));			
		}
	}
	
	Collection col2 = trBean.getRelativesdata(empNo); //取得親屬資料
	boolean registerFlag = trBean.isRegister(travelNo, empNo); //是否已報名

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

	
	<title>行程規劃詳細資料</title>
	
</head>
<body>
 
  
<form name="myForm" action="travelPlanDetailAction.jsp" method="post">
<input type="hidden" name="isAdmin" value="<%=isAdmin%>" > <!--是否是管理者 -->
<input type="hidden" id='travelNo' name='travelNo' value='<%=travelNo%>'>
<input type="hidden" id='travelName' name='travelName'  value='<%=travelName%>'>
<input type="hidden" id='registerFlag' name='registerFlag' value='<%=registerFlag%>'><!--若為"true" 表示已登記該行程 -->
<input type="hidden" id="checkbox_selected" name="checkbox_selected"  value=""> <!--存放報名的人員姓名 -->
<input type="hidden" id="isRegister" name="isRegister"  value="<%=isRegister%>"> <!--是否已開放報名(1:開放) -->

	<div id="page" align="center">
		<div id="content" style="width:800px">
			<div id="logo">
				<div style="margin-top:70px" class="whitetitle">KYE</div>
			</div>
			<div id="topheader">
				<div align="left" class="bodytext"></div>
				<table align="right" border="0">
                <tr>
                   <td><div style='text-align:right'>嗨, <%=session.getAttribute("empCName")%> 您好</div></td>
                    <td><input type="button"  id="logout" value="登 出" onClick="location.href='logout.jsp'"></td>
                  </tr>
                 </table>
			</div>
			<div id='menu'>
                <div align='right' class='smallwhitetext' style='padding:9px;'>
                    <a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerPersonalDetail.jsp'>查詢</a> | <a href='adminTravelList.jsp' admin="true" >系統維護</a>
                </div>
			</div>
			<div id="submenu">
				<div align="right" class="smallgraytext" style="padding:9px;">
        </div>
			</div>
			<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
			<div id="contenttext01">
				<div style="padding:0px;vertical-align:middle"><span class="titletext">行程規劃詳細資料</span>	</div><br />
				<div style="border:1px solid #333333;width:100%"></div>
				<div class="bodytext" style="padding:1px" align="justify">
          <table class="FormTable">
            
              <tr>
                  <td class='FormTDH' style='width:20%'>行程編號</td>
                  <td class='FormTDH' style='width:30%'><%=travelNo%></td>
                  <td class='FormTDH' style='width:20%'>行程名稱</td>
                  <td class='FormTDH' style='width:30%'><%=travelName%></td>
              </tr>
              <tr>
                  <td class='FormTDH' style='width:20%'>行程日期</td>
                  <td class='FormTDH' style='width:30%'><%=travelDateStart%> ~ <%=travelDateEnd%></td>
                  <td class='FormTDH' style='width:20%'>報名日期</td>
                  <td class='FormTDH' style='width:30%'><%=registerDateStart%> ~ <%=registerDateEnd%></td>
              </tr>
              <tr>
                  <td class='FormTDH' style='width:20%'>行程人數</td>
                  <td class='FormTDH' style='width:30%'><%=travelQuantity%></td>
                  <td class='FormTDH' style='width:20%'>自費金額</td>
                  <td class='FormTDH' style='width:30%'><%=selfPay%></td>
              </tr>
              <tr>
                  <td class='FormTDH' style='width:20%'>房間追加費用</td>
                  <td class='FormTDH' style='width:30%'>4人房【<%=room4Cost%>】&nbsp;3人房【<%=room3Cost%>】&nbsp;2人房【<%=room2Cost%>】</td>
                  <td class='FormTDH' style='width:20%'>房間數量</td>
                  <td class='FormTDH' style='width:30%'>4人房【<%=room4Num%>】&nbsp;3人房【<%=room3Num%>】&nbsp;2人房【<%=room2Num%>】</td>
              </tr>
              <tr>
                  <td class='FormTDH' style='width:20%'>車輛數量</td>
                  <td class='FormTDH' style='width:30%'><%=vehicleNum%></td>
                  <td class='FormTDH' style='width:20%'>餐桌數量</td>
                  <td class='FormTDH' style='width:30%'><%=tableNum%></td>
              </tr>              
              <tr>
                  <td class='FormTDH' style='width:20%'>公告</td>
                  <td class='FormTDH' style='width:30%'><a href='file/temp.doc'>101年國內旅遊公告</a><br> <a href='file/travel_operator_ 0218-2013.doc'>旅遊系統操作手冊</a></td>
                  <td class='FormTDH' style='width:20%'>行程文件</td>
                  <td class='FormTDH' style='width:30%'><a href='file/<%=travelNo%>.pdf'><%=travelName%></a></td>
              </tr>         
            
          </table>
        </div>
        <div style="color:#F00; font-size:10px"> 注意! 選人、選房、選桌、選車完畢後，須回到在此頁面按下確認，才算報名成功。可在上方功能表「查詢」選項，查看報名結果</div>
        <br />
<%
	if(isRegister.equals("1"))
	{
%>				
        	<div style='font-size:65%'>
                <input id='register' type='button' onclick='' value='選人'/>&nbsp;&nbsp;→&nbsp;&nbsp;
                <input type='button' onclick='selectRoom();' value='選房'/>&nbsp;&nbsp;→&nbsp;&nbsp;
                <input type='button' onclick='selectDesk();' value='選桌'/>&nbsp;&nbsp;→&nbsp;&nbsp;
                <input type='button' onclick='selectVehicle();' value='選車'/>&nbsp;&nbsp;&nbsp;&nbsp;<br /><br />
                <input type='button' onclick='submitFn();' value='確定'/>&nbsp;&nbsp;&nbsp;&nbsp;
                <input type='button' onclick="window.location.href='index.jsp'" value='取消'/>
        	</div><br /> 
<%                
     } //end of if(isRegister.equals("1")) 
%>
        <div style="border:1px solid #333333;width:100%"></div>
			</div>
			<div id="footer" class="smallgraytext">
     			<a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerPersonalDetail.jsp'>查詢</a> | <a href='adminTravelList.jsp' admin="true">系統維護</a>
	
			</div>
		</div>
	</div>


</form>


<!----  對話方塊                         --------------------start-->
 <div id='dialog-form' title='親屬列表' style='font-size:11px'>
  <p class='validateTips'>請選擇同行親屬</p>
  <form>
  <fieldset>
  		<input type='checkbox' style='border:none' onclick='chk_Click()' name='relativesList' id='relativesList' value='<%=empCName%>'/><%=empCName%>【員工】<br />
<%  
  if(col2== null || col2.size() == 0 )
  {
%>  
  	 	<span>無親屬資料.....</span>
<%   	
    }else
	{
		Iterator it = col2.iterator();
		HashMap hm2 = null;
		while(it.hasNext())
		{
			hm2 = (HashMap)it.next();
			String name = strUtil.getPara(hm2.get("name"));
			String relatives = strUtil.getPara(hm2.get("relatives"));
%>
			<input type='checkbox' style='border:none' onclick='chk_Click()' name='relativesList' id='relativesList' value='<%=name%>' /><%=name%>【<%=relatives%>】<br />    	
<%
		} //end of while(it.hasNext())
   } //end of if(col2== null || col2.size() == 0 )
 
%>          
 
  </fieldset>
  </form>
  </div>
<!----  對話方塊                         --------------------end-->  
</body>

<script>
	$(function() {
		
		if($(":hidden[name='isAdmin']").val() == "false")
		{
			$("[admin='true']").hide(); 	
		}
	
	
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
			if(document.forms[0].registerFlag.value=="false"){
				alert("請先選擇參加人員，謝謝。");
				return false;
			}
		}
		window.location.href="selectRoom.jsp?flag=1&travelNo=" + document.forms[0].travelNo.value + "&travelName=" + document.forms[0].travelName.value;	
	}
	function selectDesk(){
		if(document.forms[0].checkbox_selected.value==""){
			if(document.forms[0].registerFlag.value=="false"){
				alert("請先選擇參加人員，謝謝。");
				return false;			
			}
		}
		window.location.href="selectDesk.jsp?flag=1&travelNo=" + document.forms[0].travelNo.value + "&travelName=" + document.forms[0].travelName.value;	
	}
	function selectVehicle(){
		if(document.forms[0].checkbox_selected.value==""){
			if(document.forms[0].registerFlag.value=="false"){
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
</html>