<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.sql.ResultSet" %>
<%@ page language="java" import="connect.TravelBean" %>
<%@ page language="java" import="myutil.strUtil" %>
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
	
	<title>行程清單</title>
	<%
		if(session.getAttribute("empNo") == null){
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request,response);
			return;
		}
    String empNo = session.getAttribute("empNo").toString();
    String travelNo = request.getParameter("travelNo");
    String travelName = new String(request.getParameter("travelName").getBytes("ISO-8859-1"),"UTF-8");
	TravelBean  trBean = new TravelBean();
	Collection roomCol = trBean.getRoomList(travelNo);
	Collection DeskCol = trBean.getDeskNO(travelNo);
	Collection BusCol = trBean.getBusList(travelNo);
	boolean isAdmin = trBean.isAdmin(empNo);
	
	/*
    String temp01="";
    String temp02="";
    String temp03="";
    ConnectToMySql connObj = new ConnectToMySql();
    ArrayList<String> al01 = new ArrayList<String>();
    ArrayList<String> al02 = new ArrayList<String>();
    ArrayList<String> al03 = new ArrayList<String>();
    ArrayList<String> al04 = new ArrayList<String>();
    ArrayList<String> al05 = new ArrayList<String>();
    ArrayList<String> al06 = new ArrayList<String>();
    al01 = connObj.select("select roomNo,isSelect from room where travelNo='" + travelNo + "' order by roomNo asc");
    al02 = connObj.select("select deskNo from desk where travelNo='" + travelNo + "' order by deskNo asc");
    al03 = connObj.select("select vehicleNo from vehicle where travelNo='" + travelNo + "' order by vehicleNo asc");
    ArrayList<String> adminArrList = new ArrayList<String>();
    adminArrList = connObj.select("select EmpNo from admin");
	*/
	%>
</head>
<body>
<form name="myForm" action="deleteSets.jsp" method="post">
<input type="hidden" name="isAdmin" value="<%=isAdmin%>" > <!--是否是管理者 -->
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
					<span class='titletext'><%=travelName%>-登錄清單</span>
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
			<div class="bodytext" style="padding:1px" align="justify">
					<br />
					<div class='FontStyle02'>房間清單&nbsp;&nbsp;<span style='font-size:65%'><input type='button' onclick='addRoom();' value='新增房間'><input id="unlock_button" type='button' onclick='unLockRoom();' value='解鎖'></span></div>
			
					
					
          <table class="FormTable">
          	<tr>
                <td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'></td>
                <td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>房間號碼</td>
                <td class='FormTDH' style='width:70%;background:#BBBBBB;color:#FFFFFF;padding:3px'>選位人員</td>
                <td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>鎖定</td>
            </tr>
<%
	
	if(roomCol.size()==0)
	{
%>		
					
	  <tr><td>目前無資料...</td></tr>	
      			
<%				
	}else 
	{
		Iterator it = roomCol.iterator();
		while(it.hasNext() )
		{
		
			HashMap hm = (HashMap)it.next();
			String roomNO = strUtil.getPara(hm.get("roomNo") );
			String isSelect = strUtil.getPara( hm.get("isSelect"));
			if(isSelect.equals("1") )
				isSelect = "是";
			else
				isSelect = "否";
			
			String memberOfRoom = trBean.getMemberNameOfRoom2String(travelNo, roomNO);
				
					
%>							
                     <tr name="room_data_row">
                        <td class='FormTDH' style='width:10%;padding:3px'><input name='roomChb' type='checkbox' value='<%=roomNO%>'></td>
                        <td class='FormTDH' style='width:10%;padding:3px'><span><a href='#' onclick="roomDetail('<%=roomNO%>')"> <%=roomNO%></a></span></td>
                        <td class='FormTDH' style='width:70%'><span><%=memberOfRoom%></span></td>
                        <td class='FormTDH'  name="LockFlag" style='width:10%;padding:3px'><%=isSelect%></td>
                      </tr>
<%
		} //end of  while(it.hasNext() )
		
    } //end of if(roomCol.size()!=0)       
 	  			
%>
      </table><br />        
      
