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
	}%>
	<h4>Shopping Cart</h4>
	<%
	//select * from CUSTOMER,CART WHERE CUSTOMER.ID=CART.Customer_ID and CUSTOMER.ID='asdf';
	String query = "SELECT Item_Name, Price, ADD_CART.Ammount FROM CUSTOMER,CART,ADD_CART,ITEM WHERE" 
		+ " CUSTOMER.ID='" + user_id + "' AND CART.Cart_num=ADD_CART.Cart_Num AND " 
		+ "CUSTOMER.ID=ADD_CART.Customer_ID AND ADD_CART.Item_Num=ITEM.Item_Num";
	int sum = 0;
	
	System.out.println(query);
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	//System.out.println(rs.getString(1));
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
		out.println("<td><a href='DeletingAddCart.jsp?Item_Name=" + rs.getString(1) + "'>Delete</a></td>");
		out.println("</tr>");
		sum += Integer.parseInt(rs.getString(2)) * Integer.parseInt(rs.getString(3));
	}
	out.println("</table>");
	
	out.println("<h4>");
	out.println("Total Price : " + sum);
	out.println("</h4>");
	pstmt.close();
	%>
	
	<button type="button" onclick="location.href='Buying.jsp' ">Purchase of Goods</button>
	<button type="button" onclick="location.href='Buying_list.jsp' ">Show purchase list</button>
</body>
</html>