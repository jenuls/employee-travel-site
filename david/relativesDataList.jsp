<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="myutil.strUtil" %>
<%@ page language="java" import="connect.TravelBean" %>
<%@ page language="java" import="myutil.*" %>
<%
		if(session.getAttribute("empNo") == null){
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request,response);
			return;
		}
	strUtil util = new strUtil();
    String empNo = session.getAttribute("empNo").toString();
	TravelBean  trBean = new TravelBean();
	Collection col = trBean.getRelativesdata(empNo);

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
	
	<title>親屬資料</title>

</head>
<body>
<form name="myForm" action="deleteRelatives.jsp" method="post">
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
          <a href="personalData.jsp">個人資料</a> | <a href="relativesDataList.jsp">親屬資料</a>
        </div>
			</div>
			<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
			<div id="contenttext01">
				<div style="padding:0px;vertical-align:middle">
					<span class="titletext">親屬資料</span>
				</div>
                <div style="font-size:14px; color:#F00" align="left">說明: 員工若有多位直系親屬參加。由於福委會只補助一位直系親屬免費，請將希望免費的直系親屬設為直系，其他直系親屬均設為親友。如此系統方能正確算出所需繳交的旅費。</div>
				<div style="border:1px solid #333333;width:100%"></div>
			<div class="bodytext" style="padding:1px" align="justify">
				<div style="font-size:85%"><input type="button" onclick="addP();" value="新增"><input type="button" onclick="deleteP();" value="刪除"></div>
          <table class="FormTable">
<%
            
	  if(col.size() ==0)
	  {
%>				 
				 <tr><td>目前無親屬資料........</td></tr>
<%
      }else{
%>                 
                <tr>
					<td class='FormTDH' style='width:5%'></td>
					<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>關係</td>
					<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>身份證字號</td>
					<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>姓名</td>
					<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>性別</td>
					<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>生日</td>
					<td class='FormTDH' style='width:35%;background:#BBBBBB;color:#FFFFFF;padding:3px'>地址</td>
                </tr>
<%                
		  Iterator it = col.iterator();
		  while(it.hasNext() )
		  {
				HashMap hm = (HashMap) it.next();
					
%>				  
                  <tr>
					  <td class='FormTDH' style='width:5%;padding:3px'><input name='peopleChb' type='checkbox' value='" + util.getPara(arr[1]) + "'></td>
					  <td class='FormTDH' style='width:10%;padding:3px'><%=util.getPara(hm.get("relatives"))%></td>
					  <td class='FormTDH' style='width:10%;padding:3px'><%=util.getPara(hm.get("idNumber"))%></td>
					  <td class='FormTDH' style='width:10%;padding:3px'><a href='relativesData.jsp?&name=<%=util.getPara(hm.get("name"))%>'><%=util.getPara(hm.get("name"))%></a></td>
					  <td class='FormTDH' style='width:10%;padding:3px'><%=util.getPara(hm.get("gender"))%></td>
					  <td class='FormTDH' style='width:10%;padding:3px'><%=util.getPara(hm.get("birthday"))%></td>
					  <td class='FormTDH' style='width:35%;padding:3px'><%=util.getPara(hm.get("address"))%></td>
                  </tr>
<%                                
           }   //end of   while(it.hasNext() )             
      }  //end of  if(col.size() ==0)      
%>
          </table>        
        </div>	
        <div style="border:1px solid #333333;width:100%"></div>
			</div>
			<div id="footer" class="smallgraytext">
				<a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerPersonalDetail.jsp'>查詢</a> | <a href='adminTravelList.jsp' admin="true">系統維護</a>
				
			</div>
		</div>
		<input type="text" id="tempDeleteList" name="tempDeleteList" style="display:none" value="">
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
	$( "input:button").button();
});

function deleteP(){
	var obj=document.getElementsByName("peopleChb");
	var temp="";
	for(var i=0;i<obj.length;i++){
		if(obj[i].checked){
			if(temp==""){
				temp = obj[i].value;
			}else{
				temp = temp + ";" + obj[i].value;				
			}
		}
	}

	document.getElementById("tempDeleteList").value = temp;
	document.forms[0].submit();
}
function addP(){
	window.location.href="addRelativesData.jsp";
}
	</script>