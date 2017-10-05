<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="connect.TravelBean" %>
<%@ page language="java" import="myutil.strUtil" %>
<%
	if(session.getAttribute("empNo") == null){
		RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
		dispatcher.forward(request,response);
		return;
	}
	String empNo = session.getAttribute("empNo").toString();
	String travelNo = strUtil.getPara( request.getParameter("travelNo") );
	TravelBean  trBean = new TravelBean();	
	boolean isAdmin = trBean.isAdmin(empNo);
	String[] para = new String[20];
	para[0] = travelNo;
	Collection<HashMap<String, String> >  col = trBean.getTravel(para);
	
	Iterator it = col.iterator();
	HashMap<String ,String>  hm = (HashMap)it.next();
	
	
	
	
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
		
		//隱藏系統管理者功能
		if($(":hidden[name='isAdmin']").val() == "false")
		{
			$("[admin='true']").hide(); 	
		}
		
		$( "#datepicker01" ).datepicker();
		$( "#datepicker02" ).datepicker();
		$( "#datepicker03" ).datepicker();
		$( "#datepicker04" ).datepicker();
		$( "#datepicker05" ).datepicker();
		$( "#datepicker06" ).datepicker();
		$( "input:button").button();
		//$( "a", ".demo" ).click(function() { return false; });
	});
	</script>
	<title>行程規劃詳細資料</title>

</head>
<body>
<form name="myForm" action="editTravelPlanAction.jsp" method="post">
<input type="hidden" name="isAdmin" value="<%=isAdmin%>" > <!--是否是管理者 -->
	<div id="page" align="center">
		<div id="content" style="width:800px">
			<div id="logo">
				<div style="margin-top:70px" class="whitetitle">KYE</div>
			</div>
			<div id="topheader">
				<div align="left" class="bodytext"></div>
				<table align="right" border="0">
                   <tr>
                       <td><div style='text-align:right'>嗨, <%=session.getAttribute("empCName")%> 您好</div></td>
                        <td><input type="button"  id="logout" value="登 出" onClick="location.href='logout.jsp'"></td>
                  </tr>
                 </table>
			</div>
			<div id='menu'>
                <div align='right' class='smallwhitetext' style='padding:9px;'>
                    <a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerPersonalDetail.jsp'>查詢</a> | <a href='adminTravelList.jsp' admin="true" >系統維護</a>
                </div>
			</div>
			<div id="submenu">
				<div align="right" class="smallgraytext" style="padding:9px;">
          
        </div>
			</div>
			<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
			<div id="contenttext01">
				<div style="padding:0px;vertical-align:middle">
					<span class="titletext">行程規劃詳細資料</span>
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
				<div class="bodytext" style="padding:1px" align="justify">
          <table class="FormTable">
            <tr>
              <td class='FormTDH' style='width:20%'>行程編號</td>
              <td class='FormTDC' style='width:30%'><input id='travelNo' name='travelNo' type='text' value='<%=strUtil.getPara(hm.get("travelNo"))%>' readonly></td>
              <td class='FormTDH' style='width:20%'>行程名稱</td>
              <td class='FormTDC' style='width:30%'><input id='travelName' name='travelName' type='text' value='<%=strUtil.getPara(hm.get("travelName"))%>'></td>
            </tr>
            <tr>
              <td class='FormTDH' style='width:20%'>行程日期【開始】</td>
              <td class='FormTDC' style='width:30%'><input id='datepicker01' name='datepicker01' type='text' value='<%=strUtil.getPara(hm.get("travelDateStart"))%>'></td>
              <td class='FormTDH' style='width:20%'>行程日期【結束】</td>
              <td class='FormTDC' style='width:30%'><input id='datepicker02' name='datepicker02' type='text' value='<%=strUtil.getPara(hm.get("travelDateEnd"))%>'></td>              
            </tr>
            <tr>
              <td class='FormTDH' style='width:20%'>報名日期【開始】</td>
              <td class='FormTDC' style='width:30%'><input id='datepicker03' name='datepicker03' type='text' value='<%=strUtil.getPara(hm.get("registerDateStart"))%>'></td>
              <td class='FormTDH' style='width:20%'>報名日期【結束】</td>
              <td class='FormTDC' style='width:30%'><input id='datepicker04' name='datepicker04' type='text' value='<%=strUtil.getPara(hm.get("registerDateEnd"))%>'></td>
            </tr>            
            <tr>
              <td class='FormTDH' style='width:20%'>行程人數</td>
              <td class='FormTDC' style='width:30%'><input id='travelQuantity' name='travelQuantity' type='text' value='<%=strUtil.getPara(hm.get("travelQuantity"))%>'></td>
              <td class='FormTDH' style='width:20%'>自費金額</td>
              <td class='FormTDC' style='width:30%'><input id='selfPay' name='selfPay' type='text' value='<%=strUtil.getPara(hm.get("selfPay"))%>'></td>
            </tr>
            <tr>
              <td class='FormTDH' style='width:20%'>房間追加費用</td>
              <td class='FormTDC' style='width:30%'>4人：<input id='room4Cost' name='room4Cost' type='text' value='<%=strUtil.getPara(hm.get("room4Cost"))%>'><br />3人：<input id='room3Cost' name='room3Cost' type='text' value='<%=strUtil.getPara(hm.get("room3Cost"))%>'><br />2人：<input id='room2Cost' name='room2Cost' type='text' value='<%=strUtil.getPara(hm.get("room2Cost"))%>'></td>
              <td class='FormTDH' style='width:20%'>房間數量</td>
              <td class='FormTDC' style='width:30%'>4人：<input id='room4Num' name='room4Num' type='text' value='<%=strUtil.getPara(hm.get("room4Num"))%>'><br />3人：<input id='room3Num' name='room3Num' type='text' value='<%=strUtil.getPara(hm.get("room3Num"))%>'><br />2人：<input id='room2Num' name='room2Num' type='text' value='<%=strUtil.getPara(hm.get("room2Num"))%>'></td>
           	</tr>
            <tr>
              <td class='FormTDH' style='width:20%'>車輛數量</td>
              <td class='FormTDC' style='width:30%'><input id='vehicleNum' name='vehicleNum' type='text' value='<%=strUtil.getPara(hm.get("vehicleNum"))%>'></td>
              <td class='FormTDH' style='width:20%'>餐桌數量</td>
              <td class='FormTDC' style='width:30%'><input id='tableNum' name='tableNum' type='text' value='<%=strUtil.getPara(hm.get("tableNum"))%>'></td>
           	</tr>
            <tr>
              <td class='FormTDH' style='width:20%'>行程說明</td>
              <td class='FormTDC' style='width:80%' colspan='3'><input id='travelDesc' name='travelDesc' type='text' value='<%=strUtil.getPara(hm.get("travelDesc"))%>'></td>
            </tr>    
            
          </table>  
        </div>	
        <div style="font-size:65%">
          <input type="button" onclick="document.forms[0].submit();" value="確定"/>&nbsp;&nbsp;&nbsp;<input type="button" onclick="window.location.href='adminTravelList.jsp'" value="離開"/>
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