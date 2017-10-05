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
	<script>	
	function selectRoom(travelNo,travelName){
		window.location.href="selectRoom.jsp?flag=0&travelNo=" + travelNo + "&travelName=" + travelName;	
	}
	function selectDesk(travelNo,travelName){
		window.location.href="selectDesk.jsp?flag=0&travelNo=" + travelNo + "&travelName=" + travelName;	
	}
	function selectVehicle(travelNo,travelName){
		window.location.href="selectVehicle.jsp?flag=0&travelNo=" + travelNo + "&travelName=" + travelName;			
	}
	</script>
	<title>已報名行程</title>
	<%
		if(session.getAttribute("empNo") == null){
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request,response);
			return;
		}
    String empNo = session.getAttribute("empNo").toString();
    ConnectToMySql connObj = new ConnectToMySql();  
    ArrayList<String> al01 = new ArrayList<String>();
    ArrayList<String> al02 = new ArrayList<String>();
    al01 = connObj.select("select DISTINCT travelNo from registration where employeeNo='" + empNo + "'");
    ArrayList<String> adminArrList = new ArrayList<String>();
    adminArrList = connObj.select("select EmpNo from admin");
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
					<span class="titletext">已報名行程</span>
				</div>
				<div class="bodytext" style="padding:12px;" align="justify">
				  <%
				    if(al01.size()!=0){
              for(int i=0;i<al01.size();i++){
                al02 = connObj.select("select travelName from travel where travelNo='" + al01.get(i) + "'");
                out.write("<div><span class='FontStyle01'>" + al02.get(0) + "</sapn><span class='FontStyle02'><br /><a href='#' onclick=\"selectRoom('" + al01.get(i) + "','" + al02.get(0) + "')\">房間</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' onclick=\"selectDesk('" + al01.get(i) + "','" + al02.get(0) + "')\">飯桌</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' onclick=\"selectVehicle('" + al01.get(i) + "','" + al02.get(0) + "')\">車輛</a></span></div>");              
              }
            }else{
              out.write("<tr><td>您並無報名任何一個梯次</td></tr>");
            }
          %>
				</div>
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
	</div>
</body>
</html>