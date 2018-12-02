<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page language="java" import="java.text.*, java.sql.*, java.io.*" %>
<html>
<head>
 	<link type="text/css" href="style.css" rel="stylesheet" />
<meta charset="UTF-8">

<script type = "text/javascript"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<title>We Sell Future</title>
</head>
<body>
	<%
	String user_id ="";
	user_id=(String)session.getAttribute("id");
	if(user_id==null||user_id.equals(""))
		response.sendRedirect("UnloginMain.jsp");
	else
		out.println("user id : "+user_id);
	%>		
		<div id="top-bar" class="container">
			<div class="row">
			<a href="Main.jsp"><img src="/logo.png" alt=""></a>
				<div class="span4">
					<form method="POST" class="search_form">
						<input type="text" class="" Placeholder="eg. Apple">
					</form>
					
				</div>
				<div class="span8">
					<div class="account pull-right">
						<ul class="user-menu">		
							<li><a href="Account.jsp">My Account</a></li>
							<li><a href="cart.jsp">Your Cart</a></li>					
							<li><a href="logout.jsp">Logout</a></li>		
						</ul>
					</div>
				</div>
			<div class="span8">
				<ul class="cate-menu">
					<li id='fruit'>Fruit/Nut</li>
					<li id="vegetable">vegetable</li>
					<li id="rice">rice</li>
				</ul>
				<script type="text/javascript">
				$('#fruit').hover(
						function() {
							$(this).append($("<span> apple</span>"));
						}, 
						function() {
							$(this).find("span:last").remove();
						});
				$('#vegetable').hover(
						function() {
							$(this).append($("<span> kiwi</span>"));
						}, 
						function() {
							$(this).find("span:last").remove();
						});
				$('#rice').hover(
						function() {
							$(this).append($("<span> bean</span>"));
						}, 
						function() {
							$(this).find("span:last").remove();
						});
				</script>
			</div>
		</div>
		</div>
				
	<%
	String url;
	Connection conn=null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String dbName = "team4";
	String id = "root";
	String pw = "password";
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost/" + dbName,id,pw);
		if(conn==null)
			System.out.println("연결 실패");
		else
			System.out.println("연결 성공");
	}catch(ClassNotFoundException e){
		e.printStackTrace();
	}catch(SQLException se){
		se.printStackTrace();
	}catch(Exception ex){
		ex.printStackTrace();
	}
	
	
	%>
	
</body>
</html>