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
	int rs1;
	String user_id="";
	user_id= (String)session.getAttribute("id");
	if(user_id==null||user_id.equals(""))
		response.sendRedirect("UnloginMain.jsp");
	
	int maxnum;
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
	String query = "SELECT MAX(Cart_Num) FROM CART";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	maxnum = Integer.parseInt(rs.getString(1));
	maxnum++;
	
	query = "INSERT INTO CART VALUES(?,?,?,?)";
	pstmt = conn.prepareStatement(query);
	pstmt.setString(1,user_id);
	pstmt.setString(2,Integer.toString(maxnum));
	pstmt.setString(3,request.getParameter("Delivery_Info"));
	pstmt.setString(4,request.getParameter("Ammount"));
	try{
		
		rs1 = pstmt.executeUpdate();
		System.out.println(rs1 + " row inserted.");
		}catch(SQLException ex2) {
			System.err.println("sql error = " + ex2.getMessage());
			System.exit(1);
		}
	
	response.sendRedirect("cart.jsp");
	
%>

</body>
</html>