<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page language="java" import="java.text.*, java.sql.*, java.io.*" %>
<html>
<head>
<style>
body{
        margin:0;
    }
    #top-bar{
	background-color:#fff;
	padding:10px;
	margin: 20px auto -22px auto;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
}
#top-bar .user-menu {
	margin: 0;
	padding: 0;
	list-style: none;
}
#top-bar .user-menu li {
	display: inline-block;
	*display: inline;
	zoom: 1;
	border-right: 1px solid #eee;
	padding: 5px 12px;
}
#top-bar .user-menu li:last-child{
	border-right:0;
}
#top-bar input{
		*padding-right:0 !important;
	}
	.navbar-inner.main-menu{
		border-bottom:0 !important;
	}
	section.homepage-slider{
		display:none;
	}
	.account.pull-right{
		width:100%;
		text-align:center;
	}
    </style>
<meta charset="UTF-8">
<title>We Sell Future</title>
</head>
<body>		
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
							<li><a href="register.html">Register</a></li>		
						</ul>
					</div>
				</div>
			</div>
		</div>
				
	<%
	String url;
	Connection conn=null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String dbName = "a";
	String id = "root";
	String pw = "Asdf1234";
	
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