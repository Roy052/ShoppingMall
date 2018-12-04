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
	String dbName = "Team4_ShoppingMall";
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
			+ " ID='" + request.getParameter("uname") + "'";
		System.out.println(query);
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		if(rs.next()){
			out.println("<script>");
			out.println("alert('id is overlap. choose another id')");
			out.println("location.href='signup.html'");
			out.println("</script>");
		}
		else{
	String sql = "INSERT INTO CUSTOMER VALUES(?,?,?,?,?,?,?,?)";
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1,request.getParameter("name"));
	pstmt.setString(2,request.getParameter("uname"));
	pstmt.setString(3,request.getParameter("psw"));
	pstmt.setString(4,request.getParameter("address"));
	pstmt.setString(5,request.getParameter("tel"));
	pstmt.setString(6,request.getParameter("sex"));
	if(!(request.getParameter("age").equals(null)||request.getParameter("age").equals(""))){
		pstmt.setInt(7,Integer.parseInt(request.getParameter("age")));
	}
	else{
		pstmt.setInt(7,0);
	}
	pstmt.setString(8,request.getParameter("job"));
	
	try{
	
	int res= pstmt.executeUpdate();
	System.out.println(res+" row inserted.");
	}catch(SQLException ex2) {
		System.err.println("sql error = " + ex2.getMessage());
		System.exit(1);
	}
	
	int maxnum = 0;
	query = "SELECT MAX(Cart_Num) FROM CART";
	pstmt=conn.prepareStatement(query);
	ResultSet res1=pstmt.executeQuery();
	if(res1.next()){
		maxnum = Integer.parseInt(res1.getString(1));
		maxnum++;
	}
	else maxnum = 1;
	
	sql = "INSERT INTO CART VALUES(?,?,?,?)";
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1,request.getParameter("uname"));
	pstmt.setInt(2,maxnum);
	pstmt.setString(3,request.getParameter("address"));
	pstmt.setString(4,"0");
	
	try{
	
	int res= pstmt.executeUpdate();
	System.out.println(res+" row inserted.");
	}catch(SQLException ex2) {
		System.err.println("sql error = " + ex2.getMessage());
		System.exit(1);
	}
	/*
	System.out.println(request.getParameter("name")+ request.getParameter("uname")+
request.getParameter("psw")+ request.getParameter("address")+ 
request.getParameter("tel")+ request.getParameter("sex")+ request.getParameter("age")+ request.getParameter("job"));
	*/
	response.sendRedirect("register.html");
		}
	%>
</body>
</html>