<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page language="java" import="java.text.*, java.sql.*, java.io.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>UNMI : Change Information</title>
</head>
<body>
<%
	String url;
	Connection conn=null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String dbName = "team4";
	String id = "knu";
	String pw = "comp322";
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
	/*
	String sql = "UPDATE CUSTOMER SET Name='"+request.getParameter("name")
	+"',Address='"+request.getParameter("Address")+"',Tel='"+request.getParameter("tel")
	+"',Sex='"+request.getParameter("sex")+"',Age="+request.getParameter("age")+",Job="
	+request.getParameter("job")+ "' WHERE ID='"+request.getParameter("uname");*/
	String sql= "UPDATE CUSTOMER SET Name=?,Address=?,Tel=?,Sex=?,Age=?,Job=? WHERE ID=?";
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1,request.getParameter("name"));
	pstmt.setString(2,request.getParameter("address"));
	pstmt.setString(3,request.getParameter("tel"));
	pstmt.setString(4,request.getParameter("sex"));
	if(!request.getParameter("age").equals(null))
		pstmt.setInt(5,Integer.parseInt(request.getParameter("age")));
	else
		pstmt.setInt(5,0);
	pstmt.setString(6,request.getParameter("job"));
	pstmt.setString(7,user_id);
	
	try{
	int res= pstmt.executeUpdate();
	System.out.println(res+" row updated.");
	}catch(SQLException ex2) {
		System.err.println("sql error = " + ex2.getMessage());
		System.exit(1);
	}
	/*
	System.out.println(request.getParameter("name")+request.getParameter("address")+ 
	request.getParameter("tel")+ request.getParameter("sex")+ request.getParameter("age")
	+ request.getParameter("job") + user_id);*/
	/*pageContext.forward("Main.jsp");*/ 
	response.sendRedirect("Main.jsp");
	%>
</body>
</html>