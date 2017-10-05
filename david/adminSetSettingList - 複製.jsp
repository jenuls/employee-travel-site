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
	%>
</head>
<body>
<form name="myForm" action="deleteSets.jsp" method="post">
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
					<% out.write("<span class='titletext'>" + travelName + "-登錄清單</span>"); %>
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
			<div class="bodytext" style="padding:1px" align="justify">
					<br />
					<%
						if(al01.size()==0){
							out.write("<div class='FontStyle02'>房間清單&nbsp;&nbsp;<span style='font-size:65%'><input type='button' onclick='addRoom();' value='新增房間'></span></div>");
						}else{
							out.write("<div class='FontStyle02'>房間清單&nbsp;&nbsp;<span style='font-size:65%'><input type='button' onclick='addRoom();' value='新增房間'><input type='button' onclick='unLockRoom();' value='解鎖'></span></div>");
						}
						
					%>
					
          <table class="FormTable">
            <%
            	String[] arr = null;
              if(al01.size()!=0){
                out.write("<tr>");
                out.write("<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'></td>");
                out.write("<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>房間號碼</td>");
                out.write("<td class='FormTDH' style='width:70%;background:#BBBBBB;color:#FFFFFF;padding:3px'>選位人員</td>");
                out.write("<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>鎖定</td>");
                out.write("</tr>");
                for(int i=0;i<al01.size();i++){
									arr = al01.get(i).split(";");
									if(arr[1].equals("1")){
                 	 	out.write("<tr>");
                  	out.write("<td class='Temp' style='width:10%;padding:3px'><input name='roomChb' type='checkbox' value='" + arr[0] + "'></td>");
                  	out.write("<td class='Temp' style='width:10%;padding:3px'><span><a href='#' onclick=\"roomDetail('" + arr[0] + "')\">" + arr[0] + "</a></span></td>");
										al04 = connObj.select("select MemberName from roommember Where travelNo='" + travelNo + "' and roomNo='" + arr[0] + "' Order by roomDetailNo ASC");
										temp01 = "";
										for(int j=0;j<al04.size();j++){
                  		if(temp01==""){
                  			temp01 = al04.get(j);    
                			}else{
                  			temp01 = temp01 + "," + al04.get(j);                 
                			}
                  	}
                  	out.write("<td class='Temp' style='width:70%'><span>" + temp01 + "</span></td>");
                  	out.write("<td class='Temp' style='width:10%;padding:3px'>是</td>");
                  	out.write("</tr>");
									}else{
                 	 	out.write("<tr>");
                  	out.write("<td class='FormTDH' style='width:10%;padding:3px'><input name='roomChb' type='checkbox' value='" + arr[0] + "'></td>");
                  	out.write("<td class='FormTDH' style='width:10%;padding:3px'><span><a href='#' onclick=\"roomDetail('" + arr[0] + "')\">" + arr[0] + "</a></span></td>");
										al04 = connObj.select("select MemberName from roommember Where travelNo='" + travelNo + "' and roomNo='" + arr[0] + "' Order by roomDetailNo ASC");
										temp01 = "";
										for(int j=0;j<al04.size();j++){
                  		if(temp01==""){
                  			temp01 = al04.get(j);    
                			}else{
                  			temp01 = temp01 + "," + al04.get(j);                 
                			}
                  	}
                  	out.write("<td class='FormTDH' style='width:70%'><span>" + temp01 + "</span></td>");
                  	out.write("<td class='FormTDH' style='width:10%;padding:3px'>否</td>");
                  	out.write("</tr>");									
									}
                }               
              }else{
                  out.write("<tr><td>目前房間資料........</td></tr>");
              }       
            %>
          </table>        
          <br />
					<div class="FontStyle02">餐桌清單&nbsp;&nbsp;<span style="font-size:65%"><input type="button" onclick="addDesk();" value="新增餐桌"></span></div>
          <table class="FormTable">
            <%
              if(al02.size()!=0){
                out.write("<tr>");
                out.write("<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'></td>");
                out.write("<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>餐桌號碼</td>");
                out.write("<td class='FormTDH' style='width:80%;background:#BBBBBB;color:#FFFFFF;padding:3px'>選位人員</td>");
                out.write("</tr>");
                for(int i=0;i<al02.size();i++){
                  out.write("<tr>");
                  out.write("<td class='FormTDH' style='width:10%;padding:3px'><input name='deskChb' type='checkbox' value='" + al02.get(i) + "'></td>");
                  //out.write("<td class='FormTDH' style='width:10%;padding:3px'>" + al02.get(i) + "</td>");
                  
                	if(i==0){
              			out.write("<td class='FormTDH' style='width:10%;padding:3px'><span><a href='#' onclick=\"deskDetail('" + al02.get(i) + "')\">" + al02.get(i) + "【素】</a></span></td>");
            			}else{
            				out.write("<td class='FormTDH' style='width:10%;padding:3px'><span><a href='#' onclick=\"deskDetail('" + al02.get(i) + "')\">" + al02.get(i) + "</a></span></td>");
            			}
                  al05 = connObj.select("select MemberName from deskmember Where travelNo='" + travelNo + "' and deskNo='" + al02.get(i) + "' Order by deskDetailNo ASC");
                  temp02 = "";
                  for(int j=0;j<al05.size();j++){
                  	if(temp02==""){
                  		temp02 = al05.get(j);    
                		}else{
                  		temp02 = temp02 + "," + al05.get(j);                 
                		}
                  }
                  out.write("<td style='width:80%'><span>" + temp02 + "</span></td>");
                  out.write("</tr>");
                }               
              }else{
                  out.write("<tr><td>目前餐桌資料........</td></tr>");
              }       
            %>
          </table>
          <br />
					<div class="FontStyle02">車輛清單&nbsp;&nbsp;<span style="font-size:65%"><input type="button" onclick="addVehicle();" value="新增車輛"></span></div>
          <table class="FormTable">
            <%
              if(al03.size()!=0){
                out.write("<tr>");
                out.write("<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'></td>");
                out.write("<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>車輛號碼</td>");
                out.write("<td class='FormTDH' style='width:80%;background:#BBBBBB;color:#FFFFFF;padding:3px'>選位人員</td>");
                out.write("</tr>");
                for(int i=0;i<al03.size();i++){
                  out.write("<tr>");
                  out.write("<td class='FormTDH' style='width:10%;padding:3px'><input name='vehicleChb' type='checkbox' value='" + al03.get(i) + "'></td>");
                  //out.write("<td class='FormTDH' style='width:10%;padding:3px'>" + al03.get(i) + "</td>");
                  out.write("<td class='FormTDH' style='width:10%;padding:3px'><span><a href='#' onclick=\"vehicleDetail('" + al03.get(i) + "')\">" + al03.get(i) + "</a></span></td>");
                  al06 = connObj.select("select MemberName from vehiclemember Where travelNo='" + travelNo + "' and vehicleNo='" + al03.get(i) + "' Order by vehicleDetailNo ASC");
									temp03 = "";
									for(int j=0;j<al06.size();j++){
                  	if(temp03==""){
                  		temp03 = al06.get(j);    
                		}else{
                  		temp03 = temp03 + "," + al06.get(j);                 
                		}
                  }
                  out.write("<td style='width:80%'><span>" + temp03 + "</span></td>");
                  out.write("</tr>");
                }               
              }else{
                  out.write("<tr><td>目前車輛資料........</td></tr>");
              }       
            %>
          </table>
          <br />
        </div>
        <div style="font-size:65%">
          <input type="button" onclick="deleteSets()" value="刪除"/>&nbsp;&nbsp;&nbsp;<input type="button" onclick="returnFn()" value="返回"/>
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
		<input id="roomContext" name="roomContext" type="text" style="display:none" value="">
		<input id="deskContext" name="deskContext" type="text" style="display:none" value="">
		<input id="vehicleContext" name="vehicleContext" type="text" style="display:none" value="">
	</div>
</form>
</body>
</html>