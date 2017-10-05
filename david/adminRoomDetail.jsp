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
	<title>房間設定</title>
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
    ConnectToMySql connObj = new ConnectToMySql();  
    ArrayList<String> al01 = new ArrayList<String>();
    ArrayList<String> al02 = new ArrayList<String>();
    al01 = connObj.select("select employeeNumber, MemberName from roommember where travelNo='" + travelNo + "' and roomNo='" + roomNo + "' Order by roomDetailNo ASC");
    al02 = connObj.select("select registration.employeeNo,registration.name from registration left join roommember on (registration.employeeNo = roommember.employeeNumber) and (registration.name = roommember.MemberName) where(((roommember.employeeNumber) is null))"); 
    ArrayList<String> adminArrList = new ArrayList<String>();
    adminArrList = connObj.select("select EmpNo from admin");
	%>
</head>
<body>
<form name="myForm" action="adminRoomDetailAction.jsp" method="post">
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
					<span class="titletext">房間設定</span>
					<br />
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
				<div class="bodytext" style="padding:1px" align="justify">
				<table class="FormTable">
          <%       
            String temp = "";
            String temp2 = "";
            String temp3 = "";
            String[] index = null; 
            if(roomType.equals("4")){
            	String[] tempArr = {"0","0","0","0","0"};  
            	index = tempArr;          
          	}else if(roomType.equals("3")){
            	String[] tempArr = {"0","0","0","0"};
            	index = tempArr;          	
          	}else if(roomType.equals("2")){  
            	String[] tempArr = {"0","0","0"}; 
            	index = tempArr;
          	}

						String[] arr = null;
						String[] arr02 = null;
            for(int i=0;i<al01.size();i++){
              arr = al01.get(i).split(";");
              temp = arr[0].replaceAll("\\s+", "");
              temp2 = arr[1].replaceAll("\\s+", "");
              if(!temp.equals("NA")){
                  out.write("<tr>");
                  out.write("<td class='FormTDC'>0" + (i+1) + "</td>");
                  out.write("<td class='FormTDC'>");
                  out.write("<select id='nameList" + (i+1) + "' onchange='ddlonChange(this)'>");
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
                  out.write("</tr>");               
              }else{
                  out.write("<tr>");
                  out.write("<td class='FormTDC'>0" + (i+1) + "</td>");
                  out.write("<td class='FormTDC'>");
                  out.write("<select id='nameList" + (i+1) + "' onchange='ddlonChange(this)'>");
                  out.write("<option value='NA'></option>");
                  for(int j=0;j<al02.size();j++){
                  	arr02 = al02.get(j).split(";");
                    out.write("<option value='" + arr02[0].replaceAll("\\s+", "") + ";" + arr02[1].replaceAll("\\s+", "") + "'>" + arr02[1].replaceAll("\\s+", "") + "</option>");                       
                  }
                  out.write("</select>");
                  out.write("</td>");
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
			out.write("<input id='roomNo' name='roomNo' type='text' style='display:none' value='" + roomNo + "'>");
			out.write("<input id='roomType' name='roomType' type='text' style='display:none' value='" + roomType + "'>");
			out.write("<input id='travelName' name='travelName' type='text' style='display:none' value='" + travelName + "'>");
		%>
		<input id="returnValue01" name="returnValue01" type="text" style="display:none" value="">
		<input id="returnValue02" name="returnValue02" type="text" style="display:none" value="">
	</div>
</form>
	<script>
		//create XMLHttpRequest Object
  	var request = null;
  	request = creatRequestObj();
  	if (request == null){
   	 //無法取得XMLHttpRequest物件時發出警告
   	 alert("Error creating request object!");
  	}
	  function sendData(temp) {
    	var url = "checkPeople02.jsp?travelNo=" + document.getElementById("travelNo").value + "&roomNo=" + document.getElementById("roomNo").value;
    	request.open("GET", url, true);//開啟連線，選擇連線方式GET,POST
    	request.onreadystatechange = getContents;//狀態完成時所要執行的函式
    	request.send(null);//送出
  	}

  	function getContents() {
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
  	
		if(document.forms[0].roomType.value=="4"){
			var setsArrayEmpNo = ["N","N","N","N","N"];			
			var setsArrayEmpName = ["N","N","N","N","N"];
		}else if(document.forms[0].roomType.value=="3"){
			var setsArrayEmpNo = ["N","N","N","N"];			
			var setsArrayEmpName = ["N","N","N","N"];	
		}else if(document.forms[0].roomType.value=="2"){
			var setsArrayEmpNo = ["N","N","N"];				
			var setsArrayEmpName = ["N","N","N"];
		}
		function ddlonChange(obj){
			var tempId = obj.id;
			var temp = tempId.substr(tempId.length-1,tempId.length-1);
			var tempArr = obj.value.split(";");
			setsArrayEmpNo[parseInt(temp)-1]=tempArr[0];
			setsArrayEmpName[parseInt(temp)-1]=tempArr[1];
		}
		function submitFn(sbumitType){
			if(sbumitType=="S"){
				var temp01 = "";
				var temp02 = "";
				for(var i=0;i<setsArrayEmpNo.length;i++){
					if(temp01==""){
						temp01 = setsArrayEmpNo[i];
						temp02 = setsArrayEmpName[i];
					}else{
						temp01 = temp01 + ";" + setsArrayEmpNo[i];
						temp02 = temp02 + ";" + setsArrayEmpName[i];
					}
				}
				document.getElementById("returnValue01").value = temp01;
				document.getElementById("returnValue02").value = temp02;
				document.forms[0].submit();
			}else{
				if(document.forms[0].roomType.value=="4"){
					document.getElementById("returnValue01").value = "N;N;N;N;N";
					document.getElementById("returnValue02").value = "N;N;N;N;N";
				}else if(document.forms[0].roomType.value=="3"){
					document.getElementById("returnValue01").value = "N;N;N;N";
					document.getElementById("returnValue02").value = "N;N;N;N";
				}else if(document.forms[0].roomType.value=="2"){
					document.getElementById("returnValue01").value = "N;N;N";
					document.getElementById("returnValue02").value = "N;N;N";
				}
				document.forms[0].submit();
			}
		}
	</script>
</body>
</html>