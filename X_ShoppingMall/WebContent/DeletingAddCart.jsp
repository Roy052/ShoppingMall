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
	
	int cartnum = 0;
	String dbName = "Team4_ShoppingMall";
	String id = "knu";
	String pw = "comp322";
	int item_num = 0;
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
	String query = "SELECT Item_Num FROM ITEM WHERE ITEM.Item_Name='" + request.getParameter("Item_Name") + "'";
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	if(rs.next()){
		System.out.println(query);
		System.out.println(rs.getString(1));
		item_num = Integer.parseInt(rs.getString(1));
	}
	
	query = "DELETE FROM ADD_CART WHERE Customer_ID='" + user_id + "'"
	+ " AND Item_Num='" + item_num + "'";
	pstmt = conn.prepareStatement(query);
		try{
			rs1 = pstmt.executeUpdate();
			System.out.println(rs1 + " row deleted.");
			}catch(SQLException ex2) {
				System.err.println("sql error = " + ex2.getMessage());
				System.exit(1);
			}
		response.sendRedirect("cart.jsp");
	
%>

</body>
</html>