<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.sql.ResultSet" %>
<%@ page language="java" import="connect.ConnectToMySql" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
<%
	String travelDate = request.getParameter("travelDate").toString();
	
	ConnectToMySql connObj = new ConnectToMySql(); 
  
	ArrayList<String> al01 = new ArrayList<String>();
	ArrayList<String> al02 = new ArrayList<String>();
	if(travelDate.equals("All")){
		al01 = connObj.select("select travelNo,travelName,travelDateStart,travelDateEnd from travel");
	}else{
		al01 = connObj.select("select travelNo,travelName,travelDateStart,travelDateEnd from travel where " + travelDate + " = DATE_FORMAT(travelDateStart,'%Y')");
	}

	String temp="";
	if(al01.size()!=0){
		temp = "<tr>";
		temp = temp + "<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>行程代碼</td>";
		temp = temp + "<td class='FormTDH' style='width:25%;background:#BBBBBB;color:#FFFFFF;padding:3px'>行程名稱</td>";
		temp = temp + "<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>開始日期</td>";
		temp = temp + "<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>結束日期</td>";
		temp = temp + "<td class='FormTDH' style='width:10%;background:#BBBBBB;color:#FFFFFF;padding:3px'>報名人數</td>";
		temp = temp + "<td class='FormTDH' style='width:35%;background:#BBBBBB;color:#FFFFFF;padding:3px'></td>";
		temp = temp + "</tr>";
		
        String[] arr = null;
			for(int i=0;i<al01.size();i++){
				arr = al01.get(i).split(";");
				al02 = connObj.select("select count(travelNo) from registration where travelNo='" + arr[0] + "'");
				temp = temp + "<tr>";
				temp = temp + "<td class='FormTDH' style='width:10%;padding:3px'><a href='editTravelPlan.jsp?travelNo=" + arr[0] + "'>" + arr[0] + "</td>";
				temp = temp + "<td class='FormTDH' style='width:25%;padding:3px'>" + arr[1] + "</td>";
				temp = temp + "<td class='FormTDH' style='width:10%;padding:3px'>" + arr[2] + "</td>";
				temp = temp + "<td class='FormTDH' style='width:10%;padding:3px'>" + arr[3] + "</td>";
				temp = temp + "<td class='FormTDH' style='width:10%;padding:3px'>" + al02.get(0) + "</td>";
				temp = temp + "<td class='FormTDH' style='width:35%;padding:3px'><div style='font-size:75%'><input type='button' onclick=\"changeSet('" + arr[0] + "','" + arr[1] + "');\" value='位置設定'><input type='button' onclick=\"feeSetting('" + arr[0] + "','" + arr[1] + "');\" value='費用設定'><input type='button' onclick=\"roomFeeSetting('" + arr[0] + "','" + arr[1] + "');\" value='房間額外費用設定'><input type='button' onclick=\"funditionSetting('" + arr[0] + "','" + arr[1] + "');\" value='功能設定'><input type='button' onclick=\"admimRegister('" + arr[0] + "','" + arr[1] + "');\" value='報名人員管理'><input type='button' onclick=\"report01('" + arr[0] + "');\" value='產生報表'></div></div></div></td>";
				temp = temp + "</tr>";
			}			
	}else{
		temp = "<tr><td>目前無行程資料資料........</td></tr>";
	}

	out.write("<context>");
	out.write(temp);
	out.write("</context>");  
%>
</body>
</html>