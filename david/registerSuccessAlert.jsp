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
	<title>行程清單</title>
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
    ArrayList<String> al03 = new ArrayList<String>();
    ArrayList<String> al04 = new ArrayList<String>();
    ArrayList<String> al05 = new ArrayList<String>();
    
    String travelName = "";
    String travelNo = "";
    String employeeNo = "";
    String names = "";
    String travelMoney = "";
    String roomNo = "";
    String roomDetailNo = "";
    String deskNo = "";
    String deskDetailNo = "";
    String vehicleNo = "";
    String vehicleDetailNo = "";
    
		String[] arr02 = null; 
    String[] arr03 = null; 
    String[] arr04 = null;
    
    al01 = connObj.select("SELECT A1.travelName, A2.travelNo, A2.employeeNo, A2.name, A2.money FROM travel A1, registration A2 WHERE (A1.travelNo = A2.travelNo) and (A2.isTempFlag ='N') and (A2.employeeNo='" + empNo + "') order by A2.travelNo ASC,A2.employeeNo ASC"); 
    for(int i=0;i<al01.size();i++){ String[] arr01 = al01.get(i).split(";");
    	if(travelName.equals("")){ 
    		travelName = arr01[0]; 
    		travelNo = arr01[1]; 
    		employeeNo = arr01[2]; 
    		names = arr01[3];    	 
    		travelMoney = arr01[4]; 
    	}else{ 
    		travelName = travelName + ";" + arr01[0];
    		travelNo = travelNo + ";" + arr01[1];
    		employeeNo = employeeNo + ";" + arr01[2]; 
    		names = names + ";" + arr01[3].trim(); 
    		travelMoney = travelMoney + ";" + arr01[4];     	
    	}

    	al02 = connObj.select("SELECT roomNo, roomDetailNo FROM roommember WHERE employeeNumber ='" + arr01[2] + "' AND MemberName ='" + arr01[3] + "'");
    	al03 = connObj.select("SELECT deskNo, deskDetailNo FROM deskmember WHERE employeeNumber ='" + arr01[2] + "' AND memberName ='" + arr01[3] + "'"); 
    	al04 = connObj.select("SELECT vehicleNo, vehicleDetailNo FROM vehiclemember WHERE employeeNumber ='" + arr01[2] + "' AND memberName ='" + arr01[3] + "'");

    	if(al02.size()==0){ 
    		String[] temp01Arr = {"未選","未選"}; 
    		arr02 = temp01Arr; 
    	}else{ 
    		String[] temp01Arr = al02.get(0).split(";"); 
    		arr02 = temp01Arr; } 
    	if(al03.size()==0){ 
    		String[] temp02Arr = {"未選","未選"}; 
    		arr03 = temp02Arr; 
    	}else{ 
    		String[] temp02Arr = al03.get(0).split(";"); arr03 = temp02Arr; } 
    	if(al04.size()==0){ 
    		String[] temp03Arr = {"未選","未選"}; 
    		arr04 = temp03Arr; 
    	}else{ 
    		String[] temp03Arr = al04.get(0).split(";"); 
    		arr04 = temp03Arr; 
    	}


    	if(roomNo.equals("")){
    		roomNo = arr02[0]; roomDetailNo = arr02[1]; 
    		deskNo = arr03[0]; deskDetailNo = arr03[1]; vehicleNo = arr04[0]; 
    		vehicleDetailNo = arr04[1]; 
    	}else{ 
    		roomNo = roomNo + ";" + arr02[0]; 
    		roomDetailNo = roomDetailNo + ";" + arr02[1]; deskNo = deskNo + ";" + 
    		arr03[0]; deskDetailNo = deskDetailNo + ";" + arr03[1]; vehicleNo = 
    		vehicleNo + ";" + arr04[0]; vehicleDetailNo = vehicleDetailNo + ";" + 
    		arr04[1];
    	}   
    }

    String feeTravelNo = "";
    String feeTwo = "";
    String feeThree = "";
    String feeFour = "";
    al05 = connObj.select("SELECT travelNo,two,three,four FROM roomfeedata");
    String[] feeArr = null;
    for(int i=0;i<al05.size();i++){
    	feeArr = al05.get(i).split(";");
    	if(feeTwo.equals("")){
    		feeTravelNo = feeArr[0];
    		feeTwo = feeArr[1];
    		feeThree = feeArr[2];
    		feeFour = feeArr[3];
    	}else{
    		feeTravelNo = feeTravelNo + ";" + feeArr[0];
    		feeTwo = feeTwo + ";" + feeArr[1];
    		feeThree = feeThree + ";" + feeArr[2];
    		feeFour = feeFour + ";" + feeArr[3];    		
    	}
    }
    
    String[] feeTravelNoArr = feeTravelNo.split(";");
    String[] feeTwoArr = feeTwo.split(";");
    String[] feeThreeArr = feeThree.split(";");
    String[] feeFourArr = feeFour.split(";");
    
    String[] travelNameArr = travelName.split(";");
    String[] travelNoArr = travelNo.split(";");
    String[] employeeNoArr = employeeNo.split(";");
    String[] namesArr = names.split(";");                   
    String[] travelMoneyArr = travelMoney.split(";");
    String[] roomNoArr = roomNo.split(";");
    String[] roomDetailNoArr = roomDetailNo.split(";");
    String[] deskNoArr = deskNo.split(";");
    String[] deskDetailNoArr = deskDetailNo.split(";");
    String[] vehicleNoArr = vehicleNo.split(";");
    String[] vehicleDetailNoArr = vehicleDetailNo.split(";");
    
    String Money = "";
    int kk =0;
    for(int i=0;i<travelNoArr.length;i++){
    	for(int j=0;j<feeTravelNoArr.length;j++){
    		if(travelNoArr[i].equals(feeTravelNoArr[j])){
    			if(roomNoArr[i].substring(0,1).equals("2")){
    				if(roomDetailNoArr[i].equals("03")){
    					if(Money.equals("")){
    						Money = "0";
    					}else{
    						Money = Money + ";" + "0";
    					}    				
    				}else{
    					if(Money.equals("")){
    						Money = feeTwoArr[j];
    					}else{
    						Money = Money + ";" + feeTwoArr[j];
    					}    				
    				}
    			}else if(roomNoArr[i].substring(0,1).equals("3")){
    				if(roomDetailNoArr[i].equals("04")){
    					if(Money.equals("")){
    						Money = "0";
    					}else{
    						Money = Money + ";" + "0";
    					}    				
    				}else{
    					if(Money.equals("")){
    						Money = feeThreeArr[j];
    					}else{
    						Money = Money + ";" + feeThreeArr[j];
    					}    				
    				}
    			}else if(roomNoArr[i].substring(0,1).equals("4")){
    				if(Money.equals("")){
    					Money = feeFourArr[j];
    				}else{
    					Money = Money + ";" + feeFourArr[j];
    				}
    			}else{
     				if(Money.equals("")){
    					Money = "0";
    				}else{
    					Money = Money + ";" + "0";
    				}   				
    			}
    			kk = kk + 1;
    			break;
    		}
    	}
    }

    String[] moneyArr = Money.split(";");

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
				<div align="right" class="smallgraytext" style="padding:9px;"></div>
			</div>
			<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
			<div id="contenttext01">
				<div style="padding:0px;vertical-align:middle">
					<span class="titletext">行程清單</span>
				</div>
				<div style="border:1px solid #333333;width:100%"></div>
			<div class="bodytext" style="padding:1px" align="justify">
			<div style="font-size:26pt;color:#FF0000">報名成功</div>
          <table class="FormTable">
            <%
              if(al01.size()!=0){
                out.write("<tr>");
                out.write("<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>行程代碼</td>");
                out.write("<td class='FormTDH' style='width:30%;background:#BBBBBB;color:#FFFFFF;padding:3px'>行程名稱</td>");
                out.write("<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>工號</td>");
                out.write("<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>姓名</td>");
                out.write("<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>房間</td>");
                out.write("<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>餐桌</td>");
                out.write("<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>車輛</td>");
                out.write("<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>費用</td>");
                out.write("</tr>");
                for(int i=0;i<al01.size();i++){
                  out.write("<tr>");
                  out.write("<td class='FormTDH' style='width:10%;padding:3px'>" + travelNoArr[i] + "</td>");
                  out.write("<td class='FormTDH' style='width:30%;padding:3px'>" + travelNameArr[i] + "</td>");
                  out.write("<td class='FormTDH' style='width:10%;padding:3px'>" + employeeNoArr[i] + "</td>");
                  out.write("<td class='FormTDH' style='width:10%;padding:3px'>" + namesArr[i] + "</td>");
                  out.write("<td class='FormTDH' style='width:10%;padding:3px'>" + roomNoArr[i] + "【" + roomDetailNoArr[i] + "】</td>");
          				out.write("<td class='FormTDH' style='width:10%;padding:3px'>" + deskNoArr[i] + "【" + deskDetailNoArr[i] + "】</td>");
          				out.write("<td class='FormTDH' style='width:10%;padding:3px'>" + vehicleNoArr[i] + "【" + vehicleDetailNoArr[i] + "】</td>");
                  out.write("<td class='FormTDH' style='width:10%;padding:3px'>" + String.valueOf(Integer.parseInt(moneyArr[i]) + Integer.parseInt(travelMoneyArr[i])) + "</td>");
                	out.write("</tr>");              
                }               
              }else{
                  out.write("<tr><td>目前無資料........</td></tr>");
              }       
            %>
          </table>        
        </div>	
        <div style="border:1px solid #333333;width:100%"></div>
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
</form>
</body>
</html>