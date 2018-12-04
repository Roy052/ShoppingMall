<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page language="java" import="java.text.*, java.sql.*, java.io.*" %>
<html>
<head>
 	<link type="text/css" href="style2.css" rel="stylesheet" />
<meta charset="UTF-8">
<title>search</title>
</head>
<body>
	<div id="top-bar" class="container">
		<div class="row">
			<a href="Main.jsp?uname=<%=request.getParameter("uname")%>"><img src="/logo.png" alt=""></a>
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
	System.out.println(request.getParameter("search"));
	
	String sql= "select Item_Name,Item_Num from ITEM where ITEM_Name like '%"+request.getParameter("search")+"%'";
	pstmt=conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	out.println("<table border=\"1\">");
	out.println("<th>" + "Item_name" + "</th>");
	while(rs.next()){
		out.println("<tr>");
		out.println("<td><a href='ItemInfo.jsp?Item_Num=" + rs.getString(2)+ "'>" + rs.getString(1) + "</a></td>");
		out.println("</tr>");
	}
	out.println("</table>");

	%>
</body>
</html>