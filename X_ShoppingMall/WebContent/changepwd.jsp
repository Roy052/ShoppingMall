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
	
	String query = "SELECT PW FROM CUSTOMER WHERE" 
			+ " ID='" + user_id+"'";
		System.out.println(query);
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		if(rs.next()){
			if(!rs.getString(1).equals(request.getParameter("old-pwd"))){
				out.println("<script>alert('password is not correct');</script>");
				out.println("<script>location.href='UnloginMain.jsp';</script>");
			}
			else{
				out.println(rs.getString(1));
				String sql= "UPDATE CUSTOMER SET PW=? WHERE ID=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1,request.getParameter("new-pwd"));
				pstmt.setString(2,user_id);
				
				try{
				int res= pstmt.executeUpdate();
				System.out.println(res+" row updated.");
				}catch(SQLException ex2) {
					System.err.println("sql error = " + ex2.getMessage());
					System.exit(1);
				}
				response.sendRedirect("Main.jsp");
			}
		}
		else {
			System.out.println("not user");
			response.sendRedirect("UnloginMain.jsp");
		}
	
	//pageContext.forward("Main.jsp");
	%>
</body>
</html>