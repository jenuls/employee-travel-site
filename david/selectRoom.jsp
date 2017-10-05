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
	String srvRoot = request.getContextPath();
	String empNo = session.getAttribute("empNo").toString();
	String travelNo = request.getParameter("travelNo");
	String flag = request.getParameter("flag");
	String travelName = new String(request.getParameter("travelName").getBytes("ISO-8859-1"),"UTF-8");
	TravelBean tb = new TravelBean();
	
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
	

	<title>選擇房間</title>

</head>
<body>
<form name="myForm" action="travelPlanDetailAction.jsp" method="post">
<input id='travelNo' name='travelNo' type='hidden' value='<%=travelNo%>'>
<input id='travelName' name='travelName' type='hidden'  value='<%=travelName%>'>
<input id='flag' name='flag' type='hidden' value='<%=flag%>'>
<input id="roomNo" type='hidden'  value="">



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
				<div align="right" class="smallgraytext" style="padding:9px;">
        	</div>
			</div>
			<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
			<div id="contenttext01">
            <div style="padding:0px;vertical-align:middle">
                <span class='titletext'><%=travelName%>-房間清單</span>
                <br />
            </div>
            <div style="border:1px solid #333333;width:100%"></div>
            <div class="bodytext" style="padding:1px" align="justify">
            	<table style='width:50%' >
<%   
	 Collection col = tb.getRoomList(travelNo);         
     Iterator it = col.iterator();
	 HashMap hm = null , hm2 = null;
	 String registerName = "";
	 while(it.hasNext() )
	 {
		 hm = (HashMap)it.next();
		 String roomNo = strUtil.getPara( hm.get("roomNo") );
		 Collection col2 = tb.getMemberOfRoom(travelNo ,roomNo);
		 Iterator it2 = col2.iterator();
		 registerName = "";
		 while(it2.hasNext() )
	 	 {
		  	hm2 = (HashMap)it2.next();
		    if(registerName.equals("") )
			{	
				registerName =strUtil.getPara( hm2.get("MemberName") ); //登記者
			}else
			{
				registerName = registerName +" &nbsp;&nbsp;&nbsp;  , &nbsp;&nbsp;&nbsp;  " + strUtil.getPara( hm2.get("MemberName") ); 
			}
			 
		 }  //end of while(it2.hasNext() )
%>              
                  <tr>
                      <td width="12%" style='width:20%'><span><a href='#' onclick="sendData('<%=roomNo%>');"><%=roomNo%></a></span></td>  
                      <td width="88%" style='width:80%'><span><%=registerName%></span></td>
                     
                  </tr>
                   <tr></tr>
<%               
     } //end of for(int i=0;i<al01.size();i++)
 %>     
            	</table>
        	</div>
            <div style="font-size:65%">
                <input type='button' id="returnRegisterPage" onclick='goToRegisterPage();' value='返回報名頁'/><input id="return" type='button' onclick='returnFn();' value='返回' />
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

<script>
  //create XMLHttpRequest Object
  var request = null;
  request = creatRequestObj();
  if (request == null){
    //無法取得XMLHttpRequest物件時發出警告
    alert("Error creating request object!");
  }
  
   $(function() 
	{
			if($(":hidden[name='isAdmin']").val() == "false")
			{
				$("[admin='true']").hide(); 	
			}
  			$( "input:button").button();
			
			if($(":hidden[name='flag']").val() == "1")  //表示從報名頁連進來，
			{
				$(":button#return").hide(); //隱藏[返回」按鈕
			
			}else if($(":hidden[name='flag']").val() == "0")
			{
				 //不是從報名頁進來，所以將[回到報名頁]的按鈕隱藏
				$(":button#returnRegisterPage").hide();
			}
	});

  //Send data to Server
  function sendData(roomNo) 
  {  
		document.getElementById("roomNo").value = roomNo;
		var url = "<%=srvRoot%>/Ajax?action=checkRoomLock&travelNo=" + document.getElementById("travelNo").value + "&roomNo=" + roomNo;
		$.post(url, "" , function(reponse)
		{
			 if(reponse=="1"){
			   alert("目前有使用者點選此房間，請稍後再進入，謝謝。");
			  }else{
				window.location.href = "roomDetail.jsp?flag=" + document.getElementById("flag").value + "&travelName=" + document.getElementById("travelName").value + "&travelNo=" + document.getElementById("travelNo").value + "&roomNo=" + document.getElementById("roomNo").value;
			  }
		});
	

  }


 	
	
	function goToRegisterPage(){
		window.location.href="travelPlanDetail.jsp?travelNo=" + document.forms[0].travelNo.value;
	}
	function returnFn(){
		window.location.href="registeredTravel.jsp";
	}
</script>
