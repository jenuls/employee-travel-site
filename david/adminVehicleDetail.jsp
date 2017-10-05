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
	<script>
		var setsArrayEmpNo = ["N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N"];
		var setsArrayEmpName = ["N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N"];
		var luckArray = ["N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N"];
		function ddlonChange(obj){
			var tempId = obj.id;
			var temp = tempId.substr(8,tempId.length-1);
			var tempArr = obj.value.split(";");
			setsArrayEmpNo[parseInt(temp)-1]=tempArr[0];
			setsArrayEmpName[parseInt(temp)-1]=tempArr[1];
		}
		function submitFn(sbumitType){
			if(sbumitType=="S"){
				var temp01 = "";
				var temp02 = "";
				var temp03 = "";
				for(var i=0;i<setsArrayEmpNo.length;i++){
					if(temp01==""){
						temp01 = setsArrayEmpNo[i];
						temp02 = setsArrayEmpName[i];
					}else{
						temp01 = temp01 + ";" + setsArrayEmpNo[i];
						temp02 = temp02 + ";" + setsArrayEmpName[i];
					}
				}

				for(var i=0;i<luckArray.length;i++){
					if(temp03==""){
						temp03 = luckArray[i];	
					}else{
						temp03 = temp03 + ";" + luckArray[i];
					}
				}
				document.getElementById("returnValue01").value = temp01;
				document.getElementById("returnValue02").value = temp02;
				document.getElementById("returnLuckValue").value = temp03;
			}else{
				for(var i=0;i<luckArray.length;i++){
					if(temp03==""){
						temp03 = luckArray[i];	
					}else{
						temp03 = temp03 + ";" + luckArray[i];
					}
				}
				document.getElementById("returnValue01").value = "N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N";
				document.getElementById("returnValue02").value = "N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N";
				document.getElementById("returnLuckValue").value = temp03;
			}
			document.forms[0].submit();	
		}
		
		
  	//create XMLHttpRequest Object
  	var request = null;
  	request = creatRequestObj();
  	if (request == null){
    	//無法取得XMLHttpRequest物件時發出警告
    	alert("Error creating request object!");
  	}

  	//Send data to Server
  	function sendData(vehicleDetailNo) {
  		document.getElementById("vehicleDetailNo").value = vehicleDetailNo;
  		if(parseInt(vehicleDetailNo)<10){
  			vehicleDetailNo = "0" + vehicleDetailNo;
  		}
    	var url = "checkSelect03.jsp?travelNo=" + document.getElementById("travelNo").value + "&vehicleNo=" + document.getElementById("vehicleNo").value + "&vehicleDetailNo=" + vehicleDetailNo;
    	request.open("GET", url, true);//開啟連線，選擇連線方式GET,POST
    	request.onreadystatechange = getContents;//狀態完成時所要執行的函式
    	request.send(null);//送出
  	}

  	function getContents() {
    	if (request.readyState == 4) {//完成狀態有好幾種，4代表資料傳回完成
      	var data = request.responseText;//取得傳回的資料存在變數中
      	var resultValue = data.substring(data.indexOf("<context>")+9,data.indexOf("</context>"));
      	if(resultValue=="1"){
      		if(luckArray[parseInt(document.getElementById("vehicleDetailNo").value)-1]!="Y"){
        		alert("目前有使用者選擇中，請稍後再選擇，謝謝。");     					
      		}
      	}else{
        	luckArray[parseInt(document.getElementById("vehicleDetailNo").value)-1]="Y";
      	}
    	}
  	}

		function unLockVehicleSets(){
			var obj01=document.getElementsByName("SelectedFlag");
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
				alert("請選擇欲解鎖的車輛位置，謝謝。");
				return false;
			}
			window.location.href="unLockVehicleSets.jsp?travelNo=" + document.forms[0].travelNo.value + "&travelName=" + document.forms[0].travelName.value + "&vehicleNo=" + document.forms[0].vehicleNo.value + "&temp=" + temp01;
		}
	</script>
	<title>選擇車輛 </title>
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
    String vehicleNo = request.getParameter("vehicleNo");
    ConnectToMySql connObj = new ConnectToMySql();  
    ArrayList<String> al01 = new ArrayList<String>();
    ArrayList<String> al02 = new ArrayList<String>();
    al01 = connObj.select("select employeeNumber, MemberName,isSelect from vehiclemember where travelNo='" + travelNo + "' and vehicleNo='" + vehicleNo + "'");
		al02 = connObj.select("select registration.employeeNo,registration.name from registration left join vehiclemember on (registration.employeeNo = vehiclemember.employeeNumber) and (registration.name = vehiclemember.MemberName) where(((vehiclemember.employeeNumber) is null))"); 
		ArrayList<String> adminArrList = new ArrayList<String>();
    adminArrList = connObj.select("select EmpNo from admin");
	%>
