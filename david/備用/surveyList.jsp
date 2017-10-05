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
	</script>
	<title>報名人員清單</title>
	<%
		if(session.getAttribute("empNo") == null){
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request,response);
			return;
		}
    String empNo = session.getAttribute("empNo").toString();
    ConnectToMySql connObj = new ConnectToMySql();  
    ArrayList<String> al01 = new ArrayList<String>();
    al01 = connObj.select("select * from personaldata where employeeNo='" + empNo + "'");
    String[] arr1 = al01.get(0).split(";");
    ArrayList<String> al02 = new ArrayList<String>();
    al01 = connObj.select("select * from relativesdata where employeeNumber='" + empNo + "'");
    String[] arr2 = al02.get(0).split(";");        
    String[] dataArr = new String[6];
    ArrayList<String> adminArrList = new ArrayList<String>();
    adminArrList = connObj.select("select EmpNo from admin");
	%>
</head>
<body>
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
          out.write("<a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registeredTravel.jsp'>位置選定</a> | <a href='#'>查詢</a> | <a href='adminTravelList.jsp'>系統維護</a>");
					out.write("</div>");
					out.write("</div>");	
				}else{
					out.write("<div id='menu'>");
					out.write("<div align='right' class='smallwhitetext' style='padding:9px;'>");
          out.write("<a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registeredTravel.jsp'>位置選定</a> | <a href='#'>查詢</a>");
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
					<span class="titletext">報名人員清單</span>
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
			<div class="bodytext" style="padding:1px" align="justify">
          <table class="FormTable">
            <%
              if(al01.size()!=0){
                out.write("<tr>");
                out.write("<td class='FormTDH' style='width:25%;background:#BBBBBB;color:#FFFFFF;padding:3px'>行程代碼</td>");
                out.write("<td class='FormTDH' style='width:25%;background:#BBBBBB;color:#FFFFFF;padding:3px'>行程名稱</td>");
                out.write("<td class='FormTDH' style='width:25%;background:#BBBBBB;color:#FFFFFF;padding:3px'>開始日期</td>");
                out.write("<td class='FormTDH' style='width:25%;background:#BBBBBB;color:#FFFFFF;padding:3px'>結束日期</td>");
                out.write("</tr>");
                for(int i=0;i<al01.size();i++){
                  String[] arr = al01.get(i).split(";");
                  out.write("<tr>");
                  out.write("<td class='FormTDH' style='width:25%;padding:3px'><a href='editTravelPlan.jsp?travelNo=" + arr[0] + "'>" + arr[0] + "</td>");
                  out.write("<td class='FormTDH' style='width:25%;padding:3px'>" + arr[1] + "</td>");
                  out.write("<td class='FormTDH' style='width:25%;padding:3px'>" + arr[2] + "</td>");
                  out.write("<td class='FormTDH' style='width:25%;padding:3px'>" + arr[3] + "</td>");
                  out.write("</tr>");              
                }               
              }else{
                  out.write("<tr><td>目前無行程資料資料........<input id='add' type='button' onclick=\"window.location.href='addRelativesData.jsp'\" value='新增'/></td></tr>");
              }       
            %>
          </table>        
        </div>	
        <div style="border:1px solid #333333;width:100%"></div>
			</div>
			<div id="footer" class="smallgraytext">
				<a href="index.jsp">首頁</a> | <a href="personalData.jsp">基本資料維護</a> | <a href="registeredTravel.jsp">位置選定</a> | <a href="#">查詢</a> | <a href="#">系統維護</a>
			</div>
		</div>
	</div>
</form>
</body>
</html>