<!------------------------------------------------------------------------------------------------------------------------------------------------------>      
      <div class="FontStyle02">餐桌清單&nbsp;&nbsp;<span style="font-size:65%"><input type="button" onclick="addDesk();" value="新增餐桌"></span></div>
      		<table class="FormTable">
                 <tr>
                        <td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'></td>
                        <td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>餐桌號碼</td>
                        <td class='FormTDH' style='width:80%;background:#BBBBBB;color:#FFFFFF;padding:3px'>選位人員</td>
                 </tr>
<%
         if(DeskCol.size() == 0 )
		 {
%>
		 		  <tr><td>目前無資料...</td></tr>
<%
		 }else
		 {
			 Iterator it = DeskCol.iterator();
  			 while(it.hasNext() )
			 {
			   HashMap hm = (HashMap)it.next();
			   String  desk_no = strUtil.getPara(hm.get("deskNo") ); 
			   String  member_name = trBean.getMemberNameOfDesk2String(travelNo,desk_no);   
		
%>					
                   <tr>
                        <td class='FormTDH' style='width:10%;padding:3px'><input name='deskChb' type='checkbox' value='<%=desk_no%>'></td>
          				<td class='FormTDH' style='width:10%;padding:3px'><span><a href='#' onclick="deskDetail('<%=desk_no%>')"><%=desk_no%><%if(desk_no.equals("01")) out.print("【素】");%></a></span></td>
		                <td style='width:80%'><span><%=member_name%></span></td>
                  </tr>
<%                  
                } //end of   while(it.hasNext() )              
	     } //end of if(DeskCol.size() > 0 )      
%>
          </table> <br />
<!------------------------------------------------------------------------------------------------------------------------------------------------------>          
         
			<div class="FontStyle02">車輛清單&nbsp;&nbsp;<span style="font-size:65%"><input type="button" onclick="addVehicle();" value="新增車輛"></span></div>
          <table class="FormTable">
           <tr>
                <td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'></td>
                <td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>車輛號碼</td>
                <td class='FormTDH' style='width:80%;background:#BBBBBB;color:#FFFFFF;padding:3px'>選位人員</td>
           </tr>
<%

         if(BusCol.size() == 0 )
		 {
%>
		 		  <tr><td>目前無資料...</td></tr>
<%
		 }else
		 {				  
                Iterator it = BusCol.iterator();
				while(it.hasNext() )
				{
               		HashMap hm = (HashMap)it.next();
				   String  bus_no = strUtil.getPara(hm.get("vehicleNo") ); 
				   String  member_name = trBean.getBusMemberNameList2String(travelNo,bus_no);   
               		
%>					
                  <tr>
                      <td class='FormTDH' style='width:10%;padding:3px'><input name='vehicleChb' type='checkbox' value='<%=bus_no%>'></td>
                      <td class='FormTDH' style='width:10%;padding:3px'><span><a href='#' onclick="vehicleDetail('<%=bus_no%>')"><%=bus_no%></a></span></td>
                      <td style='width:80%'><span><%=member_name%></span></td>
                  </tr>
<%				  
                }               
           }       
%>
          </table>
          <br />
        </div>
<!------------------------------------------------------------------------------------------------------------------------------------------------------>        
        <div style="font-size:65%">
          <input type="button" onclick="deleteSets()" value="刪除"/>&nbsp;&nbsp;&nbsp;<input type="button" onclick="returnFn()" value="返回"/>
          <br /><br />
        </div>			
        <div style="border:1px solid #333333;width:100%"></div>
			</div>
			<div id="footer" class="smallgraytext">
             	<a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerPersonalDetail.jsp'>查詢</a> | <a href='adminTravelList.jsp' admin="true" >系統維護</a>

			</div>
		</div>
		<input id='travelNo' name='travelNo' type='text' style='display:none' value='<%=travelNo%>'>
		<input id='travelName' name='travelName' type='text' style='display:none' value='<%=travelName%>'>
		<input id="roomContext" name="roomContext" type="text" style="display:none" value="">
		<input id="deskContext" name="deskContext" type="text" style="display:none" value="">
		<input id="vehicleContext" name="vehicleContext" type="text" style="display:none" value="">
	</div>
