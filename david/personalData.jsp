<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="connect.TravelBean" %>
<%@ page language="java" import="myutil.*" %>
<%
		if(session.getAttribute("empNo") == null){
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request,response);
			return;
		}
		String empNo = session.getAttribute("empNo").toString();
		TravelBean  trBean = new TravelBean();
		Collection col = trBean.getEmployeeBasicData(empNo);
		boolean isAdmin = trBean.isAdmin(empNo);
		Iterator it = col.iterator();
		String name = "";
		String idNumber = ""; //身份證字號
		String gender = "";  //性別
		String  birthday = "";
		String address = ""; 
		while(it.hasNext() )
		{
			HashMap hm = (HashMap)it.next();
			name = strUtil.getPara(hm.get("name"));	
			idNumber = strUtil.getPara(hm.get("idNumber"));	
			birthday = strUtil.getPara(hm.get("birthday"));	
			gender = strUtil.getPara(hm.get("gender"));	
			address = strUtil.getPara(hm.get("address"));	
		}
	
			
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
	<script src="js/jquery.ui.datepicker.js"></script>
  <script>
		$(function() {
			$( "#birthday" ).datepicker
			({
				changeMonth:true
			   ,changeYear: true
			
			
			});
			$( "input:button").button();
		});
		function submitFn(){
			if(document.forms[0].id.value==""){
				alert("請填寫身分證字號，謝謝。");
				return false;
			}
			if(document.forms[0].name.value==""){
				alert("請填寫姓名，謝謝。");
				return false;
			}
			if(document.forms[0].birthday.value==""){
				alert("請選擇生日，謝謝。");
				return false;
			}
			if(document.forms[0].address.value==""){
				alert("請填寫地址，謝謝。");
				return false;
			}
			document.forms[0].submit();
		}
	</script>
	<title>個人資料</title>

</head>
<body>
<form name="myForm" action="personalDataAction.jsp" method="post">
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
					<span class="titletext">個人基本資料</span>
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
			<div class="bodytext" style="padding:1px" align="justify">
          <table class="FormTable">
<%
     if( col.size() == 0 )
	 {
%> 
			 	<tr><td><a href="addPersonalData.jsp?empNo=<%=empNo%>"> 目前無個人資料請點此新增</a></td></tr>
<%
	 }else{                  
%>	  
               <tr>
                    <td class='FormTDH' style='width:20%'>工號</td><td class='FormTDH' style='width:30%'><input id='empNo' name='empNo' type='text' style='width:90%' value='<%=empNo%>' readonly></td>
                    <td class='FormTDH' style='width:20%'>身份證字號</td><td class='FormTDH' style='width:30%'><input id='id' name='id' type='text' style='width:90%' value='<%=idNumber%>'></td>
                </tr>
                <tr>
                    <td class='FormTDH' style='width:20%'>姓名</td>
                    <td class='FormTDH' style='width:30%'><input id='name' name='name' type='text' style='width:90%' value='<%=name%>'></td>
                    <td class='FormTDH' style='width:20%'>性別</td>
                    <td class='FormTDH' style='width:30%'><input id='gender01' name='gender' type='radio' <%if(gender.equals("男") ) out.print("checked"); %> value='男'>男&nbsp;&nbsp;<input id='gender02' name='gender' type='radio' value='女' <%if(gender.equals("女") ) out.print("checked"); %>>女</td>                  
                </tr>
                <tr>
                <td class='FormTDH' style='width:20%'>生日</td>
                <td class='FormTDH' style='width:80%' colspan='3'><input id='birthday' name='birthday' type='text' style='width:90%' value='<%=birthday%>' readonly></td>
                </tr>
                <tr>
                <td class='FormTDH' style='width:20%'>地址</td>
                <td class='FormTDH' style='width:80%' colspan='3'><input id='address' name='address' type='text' style='width:96.5%' value='<%=address%>'></td>
                </tr>                
<%           
     } //end of  if(col.size() > 0 ){
%>
          </table>        
        </div>
        <div style="font-size:65%">
          <input type="button" onclick="submitFn();" value="確定"/>&nbsp;&nbsp;&nbsp;<input type="button" onclick="window.location.href='index.jsp'" value="返回首頁"/>
          <br /><br />
        </div>		
        <div style="border:1px solid #333333;width:100%"></div>
			</div>
			<div id="footer" class="smallgraytext">
				<a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerPersonalDetail.jsp'>查詢</a> | <a href='adminTravelList.jsp' admin="true">系統維護</a>
				
			</div>
		</div>
	</div>
</form>
</body>
</html>


<script type="text/javascript">
$(document).ready(function()
{
	if($(":hidden[name='isAdmin']").val() == "false")
	{
		$("[admin='true']").hide(); 	
	}
}); //end of $(document).ready(function()

</script>