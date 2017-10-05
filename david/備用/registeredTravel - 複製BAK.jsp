<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.sql.ResultSet" %>
<%@ page language="java" import="connect.ConnectToMySql" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="author" content="Wink Hosting (www.winkhosting.com)" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" href="css/style.css" type="text/css" />
	<title>已報名行程</title>
	<%
    String empNo = session.getAttribute("empNo").toString();
    ConnectToMySql connObj = new ConnectToMySql();  
    ArrayList<String> al01 = new ArrayList<String>();
    ArrayList<String> al02 = new ArrayList<String>();
    al01 = connObj.select("select DISTINCT travelNo from registration where employeeNo='" + empNo + "'");
	%>
</head>
<body>
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
					<span class="titletext">已報名行程</span>
				</div>
				<div class="bodytext" style="padding:12px;" align="justify">
				  <%
				    if(al01.size()!=0){
              for(int i=0;i<al01.size();i++){
                al02 = connObj.select("select travelName, room4Num, room3Num, room2Num, tableNum, vehicleNum from travel where travelNo='" + al01.get(i) + "'");
                String[] arr = al02.get(i).split(";");
                out.write("<div><span class='FontStyle01'>" + arr[0] + "<span class='FontStyle02'><br /><span >房間：4人房【" + arr[1] + "】<a href='#' onclick=\"window.location.href='selectRoom.jsp?roomType=4&travelNo=" + al01.get(i) + "&travelName=" + arr[0] + "'\">選位</a>&nbsp;,3人房【" + arr[2] + "】<a href='#' onclick=\"window.location.href='selectRoom.jsp?roomType=3&travelNo=" + al01.get(i) + "&travelName=" + arr[0] + "'\">選位</a>&nbsp;,2人房【" + arr[3] + "】<a href='#' onclick=\"window.location.href='selectRoom.jsp?roomType=2&travelNo=" + al01.get(i) + "&travelName=" + arr[0] + "'\">選位</a></span><br /><span>飯桌：" + arr[4] + "&nbsp;<a href='#' onclick=\"window.location.href='selectDesk.jsp?travelNo=" + al01.get(i) + "&travelName=" + arr[0] + "'\">選位</a></span><br /><span>車輛：" + arr[5] + "&nbsp;<a href='#' onclick=\"window.location.href='selectVehicle.jsp?travelNo=" + al01.get(i) + "&travelName=" + arr[0] + "'\">選位</a></span></div>");              
              }
            }else{
              out.write("<tr><td>您並無報名任何一個梯次</td></tr>");
            }
          %>
				</div>
			</div>
			<div id="footer" class="smallgraytext">
				<a href="index.jsp">首頁</a> | <a href="personalData.jsp">基本資料維護</a> | <a href="registeredTravel.jsp">位置選定</a> | <a href="#">查詢</a> | <a href="#">系統維護</a>
			</div>
		</div>
	</div>
</body>
</html>