</form>
</body>
</html>


<script>
$(function() {
	
	if($(":hidden[name='isAdmin']").val() == "false")
	{
		$("[admin='true']").hide(); 	
	}
	
	$("tr[name='room_data_row']").each(function(n)
	{
		 var lock_flag = $(this).find("td[name='LockFlag']").text();
		 if(lock_flag == '是')
		 {
			 $(this).find("td").removeClass("FormTDH");
			 $(this).find("td").addClass("Temp");	
		 }
	});
	var obj01 = document.getElementsByName("roomChb");
	if(obj01.length <= 0 )
	{
		$(":button#unlock_button").hide();
	}
	
	$( "input:button").button();
	
	
});

function deleteSets(){
	var obj01=document.getElementsByName("roomChb");
	var obj02=document.getElementsByName("deskChb");
	var obj03=document.getElementsByName("vehicleChb");
	var temp01="";
	var temp02="";
	var temp03="";
	
	for(var i=0;i<obj01.length;i++){
		if(obj01[i].checked){
			if(temp01==""){
				temp01 = obj01[i].value;
			}else{
				temp01 = temp01 + ";" + obj01[i].value;
			}
		}
	}
	
	for(var i=0;i<obj02.length;i++){
		if(obj02[i].checked){
			if(temp02==""){
				temp02 = obj02[i].value;
			}else{
				temp02 = temp02 + ";" + obj02[i].value;
			}
		}			
	}
	
	for(var i=0;i<obj03.length;i++){
		if(obj03[i].checked){
			if(temp03==""){
				temp03 = obj03[i].value;
			}else{
				temp03 = temp03 + ";" + obj03[i].value;
			}
		}			
	}
	
	document.getElementById("roomContext").value = temp01;
	document.getElementById("deskContext").value = temp02;
	document.getElementById("vehicleContext").value = temp03; 
	if(temp01=="" && temp02=="" && temp03==""){
		alert("請選擇欲刪除的資料，謝謝");
		return false;
	}
	document.forms[0].submit();
}

function addRoom(){
	window.location.href="addRoom.jsp?travelNo=" + document.forms[0].travelNo.value + "&travelName=" + document.forms[0].travelName.value;
}
function addDesk(){
	window.location.href="addDesk.jsp?travelNo=" + document.forms[0].travelNo.value + "&travelName=" + document.forms[0].travelName.value;
}
function addVehicle(){
	window.location.href="addVehicle.jsp?travelNo=" + document.forms[0].travelNo.value + "&travelName=" + document.forms[0].travelName.value;
}
function returnFn(){
	window.location.href="adminTravelList.jsp?travelNo=" + document.forms[0].travelNo.value + "&travelName=" + document.forms[0].travelName.value;
}
function roomDetail(roomNo){
	window.location.href="adminRoomDetail.jsp?travelNo=" + document.forms[0].travelNo.value + "&travelName=" + document.forms[0].travelName.value + "&roomNo=" + roomNo;
}
function deskDetail(deskNo){
	window.location.href="adminDeskDetail.jsp?travelNo=" + document.forms[0].travelNo.value + "&travelName=" + document.forms[0].travelName.value + "&deskNo=" + deskNo;
}
function vehicleDetail(vehicleNo){
	window.location.href="adminVehicleDetail.jsp?travelNo=" + document.forms[0].travelNo.value + "&travelName=" + document.forms[0].travelName.value + "&vehicleNo=" + vehicleNo;
}
function unLockRoom(){
	var obj01=document.getElementsByName("roomChb");
	var temp01="";
	
	
	for(var i=0;i<obj01.length;i++){
		if(obj01[i].checked){
			if(temp01==""){
				temp01 = obj01[i].value;
			}else{
				temp01 = temp01 + ";" + obj01[i].value;
			}
		}
	}
	if(temp01==""){
		alert("請選擇欲解鎖的房間，謝謝。");
		return false;	
	}
	document.getElementById("roomContext").value = temp01;
	window.location.href="unLockRoom.jsp?travelNo=" + document.forms[0].travelNo.value + "&travelName=" + document.forms[0].travelName.value + "&temp=" + temp01;
}	

</script>