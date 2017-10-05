<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.text.*" %>
<%@ page language="java" import="connect.TravelBean" %>
<%@ page language="java" import="myutil.strUtil" %>
<%
		if(session.getAttribute("empNo") == null){
			response.sendRedirect("login.jsp");
			response.flushBuffer();
			
			return;
		}
		TravelBean  trBean = new TravelBean();
		Collection col = trBean.getDisplayTravel();
		String empNo = session.getAttribute("empNo").toString();
		boolean isAdmin = trBean.isAdmin(empNo);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="author" content="Wink Hosting (www.winkhosting.com)" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" href="css/style.css" type="text/css" />
    <script src="js/jquery-1.6.2.js"></script>
	<title>員工旅遊首頁</title>

</head>
<body>
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
				<div align="right" class="smallgraytext" style="padding:9px;"></div>
			</div>
			<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
            
            
			<div id="contenttext01">
				<div style="padding:10px">
					<span class="titletext">員工旅遊-行程規劃</span>
				</div>
                <div style="font-size:14px;color:#F00" align="left">說明(重要):</div>
                <div style="font-size:14px;color:#00F" align="left">
                   1.旅遊行程梯次，系統只允許報名一個行程梯次，無法重覆報名。若重覆報名，系統只會保留最後一次的報名行程梯次。若需參加兩個以上的行程梯次，請直接與該梯次委員聯絡，個案處理。<br /><br />
                   2.員工若有多位直系親屬參加。由於福委會只補助一位直系親屬免費，請在報名前,先將想要免費的直系親屬設為直系，其他直系親屬均設為親友。如此系統方能正確算出所需繳交的旅費。<br /><br />
                   3.溪頭的 A、B 行程二擇一說明: 報名人數在1台車內, 則以A 行程為主， B 行程為雨備方案。 若超過1台車以上才能實施2擇1方案。
            	</div>
				<div style="font-size:14px; color:#F00" align="left">
                溪頭 : 黃清梅Diane  #3850 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;江南 : 李宜蓁Sancho #3262&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;礁溪 : 姚先蓉Sharon #3732
				</div>
                <div class="bodytext" style="padding:12px;" align="justify">
<%
	if(col == null  || col.size() == 0 )
	{			  
%>				 
             	<div>目前無開放的行程.....</div>	
             	           
<%
     }else
	 {
		 Iterator it = col.iterator();
		 HashMap hm = null;
		 while(it.hasNext() )
		 {
		 	hm = (HashMap)it.next();
			
%>				
            	 <div class='hyperLink'><img src='images/chose.gif'>&nbsp;&nbsp;&nbsp;<a  style='font-size:20px' href='#' onclick='location.href="travelPlanDetail.jsp?travelNo=<%=strUtil.getPara(hm.get("travelNo"))%>"' ><%=strUtil.getPara(hm.get("travelName"))%></a><br />
                 	<span>時間：<%=strUtil.getPara(hm.get("travelDateStart"))%>  ~ <%=strUtil.getPara(hm.get("travelDateEnd"))%> </span><br /><br />
                 </div>   
<%
		 } //end of while(it.hasNext() )
	 } //end of if(col == null  || col.size() == 0 )
%>
				</div>
			</div>
			<div id="footer" class="smallgraytext">
     			<a href='index.jsp'>首頁</a> | <a href='personalData.jsp'>基本資料維護</a> | <a href='registerPersonalDetail.jsp'>查詢</a> | <a href='adminTravelList.jsp' admin="true">系統維護</a>
	
			</div>
		</div>
	</div>
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