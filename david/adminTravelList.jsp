<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.sql.ResultSet" %>
<%@ page language="java" import="connect.TravelBean" %>
<%@ page language="java" import="myutil.strUtil" %>
<%
		if(session.getAttribute("empNo") == null){
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request,response);
			return;
		}
    String empNo = session.getAttribute("empNo").toString();
	TravelBean  trBean = new TravelBean();	
	boolean isAdmin = trBean.isAdmin(empNo);
	Collection<HashMap> col = trBean.getAllTravelYear();
	String selectTravelYear = strUtil.getPara(request.getParameter("selectTravelYear"));
	
	String[] para = new String[30];
	para[0] = ""; //travelNO
	para[1] = selectTravelYear;
	Collection<HashMap> col2 = trBean.getTravel(para);
	String srvRoot = request.getContextPath();
	
	
	
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
	<script src="js/creatRequestObj.js"></script>
	
	<title>行程清單</title>

</head>
<body>
<form name="myForm" action="travelPlanDetailAction.jsp" method="post">
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
<%--         <a href="addTravelPlan.jsp">新增行程</a> | <a href="registerDetail.jsp">查詢</a> | <a href='recalculateMoney.jsp'>重新計算金額</a>--%>
          <a href="addTravelPlan.jsp">新增行程</a> | <a href="registerDetail.jsp">報名人員查詢</a>
        </div>
			</div>
			<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
			<div id="contenttext01">
				<div style="padding:0px;vertical-align:middle">
					<span class="titletext">行程清單</span>
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
			<div class="bodytext" style="padding:1px" align="justify">
			<div>顯示年份：
			<select id="selectTravelYear" name="selectTravelYear"  onchange="changeYear(this.value);">
            
<%
		
		for(HashMap<String,String> hm : col)
		{
			String year  = (String)hm.get("year");
%>
		        <option value="<%=year%>" <% if(year.equals(selectTravelYear) ) out.print("selected");%> ><%=year%></option>	        
<%
		} //end of for(HashMap<String,String> hm : col)
%>            	     
            	<option value="All" <% if(selectTravelYear.equals("All") ) out.print("selected");%> >All</option>
            </select>
			</div>
          <table id="dataTable" class="FormTable">
<%
    if(col2.size()== 0)
	{
%>			
		<tr><td>目前無行程資料資料........</td></tr>
<%
	} else {
%>
		 <tr>
                <td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>行程代碼</td>
                <td class='FormTDH' style='width:25%;background:#BBBBBB;color:#FFFFFF;padding:3px'>行程名稱</td>
                <td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>開始日期</td>
                <td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>結束日期</td>
                <td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>報名人數</td>
                <td class='FormTDH' style='width:35%;background:#BBBBBB;color:#FFFFFF;padding:3px'>功能設定</td>
        </tr>
<%
		int registerCount = 0;
		for(HashMap<String ,String> hm2 : col2)
		{    
			
			String travelNo = strUtil.getPara(hm2.get("travelNo"));
			String travelName = strUtil.getPara(hm2.get("travelName"));
			registerCount = trBean.getRegisterCount(travelNo);
			
%>
                <tr>
                    <td class='FormTDH' style='width:10%;padding:3px'><a href='editTravelPlan.jsp?travelNo=<%=travelNo%>'><%=travelNo%></td>
                    <td class='FormTDH' style='width:25%;padding:3px'><%=travelName%></td>
                    <td class='FormTDH' style='width:10%;padding:3px'><%=strUtil.getPara(hm2.get("travelDateStart"))%></td>
                    <td class='FormTDH' style='width:10%;padding:3px'><%=strUtil.getPara(hm2.get("travelDateEnd"))%></td>
                    <td class='FormTDH' style='width:10%;padding:3px'><%=registerCount%></td>
                    <td class='FormTDH' style='width:35%;padding:3px'>
                        <div style='font-size:75%'>
                            <input type='button' onclick="changeSet('<%=travelNo%>','<%=travelName%>');" value='位置設定'>
                            <input type='button' onclick="feeSetting('<%=travelNo%> ','<%=travelName%>');" value='費用設定'>
                            <input type='button' onclick="roomFeeSetting('<%=travelNo%>','<%=travelName%>');" value='房間額外費用設定'>
                            <input type='button' onclick="funditionSetting('<%=travelNo%>','<%=travelName%>');" value='功能設定'>
                            <input type='button' onclick="admimRegister('<%=travelNo%>','<%=travelName%>');" value='報名人員管理'>
                            <input type='button' onclick="report01('<%=travelNo%>');" value='產生報表'>
                         </div>   
                     </td>
                </tr>
<%                    
				
       	}  //end of for(HashMap<String ,String> hm2 : col2)
    } //end of  if(col2.size()== 0)
%>				

          </table>        
        </div>	
        <div style="border:1px solid #333333;width:100%"></div>
			</div>
			<div id="footer" class="smallgraytext">
				<div id="footer" class="smallgraytext">
     			 
			</div>
				
			</div>
		</div>
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
function changeSet(travelNo,travelName){
	window.location.href="adminSetSettingList.jsp?travelNo=" + travelNo + "&travelName=" + travelName;
}
function funditionSetting(travelNo,travelName){
	window.location.href="funditionSetting.jsp?travelNo=" + travelNo + "&travelName=" + travelName;
}
function feeSetting(travelNo,travelName){
	window.location.href="feeSetting.jsp?travelNo=" + travelNo + "&travelName=" + travelName;
}		
function roomFeeSetting(travelNo,travelName){
	window.location.href="roomFeeSetting.jsp?travelNo=" + travelNo + "&travelName=" + travelName;
}
function admimRegister(travelNo,travelName){
	window.location.href="adminRegisterList.jsp?travelNo=" + travelNo + "&travelName=" + travelName;
}			
function report01(travelNo){
	window.location.href="<%=srvRoot%>/ExcelServlet?action=registerReport&travelNo=" + travelNo;
}

function uniqueArr(arr1){
	var arr2 = new Array();
	var k=0;
	var flag = false;
	for(var i=0;i<arr1.length;i++){
		for(var j=i+1;j<arr1.length;j++){
			if(arr1[i] !="" && arr1[i]==arr1[j]){
				arr1[j] = "";
				flag = true;
			}
		}
		if(flag = true){
			arr2[k] = arr1[i];
			k = k + 1;
		}
	}
	return arr2;
}

function trimArray(arr1){
	var arr2 = new Array();
	var j=0;
	for(var i=0;i<arr1.length;i++){
		if(arr1[i]!=""){
			arr2[j] = arr1[i];
			j = j + 1;
		}
	}
	return arr2;
}

//create XMLHttpRequest Object
var request = null;
request = creatRequestObj();
if (request == null){
//無法取得XMLHttpRequest物件時發出警告
alert("Error creating request object!");
}

//變更查詢年份
function changeYear(travelDate) 
{
	
	myForm = document.getElementsByName("myForm")[0];
	myForm.action = ""; //原始的頁面
	myForm.submit();

}

function getContents() {
if (request.readyState == 4) {//完成狀態有好幾種，4代表資料傳回完成
	var data = request.responseText;//取得傳回的資料存在變數中
	var resultValue = data.substring(data.indexOf("<context>")+9,data.indexOf("</context>"));
	document.getElementById("dataTable").innerHTML = resultValue;
}
}		
	</script>