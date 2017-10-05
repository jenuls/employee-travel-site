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
  
	String loginUser = session.getAttribute("empNo").toString();
	TravelBean  trBean = new TravelBean();
	Collection col = trBean.getJoinDetail(); //取得所有人員報名資料
	boolean isAdmin = trBean.isAdmin(loginUser);
	

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
	<title>行程清單</title>

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
				    <div style='text-align:right'>嗨, <%=session.getAttribute("empCName")%> 您好</div>
			</div>
            <div id='menu'>
                <div align='right' class='smallwhitetext' style='padding:9px;'>
                    <a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerPersonalDetail.jsp'>查詢</a> | <a href='adminTravelList.jsp' admin="true" >系統維護</a>
                </div>
            </div>

			<div id="submenu">
				<div align="right" class="smallgraytext" style="padding:9px;"></div>
			</div>
			<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
			<div id="contenttext01">
				<div style="padding:0px;vertical-align:middle">
					<span class="titletext">行程清單</span>
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
			<div class="bodytext" style="padding:1px" align="justify">
           <table class="FormTable">
               <tr>
                    <td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>行程代碼</td>
                    <td class='FormTDH' style='width:25%;background:#BBBBBB;color:#FFFFFF;padding:3px'>行程名稱</td>
                    <td class='FormTDH' style='width:8%;background:#BBBBBB;color:#FFFFFF;padding:3px'>工號</td>
                    <td class='FormTDH' style='width:8%;background:#BBBBBB;color:#FFFFFF;padding:3px'>姓名</td>
                    <td class='FormTDH' style='width:7%;background:#BBBBBB;color:#FFFFFF;padding:3px'>身份</td>
                    <td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>生日</td>
                    <td class='FormTDH' style='width:5%;background:#BBBBBB;color:#FFFFFF;padding:3px'>年齡</td>
                    <td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>房間</td>
                    <td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>餐桌</td>
                    <td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>車輛</td>
                   <td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>費用</td>
                </tr>
<%
	if( col == null || col.size() == 0 )
	{
%>	
		    		<tr><td colspan="10">目前無資料........</td></tr>
<%
	}else 
    {        
		Iterator it = col.iterator();
		HashMap hm = null;
		
		while(it.hasNext() )
		{
			hm =(HashMap)it.next();
			String empNO = strUtil.getPara(hm.get("employeeNo"));
			//if(!empNO.equals("11002688") ) continue;
			
			String name =  strUtil.getPara(hm.get("name"));
			int roomPay = trBean.getRoomPay(empNO, name);
			int selfPay = trBean.getSelfPay(empNO, name);
			int TotalPay = roomPay + selfPay;
			String roomNo = strUtil.getPara(hm.get("roomNo"));
			String strRoomNO = "未選";
			if(!roomNo.equals("") )
			{
				strRoomNO = roomNo + "【" +strUtil.getPara(hm.get("roomDetailNo"))+ "】";
			}
			
			String deskNo = strUtil.getPara(hm.get("deskNo"));
			String strDeskNO = "未選";
			if(!deskNo.equals("") )
			{
				strDeskNO = deskNo + "【" +strUtil.getPara(hm.get("deskDetailNo"))+ "】";
			}
			
			String vehicleNo = strUtil.getPara(hm.get("vehicleNo"));
			String strVehicleNo = "未選";
			if(!vehicleNo.equals("") )
			{
				strVehicleNo = vehicleNo + "【" +strUtil.getPara(hm.get("vehicleDetailNo"))+ "】";
			}
			
				
%>
                   <tr>
                      <td class='FormTDH' style='padding:3px'><%=strUtil.getPara(hm.get("travelNo"))%></td>
                      <td class='FormTDH' style='padding:3px'><%=strUtil.getPara(hm.get("travelName"))%></td>
                      <td class='FormTDH' style='padding:3px'><%=empNO%></td>
                      <td class='FormTDH' style='padding:3px'><%=strUtil.getPara(hm.get("name"))%></td>
                      <td class='FormTDH' style='padding:3px'><%=trBean.getRelative(empNO, name)%></td>
                      <td class='FormTDH' style='padding:3px'><%=trBean.getBirthday(empNO, name)%></td>
                      <td class='FormTDH' style='padding:3px'><%=trBean.getAge(empNO, name)%></td>
                      <td class='FormTDH' style='padding:3px'><%=strRoomNO%></td>
                      <td class='FormTDH' style='padding:3px'><%=strDeskNO%></td>
                      <td class='FormTDH' style='padding:3px'><%=strVehicleNo%></td>
                     <td class='FormTDH' style='padding:3px' title="房間差額[<%=roomPay%>] +自費金額[<%=selfPay%>]"><%=TotalPay%></td>
                    </tr> 
<%                                 
		} //end of  while(it.hasNext() )
	} //end of if(col.size() == 0 ) 
%>	   
           
           </table>        
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
<script type="text/javascript">
$(document).ready(function()
{
	if($(":hidden[name='isAdmin']").val() == "false")
	{
		$("[admin='true']").hide(); 	
	}
}); //end of $(document).ready(function()


</script>
</html>