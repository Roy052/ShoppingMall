<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page language="java" import="java.text.*, java.sql.*, java.io.*" %>
<html>
<head>
<link type="text/css" href="style2.css" rel="stylesheet" />
<meta charset="UTF-8">
<title>We Sell Future</title>
</head>
<body>		
	<div id="top-bar" class="container">
		<div class="row">
			<a href="Main.jsp"><img src="/logo.png" alt=""></a>
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
	
	String user_id ="";
	user_id=(String)session.getAttribute("id");
	if((user_id==null||user_id.equals("")))
		response.sendRedirect("UnloginMain.jsp");
	
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
	String query = "SELECT i.Item_Name FROM BELONG b, CATEGORY c, ITEM i WHERE b.Category_Num=c.Category_Num and b.Item_Num=i.Item_Num and c.Category_Name='" 
			+ request.getParameter("cate-name") + "'";
	System.out.println(query);
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	out.println("<th>" + "Item_name" + "</th>");
	while(rs.next()){
	for(int i=1; i<= cnt; i++){
		out.println("<tr>");
		out.println("<td><a href='ItemInfo.jsp?Item_Name=" + rs.getString(i)+ "'>" + rs.getString(i) + "</a></td>");
		out.println("</tr>");
	}
	}
	out.println("</table>");
	%>
	
	
</body>
</html>