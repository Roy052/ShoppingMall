<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page language="java" import="java.text.*, java.sql.*, java.io.*" %>
<html>
<head>
 	<link type="text/css" href="style.css" rel="stylesheet" />
	<style>
	ul{
	list-style:none;
	padding-left:0px;}
</style>
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
	else if(user_id.equals("Admin"))
		response.sendRedirect("AdminMain.jsp");
	else
		out.println("user id : "+user_id);
	%>		
		<div id="top-bar" class="container">
			<div class="row">
			<a href="Main.jsp"><img src="/logo.png" alt=""></a>
				<div class="span4">
					<form action="search.jsp">
						<input type="text" class="" Placeholder="eg. Apple" name="search">
						 <button type="submit">search</button>
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
				<ul>
					<li id='fruit'>Fruit/Nut</li>
					<li id="vegetable">vegetable</li>
					<li id="rice">rice</li>
				</ul>
				<script type="text/javascript">
				$('#fruit').hover(
						function() {
							$(this).append($("<span><li>&emsp;&emsp;&emsp;&emsp;1. <a href='category.jsp?cate-name=apple/bear'> apple/bear  </a></li></span>"));
							$(this).append($("<span><li>&emsp;&emsp;&emsp;&emsp;2. <a href='category.jsp?cate-name=persimmons'> persimmons  </a></li></span>"));
							$(this).append($("<span><li>&emsp;&emsp;&emsp;&emsp;3. <a href='category.jsp?cate-name=kiwi/chamdari'> kiwi/chamdari</a></li></span>"));
						}, 
						function() {
							$(this).find("span:last").remove();
							$(this).find("span:last").remove();
							$(this).find("span:last").remove();
						});
				$('#vegetable').hover(
						function() {
							$(this).append($("<span><li>&emsp;&emsp;&emsp;&emsp;1. <a href='category.jsp?cate-name=boosting/spinach'>  boosting/spinach  </a></li></span>"));
							$(this).append($("<span><li>&emsp;&emsp;&emsp;&emsp;2. <a href='category.jsp?cate-name=bean/pean_sprouts'>  bean/pean_sprouts  </a></li></span>"));
							$(this).append($("<span><li>&emsp;&emsp;&emsp;&emsp;3. <a href='category.jsp?cate-name=lettuce/cracker/ssam'>  lettuce/cracker/ssam </a></li></span>"));
						}, 
						function() {
							$(this).find("span:last").remove();
							$(this).find("span:last").remove();
							$(this).find("span:last").remove();
						});
				$('#rice').hover(
						function() {
							$(this).append($("<span><li>&emsp;&emsp;&emsp;&emsp;1. <a href='category.jsp?cate-name=bean/bori'>  bean/bori  </a></li></span>"));
							$(this).append($("<span><li>&emsp;&emsp;&emsp;&emsp;2. <a href='category.jsp?cate-name=glutin_rice/rice/black'>  glutin_rice/rice/black  </a></li></span>"));
							$(this).append($("<span><li>&emsp;&emsp;&emsp;&emsp;3. <a href='category.jsp?cate-name=millet'>  millet </a></li></span>"));
						}, 
						function() {
							$(this).find("span:last").remove();
							$(this).find("span:last").remove();
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
	String dbName = "Team4_ShoppingMall";
	String id = "root";
	String pw = "password";
	int num=-1;
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
	
	String sql= "select count(Buying_Num) from BUYING where BUYING.Customer_ID='"+user_id+"'";
	pstmt=conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	if(rs.next())
		 num = Integer.parseInt(rs.getString(1));
	else{
		System.out.println("error");
		System.exit(1);
	}
	
	if(num==0){
	sql= "select b.Item_Num,Item_Name from BUYING b, ITEM i where i.Item_Num=b.Item_Num group by b.Item_Num order by count(b.Item_Num) desc limit 3";
	pstmt=conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	out.println("<table border=\"1\">");
	out.println("<th>" + "recommend goods" + "</th>");
	while(rs.next()){
		out.println("<tr>");
		out.println("<td><a href='ItemInfo.jsp?Item_Num=" + rs.getString(1)+ "'>" + rs.getString(2) + "</a></td>");
		out.println("</tr>");
	}
	out.println("</table>");
	}
	%>
	
</body>
</html>