</head>
<body>
<form name="myForm" action="adminVehicleDetailAction.jsp" method="post">
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
				String flag1 = "0";
				for(int i=0;i<adminArrList.size();i++){
					if(adminArrList.get(i).equals(empNo)){
						flag1 = "1";
					}
				}
				if(flag1.equals("1")){
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
					<span class="titletext">車輛清單</span>
					<br />
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
				<div class="bodytext" style="padding:1px" align="justify">
				<div style="font-size:65%"><input type="button" onclick="unLockVehicleSets();" value="解鎖"></div>
				<table class="FormTable">
          <%       
            String temp = "";
            String temp2 = "";
            String temp3 = "";
            String [] index = {"0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"};
            String[] arr = null;
            String[] arr02 = null;
            for(int i=0;i<al01.size();i++){
              arr = al01.get(i).split(";");
              temp = arr[0].replaceAll("\\s+", "");
              temp2 = arr[1].replaceAll("\\s+", "");
              temp3 = arr[2].replaceAll("\\s+", "");
              if(i%4==0){
              	out.write("<tr>");
              }
              
              if(temp3.equals("1")){
								if(!temp.equals("NA")){
										out.write("<td class='Temp' style='width:5%;padding:3px'><input name='SelectedFlag' type='checkbox' value='" + (i+1) + "'></td>");
              	    if(i<9){
              	    	out.write("<td class='Temp' style='width:5%;padding:3px'>0" + (i+1) + "</td>");
              	    }else{
              	    	out.write("<td class='Temp' style='width:5%;padding:3px'>" + (i+1) + "</td>");
              	    }
              	    out.write("<td class='Temp' style='width:15%;padding:3px'>");
              	    out.write("<select id='nameList" + (i+1) + "' onchange='ddlonChange(this)' onmousedown=\"sendData('" + (i+1) + "')\">");
              	    out.write("<option value='NA'></option>");
              	    out.write("<option value='" + (temp) + "'>" + temp2 + "</option>");
              	    index[i] = "1";
              	    for(int j=0;j<al02.size();j++){
              	    	arr02 = al02.get(j).split(";");

              	    	if(temp2.equals(arr02[1])){
              	    			index[i] = String.valueOf(j+1);             		
              	    	}else{

              	    	}
											out.write("<option value='" + arr02[0].replaceAll("\\s+", "") + ";" + arr02[1].replaceAll("\\s+", "") + "'>" + arr02[1].replaceAll("\\s+", "") + "</option>");
              	    }               
										out.write("</select>");
              	    out.write("</td>");                	    
              	}else{
              		out.write("<td class='Temp' style='width:5%;padding:3px'><input name='SelectedFlag' type='checkbox' value='" + (i+1) + "'></td>");
              		if(i<9){
              	  	out.write("<td class='Temp' style='width:5%;padding:3px'>0" + (i+1) + "</td>");
              	  }else{
              	  	out.write("<td class='Temp' style='width:5%;padding:3px'>" + (i+1) + "</td>");
              	  }
              	  out.write("<td class='Temp' style='width:15%;padding:3px'>");
              	  out.write("<select id='nameList" + (i+1) + "' onchange='ddlonChange(this)' onmousedown=\"sendData('" + (i+1) + "')\">");
              	  out.write("<option value='NA'></option>");
              	  for(int j=0;j<al02.size();j++){
              	  	arr02 = al02.get(j).split(";");
      	      	    out.write("<option value='" + arr02[0].replaceAll("\\s+", "") + ";" + arr02[1].replaceAll("\\s+", "") + "'>" + arr02[1].replaceAll("\\s+", "") + "</option>");                         
        	 	  	  }
              	  out.write("</select>");
              	  out.write("</td>");   	      
              	}              
            	}else{
								if(!temp.equals("NA")){
										out.write("<td class='FormTDC' style='width:5%;padding:3px'><input name='SelectedFlag' type='checkbox' value='" + (i+1) + "'></td>");
              	    if(i<9){
              	    	out.write("<td class='FormTDC' style='width:5%;padding:3px'>0" + (i+1) + "</td>");
              	    }else{
              	    	out.write("<td class='FormTDC' style='width:5%;padding:3px'>" + (i+1) + "</td>");
              	    }
              	    out.write("<td class='FormTDC' style='width:15%;padding:3px'>");
              	    out.write("<select id='nameList" + (i+1) + "' onchange='ddlonChange(this)' onmousedown=\"sendData('" + (i+1) + "')\">");
              	    out.write("<option value='NA'></option>");
              	    out.write("<option value='" + (temp) + "'>" + temp2 + "</option>");
              	    index[i] = "1";
              	    for(int j=0;j<al02.size();j++){
              	    	arr02 = al02.get(j).split(";");
              	    	if(temp2.equals(arr02[1])){
              	    			index[i] = String.valueOf(j+1);             		
              	    	}
											out.write("<option value='" + arr02[0].replaceAll("\\s+", "") + ";" + arr02[1].replaceAll("\\s+", "") + "'>" + arr02[1].replaceAll("\\s+", "") + "</option>");
              	    }               
										out.write("</select>");
              	    out.write("</td>");                	    
              	}else{
              		out.write("<td class='FormTDC' style='width:5%;padding:3px'><input name='SelectedFlag' type='checkbox' value='" + (i+1) + "'></td>");
              		if(i<9){
              	  	out.write("<td class='FormTDC' style='width:5%;padding:3px'>0" + (i+1) + "</td>");
              	  }else{
              	  	out.write("<td class='FormTDC' style='width:5%;padding:3px'>" + (i+1) + "</td>");
              	  }
              	  out.write("<td class='FormTDC' style='width:15%;padding:3px'>");
              	  out.write("<select id='nameList" + (i+1) + "' onchange='ddlonChange(this)' onmousedown=\"sendData('" + (i+1) + "')\">");
              	  out.write("<option value='NA'></option>");
              	  for(int j=0;j<al02.size();j++){
              	  	arr02 = al02.get(j).split(";");
      	      	    out.write("<option value='" + arr02[0].replaceAll("\\s+", "") + ";" + arr02[1].replaceAll("\\s+", "") + "'>" + arr02[1].replaceAll("\\s+", "") + "</option>");                         
        	 	  	  }
              	  out.write("</select>");
              	  out.write("</td>");   	      
              	}            	
            	}

              if(i%4==3){
              	out.write("</tr>");
              }
            }
            out.write("</table>");
						
           	for(int i=0;i<index.length;i++){
         		out.write("<script>");
           	out.write("if(document.getElementById('nameList" + (i+1) + "')){document.getElementById('nameList" + (i+1) + "').selectedIndex=" + index[i] + ";}");
           	out.write("</script>");             	
           	}
          %>
        </table>
        </div>
        <div style="font-size:65%">
          <input type="button" onclick="submitFn('S')" value="確定"/>&nbsp;&nbsp;&nbsp;<input type="button" onclick="submitFn('C')" value="取消"/>
          <br /><br />
        </div>		
        <div style="border:1px solid #333333;width:100%"></div>
			</div>
			<div id="footer" class="smallgraytext">
				<%
					if(flag1.equals("1")){
          	out.write("<a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerPersonalDetail.jsp'>查詢</a> | <a href='adminTravelList.jsp'>系統維護</a>");
					}else{
          	out.write("<a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerPersonalDetail.jsp'>查詢</a>");				
					}
				%>
			</div>
		</div>
		<%
			out.write("<input id='empNo' name='empNo' type='text' style='display:none' value='" + empNo + "'>");
			out.write("<input id='travelNo' name='travelNo' type='text' style='display:none' value='" + travelNo + "'>");
			out.write("<input id='vehicleNo' name='vehicleNo' type='text' style='display:none' value='" + vehicleNo + "'>");
			out.write("<input id='travelName' name='travelName' type='text' style='display:none' value='" + travelName + "'>");
		%>
		<input id="vehicleDetailNo" name="vehicleDetailNo" type="text" style="display:none" value="">
		<input id="returnValue01" name="returnValue01" type="text" style="display:none" value="">
		<input id="returnValue02" name="returnValue02" type="text" style="display:none" value="">
		<input id="returnLuckValue" name="returnLuckValue" type="text" style="display:none" value="">
	</div>
</form>
</body>
</html>