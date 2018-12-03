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
	
	//error detecting
	if(Integer.parseInt(request.getParameter("Ammount")) < 0){
		out.println("<script>");
		out.println("alert('Ammount is negative number. Unacceptable condition.')");
		out.println("location.href='AdminMain.jsp'");
		out.println("</script>");
	}
	
	String query = "";
	int current_Stock = 0;
	
	query = "SELECT Stock FROM ITEM WHERE Item_Num = " + request.getParameter("Item_Num");
	pstmt=conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	if(rs.next())
		current_Stock = Integer.parseInt(rs.getString(1));
	
	String sql= "UPDATE ITEM SET Stock=? WHERE Item_Num=?";
	pstmt=conn.prepareStatement(sql);
	
	pstmt.setString(1, Integer.toString(current_Stock + Integer.parseInt(request.getParameter("Ammount"))));
	pstmt.setString(2,request.getParameter("Item_Num"));
	
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
	response.sendRedirect("AdminMain.jsp");
	%>
</body>
</html>