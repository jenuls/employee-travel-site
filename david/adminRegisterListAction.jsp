﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.sql.ResultSet" %>
<%@ page language="java" import="connect.ConnectToMySql" %>
<%@ page language="java" import="java.net.URLEncoder"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
ConnectToMySql connObj = new ConnectToMySql(); 

  String travelName = new String(request.getParameter("travelName").getBytes("ISO-8859-1"),"UTF-8");
  String selectedValue = new String(request.getParameter("selectedValue").getBytes("ISO-8859-1"),"UTF-8");
  String travelNo = request.getParameter("travelNo");
  String[] arr01 = selectedValue.split(",");

 	String[] empNoArr = new String[arr01.length];
 	String[] arr02 = null;
  for(int i=0;i<arr01.length;i++){
    arr02 = arr01[i].split(";");
    empNoArr[i] = arr02[0];
		connObj.delete("delete from registration where employeeNo='" + arr02[0] + "' and name='" + arr02[1] + "'"); 	
		connObj.update("update roommember set employeeNumber = 'NA',MemberName='NA' where travelNo='" + travelNo + "' and employeeNumber='" + arr02[0] + "' and MemberName='" + arr02[1] + "'");
		connObj.update("update deskmember set employeeNumber = 'NA',memberName='NA' where travelNo='" + travelNo + "' and employeeNumber='" + arr02[0] + "' and memberName='" + arr02[1] + "'");
		connObj.update("update vehiclemember set employeeNumber = 'NA',memberName='NA' where travelNo='" + travelNo + "' and employeeNumber='" + arr02[0] + "' and memberName='" + arr02[1] + "'");
  }
  
  ArrayList<String> empNoUNQ = new ArrayList<String>();
	String flag = "0";
	for(int i=0;i<empNoArr.length;i++){
		flag = "0";
		for(int j=0;j<empNoUNQ.size();j++){
			if(empNoArr[i].equals(empNoUNQ.get(j))){
				flag = "1";
			}
		}
		if(flag.equals("0")){
			empNoUNQ.add(empNoArr[i].trim());
		}
	}

  //重新計算費用
  String relatives = "";
  String names = "";
  String age = "";
  String ageTemp = "";
  String relativesFlag = "0";
 	int money=0;
  String[] relativesArr = null;
  String[] namesArr = null;  
  String[] ageArr = null;
  String[] tempArr = null; 	    
	String[] ageTempArr = null;
	String[] transportationArr = null;
	String[] tempP = null;
  ArrayList<String> al01 = new ArrayList<String>();
	ArrayList<String> al02 = new ArrayList<String>();
	ArrayList<String> al03 = new ArrayList<String>();
	Calendar thisDate=Calendar.getInstance();
  al02 = connObj.select("select * from feedata where travelNo='" + travelNo + "'");
  
  for(int i=0;i<empNoUNQ.size();i++){
		al01 = connObj.select("select relativesdata.relatives,registration.name,relativesdata.birthday from registration left join relativesdata on (registration.employeeNo = relativesdata.employeeNumber) and (registration.name = relativesdata.name) where(((relativesdata.relatives) is not null)) and registration.travelNo='" + travelNo + "' and registration.employeeNo='" + empNoUNQ.get(i) + "' and registration.temp='1'");
		if(al01.size()!=0){
			for(int j=0;j<al01.size();j++){
				tempArr = al01.get(j).split(";");
				if(relatives.equals("")){
					relatives = tempArr[0];
					names = tempArr[1];
					age = String.valueOf(Integer.parseInt(String.valueOf(thisDate.get(Calendar.YEAR)))- Integer.parseInt(tempArr[2].substring(0,4)));
				}else{
					relatives = relatives + ";" + tempArr[0];
					names = names + ";" + tempArr[1];
					age = age + ";" + String.valueOf(Integer.parseInt(String.valueOf(thisDate.get(Calendar.YEAR)))- Integer.parseInt(tempArr[2].substring(0,4)));				
				}
			}
			relativesArr = relatives.split(";");
			namesArr = names.split(";");		
			ageArr = age.split(";");
			relativesFlag = "0";
			ageTemp = "";
			for(int j=0;j<namesArr.length;j++){
				if(relativesArr[j].equals("直系")){
					if(relativesFlag.equals("0")){
						relativesFlag = "1";
					}else{
						if(ageTemp.equals("")){
							ageTemp = ageArr[j];
						}else{
							ageTemp = ageTemp + ";" + ageArr[j];
						}
					}
				}else{
					if(ageTemp.equals("")){
						ageTemp = ageArr[j];
					}else{
						ageTemp = ageTemp + ";" + ageArr[j];
					}				
				}
			}
			
			if(!ageTemp.equals("")){
  			ageTempArr = ageTemp.split(";");
  			for(int j=0;j<al02.size();j++){
  				transportationArr = al02.get(j).split(";");
   		 		for(int k=0;k<ageTempArr.length;k++){  
  					if(Integer.parseInt(ageTempArr[k])>=Integer.parseInt(transportationArr[1]) && Integer.parseInt(ageTempArr[k])<=Integer.parseInt(transportationArr[2])){
  						money = money + Integer.parseInt(transportationArr[3]);
 						}
			 		}
  			}
			}else{
				money = 0;
			}
		}

		al03 = connObj.select("select employeeNo,name from personaldata where employeeNo ='" + empNoUNQ.get(i) + "'");
		if(al03.size() != 0){
			tempP = al03.get(0).split(";");
			connObj.update("update registration set money='" + String.valueOf(money) + "' where travelNo='" + travelNo + "' and employeeNo='" + tempP[0] + "' and name='" + tempP[1] + "'");		
		}
  }

  response.sendRedirect("adminRegisterList.jsp?travelNo=" + travelNo + "&travelName=" + URLEncoder.encode(travelName,"UTF-8"));
%>
</body>
</html>