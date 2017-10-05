<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.sql.ResultSet" %>
<%@ page language="java" import="connect.ConnectToMySql" %>
<%@ page language="java" import="java.io.*" %>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="jxl.*" %>
<%@ page language="java" import="jxl.write.*" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="java.text.DecimalFormat" %>
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

//產生一檔案讓程式匯出
WritableWorkbook writableWorkBook = Workbook.createWorkbook(new File("d:\\webexp\\text.xls"));
//在檔案中開啟一新的WorkBook
WritableSheet writableSheet = writableWorkBook.createSheet("明細表", 1);
//設定寫入儲存格的字型大小
WritableFont chFont12w = new WritableFont(WritableFont.createFont("新細明體"), 12);
WritableCellFormat writableCellFormat = new WritableCellFormat(chFont12w);
//寫入儲存格A1
Label label = new Label(0, 0, "測試寫入成功!",writableCellFormat);
//設定寫入數字的型式，取到小數點以下3位，若小於1要顯示0
NumberFormat nf = new NumberFormat("############0.###");
WritableCellFormat wcfN = new WritableCellFormat(nf);
/寫入儲存格B1
jxl.write.Number labelNF = new jxl.write.Number(1, 0, 3.1415926, wcfN);
………
//寫入EXCEL檔案
writableWorkBook.write();
writableWorkBook.close();


 %>
</head>
</html>