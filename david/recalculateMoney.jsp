<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.sql.ResultSet" %>
<%@ page language="java" import="connect.ConnectToMySql" %>
<%@ page language="java" import="java.text.*" %>
<%@ page language="java" import="myutil.DateUtil" %>
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
    Calendar thisDate=Calendar.getInstance(); 
    
    String temp01 = "";
    String temp02 = "";
    String temp03 = "";
    String temp04 = "";
    String temp05 = "";
    String temp06 = "";
    String temp07 = "";
    
    String[] temp01Arr = null;
	String[] temp02Arr = null; 
    String[] temp03Arr = null;
    String[] temp04Arr = null;
    String[] temp05Arr = null;
    String[] temp06Arr = null;
    String[] temp07Arr = null;
    
    String[] arr01 = null;
	String[] arr02 = null; 
    String[] arr03 = null;
    String[] arr04 = null;
	
	SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy/MM/dd");
	DateUtil dU = new DateUtil();

    String[] transportationArr = null;
    int money = 0;
    
    String tempFlag01 = "0"; 
    connObj.update("update registration set money='0'");
    
    al01 = connObj.select("select registration.employeeNo,registration.name from registration left join relativesdata on (registration.employeeNo = relativesdata.employeeNumber) and (registration.name = relativesdata.name) where (relativesdata.relatives is NULL) order by registration.employeeNo ASC");

    for(int i=0;i<al01.size();i++){
		arr02 = al01.get(i).split(";");
    	al02 = connObj.select("select registration.travelNo,registration.employeeNo,relativesdata.birthday,relativesdata.relatives from registration left join relativesdata on (registration.employeeNo = relativesdata.employeeNumber) and (registration.name = relativesdata.name) where (relativesdata.relatives is not NULL) and (registration.employeeNo='" + arr02[0].trim() + "') order by registration.employeeNo ASC");
    	if(temp06.equals("")){
    		temp06 = arr02[0];
    		temp07 = arr02[1];
    	}else{
    		temp06 = temp06 + ";" + arr02[0];
    		temp07 = temp07 + ";" + arr02[1];
    	}
    	
    	tempFlag01 = "0";
    	money = 0;
    	temp01 = "";
    	temp02 = "";
    	temp03 = "";
    	//temp04 = "";
    	for(int j=0;j<al02.size();j++){
    		arr01 = al02.get(j).split(";");
    		if(arr01[3].equals("直系")){
    			if(tempFlag01.equals("0")){
    				tempFlag01 = "1";
    			}else{
    				if(temp01.equals("")){ 
    					temp01 = arr01[0];
    					temp02 = arr01[1];
    					//temp03 = String.valueOf(Integer.parseInt(String.valueOf(thisDate.get(Calendar.YEAR)))- Integer.parseInt(arr01[2].substring(0,4)));dU.getAge(today11)
						temp03 = String.valueOf(dU.getAge(sdFormat.parse(arr01[2])));
    					//temp04 = arr01[3];
    				}else{ 
    					temp01 = temp01 + ";" + arr01[0];
    					temp02 = temp02 + ";" + arr01[1]; 
    					temp03 = temp03 + ";" + String.valueOf(dU.getAge(sdFormat.parse(arr01[2])));
    					//temp04 = temp04 + ";" + arr01[3];
    				}
    			}
    		}else{
    				if(temp01.equals("")){ 
    					temp01 = arr01[0];
    					temp02 = arr01[1];
    					temp03 = String.valueOf(dU.getAge(sdFormat.parse(arr01[2])));
    					//temp04 = arr01[3]; 	 
    				}else{ 
    					temp01 = temp01 + ";" + arr01[0];
    					temp02 = temp02 + ";" + arr01[1];
    					temp03 = temp03 + ";" + String.valueOf(dU.getAge(sdFormat.parse(arr01[2])));
    					//temp04 = temp04 + ";" + arr01[3];	
    				}    	
    		}
    	}
		
		temp01Arr = temp01.split(";");
		temp02Arr = temp02.split(";"); 
    	temp03Arr = temp03.split(";");

    	
    	al03 = connObj.select("select * from feedata where travelNo='" + temp01Arr[0] + "'");
		if(temp03Arr.length!=0){
			for(int k=0;k<al03.size();k++){
				transportationArr = al03.get(k).split(";");
				for(int j=0;j<temp03Arr.length;j++){  
					if(Integer.parseInt(temp03Arr[j])>=Integer.parseInt(transportationArr[1]) && Integer.parseInt(temp03Arr[j])<=Integer.parseInt(transportationArr[2])){
						money = money + Integer.parseInt(transportationArr[3]);
					}
				}
			}
		}else{
			money = 0;
		}    	
			
		if(money!=0){
			if(temp04.equals("")){
				temp04 = temp02Arr[0];
				temp05 = String.valueOf(money);
			}else{
				temp04 = temp04 + ";" + temp02Arr[0];
				temp05 = temp05 + ";" + String.valueOf(money);
			}
		}
    }   

	temp04Arr = temp04.split(";");
	temp05Arr = temp05.split(";");
		
	temp06Arr = temp06.split(";");
    temp07Arr = temp07.split(";");
		
	String temp08 = "";
		
	for(int i=0;i<temp04Arr.length;i++){
		for(int j=0;j<temp06Arr.length;j++){
			if(temp04Arr[i].equals(temp06Arr[j])){
				connObj.update("update registration set money ='" + temp05Arr[i] + "' where employeeNo='" + temp06Arr[j] + "' and name='" + temp07Arr[j] + "'");
			}
		}
	}
	
	response.sendRedirect("adminTravelList.jsp");
	%>
</head>
</html>