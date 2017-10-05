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
		function RedirectTo(deskNo){
			window.location.href = "deskDetail.jsp?travelName=" + document.getElementById("travelName").value + "&travelNo=" + document.getElementById("travelNo").value + "&deskNo=" + deskNo;
		}
		function goToRegisterPage(){
			window.location.href="travelPlanDetail.jsp?flag=" + document.getElementById("flag").value + "&travelNo=" + document.forms[0].travelNo.value;
		}
		function returnFn(){
			window.location.href="registeredTravel.jsp";
		}
	</script>
	
	<title>選擇餐桌</title>
	<%
		if(session.getAttribute("empNo") == null){
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request,response);
			return;
		}
    String empNo = session.getAttribute("empNo").toString();
    String travelNo = request.getParameter("travelNo");
   	String flag = request.getParameter("flag");
    String travelName = new String(request.getParameter("travelName").getBytes("ISO-8859-1"),"UTF-8");
    ConnectToMySql connObj = new ConnectToMySql();  
    ArrayList<String> al01 = new ArrayList<String>();
    ArrayList<String> al02 = new ArrayList<String>();
    al01 = connObj.select("select deskNo from desk where travelNo='" + travelNo + "'");
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
					<% out.write("<span class='titletext'>" + travelName + "-餐桌清單</span>"); %>
					<br />
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
				<div class="bodytext" style="padding:1px" align="justify">
          <%
            out.write("<table style='width:50%'>");
            String temp = "";
            for(int i=0;i<al01.size();i++){
              al02 = connObj.select("select MemberName from deskmember Where travelNo='" + travelNo + "' and deskNo='" + al01.get(i) + "' Order by deskDetailNo ASC");
              out.write("<tr>");
              if(i==0){
              	out.write("<td style='width:20%'><span><a href='#' onclick=\"RedirectTo('" + al01.get(i) + "')\">" + al01.get(i) + "【素】</a></span></td>"); 
            	}else{
            		out.write("<td style='width:20%'><span><a href='#' onclick=\"RedirectTo('" + al01.get(i) + "')\">" + al01.get(i) + "</a></span></td>"); 
            	}
              temp = "";
              for(int j=0;j<al02.size();j++){
                if(temp==""){
                  temp = al02.get(j);    
                }else{
                  temp = temp + "," + al02.get(j);                 
                }
              }
              out.write("<td style='width:80%'><span>" + temp + "</span></td>");
              out.write("</tr>");
            }
            out.write("</table>");
          %>
        </div>
        <div style="font-size:65%">
        	<%
        	if(flag.equals("1")){
        		out.write("<input type='button' onclick='goToRegisterPage();' value='返回報名頁'/>");
        	}else if(flag.equals("0")){
        		out.write("<input type='button' onclick='returnFn();' value='返回'/>");
        	}
        	%>
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
	</div>
	<% out.write("<input id='travelNo' name='travelNo' type='text' style='display:none' value='" + travelNo + "'>"); %>
	<% out.write("<input id='travelName' name='travelName' type='text' style='display:none' value='" + travelName + "'>"); %>
	<% out.write("<input id='flag' name='flag' type='text' style='display:none' value='" + flag + "'>"); %>
	<input id="tableNo" type="text" style="display:none" value="">
</form>
</body>
</html>