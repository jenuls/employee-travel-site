<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="connect.TravelAction" %>
<%@ page language="java" import="connect.TravelBean" %>
<%@ page language="java" import="myutil.strUtil" %>
<%
		if(session.getAttribute("empNo") == null){
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request,response);
			return;
		}
		String empNo = session.getAttribute("empNo").toString();
		String empCName = session.getAttribute("empCName").toString();
		String travelNo = request.getParameter("travelNo");
		String travelName = new String(request.getParameter("travelName").getBytes("ISO-8859-1"),"UTF-8");
		String roomNo = request.getParameter("roomNo");
		String roomType = roomNo.substring(0,1);
		String flag = request.getParameter("flag");
		TravelAction  tavlAction = new TravelAction();
		tavlAction.lockRoom(travelNo, roomNo);
		TravelBean  tavlBean = new TravelBean();
		Collection col = tavlBean.getMemberOfRoom(travelNo, roomNo);
		Iterator it = col.iterator();
/*	
    ConnectToMySql connObj = new ConnectToMySql();  
    ArrayList<String> al01 = new ArrayList<String>();
    ArrayList<String> al02 = new ArrayList<String>();
	ArrayList<String> al03 = new ArrayList<String>();
    connObj.update("update room set isSelect = '1' where travelNo='" + travelNo + "' and roomNo='" + roomNo + "'");
    al01 = connObj.select("select employeeNumber, MemberName from roommember where travelNo='" + travelNo + "' and roomNo='" + roomNo + "' Order by roomDetailNo ASC");
    al02 = connObj.select("select name from registration where employeeNo='" + empNo + "'");
	al03 = connObj.select("select MemberName from roommember Where travelNo='" + travelNo + "' and roomNo='" + roomNo + "' Order by roomDetailNo ASC");
    ArrayList<String> adminArrList = new ArrayList<String>();
    adminArrList = connObj.select("select EmpNo from admin");
*/	
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
	<title>房間設定 </title>
	
</head>
<body>
<form name="myForm" action="roomDetailAction.jsp" method="post">
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
        </div>
			</div>
			<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
			<div id="contenttext01">
				<div style="padding:0px;vertical-align:middle">
                	<span class="titletext"><%=travelNo%> <%=travelName%></span><br />
					<span class="titletext">房間設定-<%=roomNo%></span>
					<br />
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
				<div class="bodytext" style="padding:1px" align="justify">
					<table class="FormTable" border="1">
<%       
	HashMap hm = null;
	while(it.hasNext() )
	{
		hm = (HashMap)it.next();
		String bedNumber = strUtil.getPara( hm.get("roomDetailNo") );  //床位
		String memberNO =  strUtil.getPara( hm.get("employeeNumber") ); 
		String memberName =  strUtil.getPara( hm.get("MemberName") );
		
%>					
                          <tr>
                              <td  class="FormTDC" width="5%"><%=bedNumber%></td>
                              <td class="FormTDC" width="95%"><%=memberName%></td>
                          </tr>    
<%
	}
%>	                         
      
                     </table>

       		</div> <!-- end of <div class="bodytext" style="padding:1px" align="justify">  -->
        <div style="font-size:65%">
          <input type="button" onclick="submitFn('S')" value="確定"/>&nbsp;&nbsp;&nbsp;<input type="button" onclick="submitFn('C')" value="取消"/>
          <br /><br />
        </div>		
        <div style="border:1px solid #333333;width:100%"></div>
			</div>
			<div id="footer" class="smallgraytext">
				<a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerPersonalDetail.jsp'>查詢</a> | <a href='adminTravelList.jsp' admin="true">系統維護</a>
			</div>
		</div>
		
		
	</div>
    
<input id='empNo' name='empNo' type='text' style='display:none' value='<%=empNo%>'>
<input id='travelNo' name='travelNo' type='text' style='display:none' value='<%=travelNo%>'>
<input id='roomNo' name='roomNo' type='text' style='display:none' value='<%=roomNo%>'>
<input id='roomType' name='roomType' type='text' style='display:none' value='<%=roomType%>'>
<input id='travelName' name='travelName' type='text' style='display:none' value='<%=travelName%>'>
<input id='flag' name='flag' type='text' style='display:none' value='<%=flag%>'>
<input id="returnValue" name="returnValue" type="text" style="display:none" value="">
</form>
	
</body>
</html>

<script>
		//create XMLHttpRequest Object
$(function() 
{		
	if($(":hidden[name='isAdmin']").val() == "false")
	{
		$("[admin='true']").hide(); 	
	}
	$( "input:button").button();	
  	var request = null;
  	request = creatRequestObj();
  	if (request == null){
   	 //無法取得XMLHttpRequest物件時發出警告
   	 alert("Error creating request object!");
  	}
	
	if(document.forms[0].roomType.value=="4"){
		var setsArray = ["N","N","N","N"];			
	}else if(document.forms[0].roomType.value=="3"){
		var setsArray = ["N","N","N"];				
	}else if(document.forms[0].roomType.value=="2"){
		var setsArray = ["N","N"];				
	}
	
});	
	
  function sendData(temp) 
  {
	var url = "checkPeople02.jsp?travelNo=" + document.getElementById("travelNo").value + "&roomNo=" + document.getElementById("roomNo").value;
	request.open("GET", url, true);//開啟連線，選擇連線方式GET,POST
	request.onreadystatechange = getContents;//狀態完成時所要執行的函式
	request.send(null);//送出
	}

function getContents() 
{
	if (request.readyState == 4) 
	{//完成狀態有好幾種，4代表資料傳回完成
		var data = request.responseText;//取得傳回的資料存在變數中
		var resultValue = data.substring(data.indexOf("<context>")+9,data.indexOf("</context>"));
		if(resultValue=="0")
		{
			alert("您尚未選擇旅遊人員，謝謝。");
			return false;
		}else if(resultValue=="1")
		{
			alert("房間位置大於報名人數，請將多選房間位置清除，謝謝。");
			return false;      	
		}else if(resultValue=="2")
		{
			document.forms[0].submit();
		}else if(resultValue=="3")
		{
			alert("人員尚未選擇完畢，請確認人員全部皆有房間位置，謝謝。");
			return false;
		}
	}
}

	
	
	/*
	function ddlonChange(obj)
	{
		var tempId = obj.id;
		var temp = tempId.substr(tempId.length-1,tempId.length-1);
		setsArray[parseInt(temp)-1]=obj.value;
	}
	
	*/
	function submitFn(sbumitType)
	{
		if(sbumitType=="S")
		{
			alert("房間必須全部住滿方可成行，謝謝。");
			var temp = "";
			for(var i=0;i<setsArray.length;i++){
				if(temp==""){
					temp = setsArray[i];	
				}else{
					temp = temp + ";" + setsArray[i];
				}
			}
			document.getElementById("returnValue").value = temp;
			//sendData(temp);
			document.forms[0].submit();
		
		
		}else
		{
			if(document.forms[0].roomType.value=="4"){
				document.getElementById("returnValue").value = "N;N;N;N;N";
			}else if(document.forms[0].roomType.value=="3"){
				document.getElementById("returnValue").value = "N;N;N;N";
			}else if(document.forms[0].roomType.value=="2"){
				document.getElementById("returnValue").value = "N;N;N";
			}
			document.forms[0].submit();
		}
	}
	</script>