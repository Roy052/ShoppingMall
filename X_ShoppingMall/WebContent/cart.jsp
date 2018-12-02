<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page language="java" import="java.text.*, java.sql.*, java.io.*" %>
<html>
<head>
 	<link type="text/css" href="style2.css" rel="stylesheet" />
<meta charset="UTF-8">
<title>UNMI : CART</title>
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
	}%>
	<%
	//select * from CUSTOMER,CART WHERE CUSTOMER.ID=CART.Customer_ID and CUSTOMER.ID='asdf';
	String query = "SELECT Customer_ID, Delivery_Info, Ammount FROM CUSTOMER,CART WHERE" 
		+ " ID='" + user_id + "' AND CUSTOMER.ID=CART.Customer_ID";
	int sum = 0;
	
	System.out.println(query);
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
		
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	
	for(int i=1;i<=cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>"+rs.getString(1)+"</td>");
		out.println("<td>"+rs.getString(2)+"</td>");
		out.println("<td>"+rs.getString(3)+"</td>");
		out.println("</tr>");
		sum += Integer.parseInt(rs.getString(3));
	}
	out.println("</table>");
	
	out.println("<h4>");
	out.println("Total Price : " + sum);
	pstmt.close();
	%>
	
	<button type="button" onclick="location.href='changeinf.jsp' ">Change Information</button>
</body>
</html>