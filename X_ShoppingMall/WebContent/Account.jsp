<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page language="java" import="java.text.*, java.sql.*, java.io.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>UNMI : Account</title>
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
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String dbName = "Team4_ShoppingMall";
	String id = "root";
	String pw = "password";
	String user_id="";
	user_id= (String)session.getAttribute("id");
	if(user_id==null||user_id.equals(""))
		response.sendRedirect("UnloginMain.jsp");
	
	url = "jdbc:mysql://localhost/" + dbName;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,id,pw);
		if(conn==null)
			System.out.println("logincheck연결 실패");
		else
			System.out.println("logincheck연결 성공");
	}catch(ClassNotFoundException e){
		e.printStackTrace();
	}catch(SQLException se){
		se.printStackTrace();
	}catch(Exception ex){
		ex.printStackTrace();
	}
	
	String query = "SELECT * FROM CUSTOMER WHERE" 
			+ " ID='" + user_id + "'";
	System.out.println(query);
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	rs.next();
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	out.println("<th>" + "Attribute" + "</th>");
	out.println("<th>" + "Value" + "</th>");
	for(int i=1; i<= cnt; i++){
		out.println("<tr>");
		out.println("<td>" + rsmd.getColumnName(i) + "</td>");
		out.println("<td>" + rs.getString(i) + "</td>");
	
		out.println("</tr>");
	}
	out.println("</table>");
	
	%>
	<button type="button" onclick="location.href='changeinf1.jsp'">Change Information</button>
	<button type="button" onclick="location.href='changepwd.html'">Change Password</button>
</body>
</html>