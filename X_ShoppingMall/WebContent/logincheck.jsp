<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page language="java" import="java.text.*, java.sql.*, java.io.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>logincheck</title>
</head>
<body>
<%
	String url;
	Connection conn=null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String dbName = "team4";
	String id = "root";
	String pw = "password";
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
		+ " ID='" + request.getParameter("uname") +"' AND PW='" 
		+ request.getParameter("psw") + "'";
	System.out.println(query);
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	if(rs.next()){
		session.setAttribute("id",request.getParameter("uname"));
		System.out.println("User");
		pageContext.forward("Main.jsp");
	}
	else {
		System.out.println("not user");
		response.sendRedirect("register.html");
	}
	%>
</body>
</html>