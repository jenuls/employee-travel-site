<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.io.*" %>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="jxl.*" %>
<%@ page language="java" import="jxl.write.*" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="java.text.DecimalFormat" %>
<%@ page language="java" import="connect.ConnectToMySql" %>
<%@ page language="java" import="java.net.URLEncoder"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	ConnectToMySql connObj = new ConnectToMySql();  
	ArrayList<String> al01 = new ArrayList<String>();
	ArrayList<String> al02 = new ArrayList<String>();
	ArrayList<String> al03 = new ArrayList<String>();
	ArrayList<String> al04 = new ArrayList<String>();
	ArrayList<String> al05 = new ArrayList<String>();
	ArrayList<String> al06 = new ArrayList<String>();
	ArrayList<String> al07 = new ArrayList<String>();
	Calendar thisDate=Calendar.getInstance(); 
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
	String relatives = "";
	
	String id ="";
	String age ="";
	String birthday ="";
	
	String[] arr01 = null;
	String[] arr02 = null; 
	String[] arr03 = null; 
	String[] arr04 = null;
	String[] arr05 = null;
	
	String travelNoTemp = request.getParameter("travelNo").toString();
	al01 = connObj.select("SELECT A1.travelName, A2.travelNo, A2.employeeNo, A2.name, A2.money FROM travel A1, registration A2 WHERE (A1.travelNo = A2.travelNo) and A2.temp ='1' and A2.travelNo='" + travelNoTemp + "' order by A2.travelNo ASC,A2.employeeNo ASC"); 
	for(int i=0;i<al01.size();i++){ 
		arr01 = al01.get(i).split(";");
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
	
		al06 = connObj.select("SELECT idNumber,birthday FROM personaldata WHERE employeeNo ='" + arr01[2] + "' and name='" + arr01[3] + "'");
		
		if(al06.size()!=0){
			arr05 = al06.get(0).split(";");
			if(id.equals("")){
				id = arr05[0];
			}else{
				id = id + ";" + arr05[0];
			}
			if(age.equals("")){
				age = String.valueOf(Integer.parseInt(String.valueOf(thisDate.get(Calendar.YEAR)))- Integer.parseInt(arr05[1].substring(0,4)));
			}else{
				age = age + ";" + String.valueOf(Integer.parseInt(String.valueOf(thisDate.get(Calendar.YEAR)))- Integer.parseInt(arr05[1].substring(0,4)));
			}
			if(birthday.equals("")){
				birthday = arr05[1];
			}else{
				birthday = birthday + ";" + arr05[1];
			}
			if(relatives.equals("")){
				relatives = "員工";
			}else{
				relatives = relatives + ";" + "員工";
			}			
		}else{
			al07 = connObj.select("SELECT idNumber,birthday,relatives FROM relativesdata WHERE employeeNumber ='" + arr01[2] + "' and name='" + arr01[3] + "'");
			arr05 = al07.get(0).split(";");
			if(id.equals("")){
				id = arr05[0];
			}else{
				id = id + ";" + arr05[0];
			}
			if(age.equals("")){
				age = String.valueOf(Integer.parseInt(String.valueOf(thisDate.get(Calendar.YEAR)))- Integer.parseInt(arr05[1].substring(0,4)));
			}else{
				age = age + ";" + String.valueOf(Integer.parseInt(String.valueOf(thisDate.get(Calendar.YEAR)))- Integer.parseInt(arr05[1].substring(0,4)));
			}
			if(birthday.equals("")){
				birthday = arr05[1];
			}else{
				birthday = birthday + ";" + arr05[1];
			}
			if(relatives.equals("")){
				relatives = arr05[2];
			}else{
				relatives = relatives + ";" + arr05[2];
			}			
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

	String[] idArr = id.split(";");
	String[] ageArr = age.split(";");
	String[] birthdayArr = birthday.split(";");	
	
	String[] relativesArr = relatives.split(";");
	
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


try {
 	response.reset();     
  response.setHeader("Content-disposition","attachment; filename=" + travelNoTemp + ".xls");
  OutputStream os = response.getOutputStream();
  
	//產生一檔案讓程式匯出
	//WritableWorkbook writableWorkBook = Workbook.createWorkbook(new File("d:\\text.xls"));
	WritableWorkbook writableWorkBook = Workbook.createWorkbook(os);
	//在檔案中開啟一新的WorkBook
	WritableSheet writableSheet = writableWorkBook.createSheet("明細表11111", 1);
	//設定寫入儲存格的字型大小
	WritableFont chFont12w = new WritableFont(WritableFont.createFont("新細明體"), 12);
	WritableCellFormat writableCellFormat = new WritableCellFormat(chFont12w);


	
	//設定cell寬度
	writableSheet.setColumnView(0, 15);
	writableSheet.setColumnView(1, 35);
	writableSheet.setColumnView(2, 15);
	writableSheet.setColumnView(3, 15);
	writableSheet.setColumnView(4, 10);
	writableSheet.setColumnView(5, 15);
	writableSheet.setColumnView(6, 10);
	writableSheet.setColumnView(7, 15);
	writableSheet.setColumnView(8, 15);
	writableSheet.setColumnView(9, 15);
	writableSheet.setColumnView(10, 15);
	writableSheet.setColumnView(11, 15);
	writableSheet.setColumnView(12, 10);
	
	
	//寫入儲存格A1
	Label label = new Label(0, 0, "行程代碼",writableCellFormat);
	writableSheet.addCell(label);
	label = new Label(1, 0, "行程名稱",writableCellFormat);
	writableSheet.addCell(label);
	label = new Label(2, 0, "工號",writableCellFormat);
	writableSheet.addCell(label);
	label = new Label(3, 0, "姓名",writableCellFormat);
	writableSheet.addCell(label);
	label = new Label(4, 0, "關係",writableCellFormat);
	writableSheet.addCell(label);
	label = new Label(5, 0, "身分證字號",writableCellFormat);
	writableSheet.addCell(label);
	label = new Label(6, 0, "年齡",writableCellFormat);
	writableSheet.addCell(label);
	label = new Label(7, 0, "生日",writableCellFormat);
	writableSheet.addCell(label);
	label = new Label(8, 0, "房間",writableCellFormat);
	writableSheet.addCell(label);
	label = new Label(9, 0, "餐桌",writableCellFormat);
	writableSheet.addCell(label);
	label = new Label(10, 0, "車輛",writableCellFormat);
	writableSheet.addCell(label);
	label = new Label(11, 0, "費用",writableCellFormat);
	writableSheet.addCell(label);
	
	String temp1 = "";
	int temp2 = 0;

	for(int i=0;i<travelNoArr.length;i++){
	/*
		if(i==0){
			temp1 = employeeNoArr[i];
			temp2 = 0;
		}else{
			if(!temp1.equals(employeeNoArr[i])){
				temp2 = temp2 + 1;
			}
			temp1 = employeeNoArr[i];
		}
		
		if(temp2%2==0){
			writableCellFormat.setBackground(jxl.format.Colour.WHITE);
		}else{
			writableCellFormat.setBackground(jxl.format.Colour.YELLOW);
		}
		*/
		
		//writableCellFormat.setBackground(jxl.format.Colour.GRAY_50,jxl.format.Pattern.PATTERN1);
		//temp = employeeNoArr[i];
		label = new Label(0, i+1, travelNoArr[i],writableCellFormat);
		writableSheet.addCell(label);
		label = new Label(1, i+1, travelNameArr[i],writableCellFormat);
		writableSheet.addCell(label);
		label = new Label(2, i+1, employeeNoArr[i],writableCellFormat);
		writableSheet.addCell(label);
		label = new Label(3, i+1, namesArr[i],writableCellFormat);
		writableSheet.addCell(label);
		label = new Label(4, i+1, relativesArr[i],writableCellFormat);
		writableSheet.addCell(label);
		label = new Label(5, i+1, idArr[i],writableCellFormat);
		writableSheet.addCell(label);
		label = new Label(6, i+1, ageArr[i],writableCellFormat);
		writableSheet.addCell(label);
		label = new Label(7, i+1, birthdayArr[i],writableCellFormat);
		writableSheet.addCell(label);
		label = new Label(8, i+1, roomNoArr[i] + "【" + roomDetailNoArr[i] + "】",writableCellFormat);
		writableSheet.addCell(label);
		label = new Label(9, i+1, deskNoArr[i] + "【" + deskDetailNoArr[i] + "】",writableCellFormat);
		writableSheet.addCell(label);
		label = new Label(10, i+1, vehicleNoArr[i] + "【" + vehicleDetailNoArr[i] + "】",writableCellFormat);
		writableSheet.addCell(label);
		label = new Label(11, i+1, String.valueOf(Integer.parseInt(moneyArr[i]) + Integer.parseInt(travelMoneyArr[i])),writableCellFormat);
		writableSheet.addCell(label);
	}
	
	writableWorkBook.write();
	writableWorkBook.close();
	os.flush();
  os.close();
  }
finally {
  
}

response.sendRedirect("adminTravelList.jsp");

%>
</head>
</html>