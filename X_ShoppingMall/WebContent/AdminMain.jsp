<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page language="java" import="java.text.*, java.sql.*, java.io.*, java.time.LocalDateTime" %>
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
	<h4>Item Ordering</h4>
	<button type="button" onclick="location.href='AdminOrder.html'">To Ordering Menu</button>
	<h4>Out of Stock Items</h4>
	<%
	
	//select * from CUSTOMER,CART WHERE CUSTOMER.ID=CART.Customer_ID and CUSTOMER.ID='asdf';
	String query = "SELECT Item_Name FROM ITEM WHERE ITEM.Stock=0";
	
	System.out.println(query);
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	//System.out.println(rs.getString(1));
	out.println("<table border=\"1\">");
	
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>"+rs.getString(1)+"</td>");
		out.println("</tr>");
	}
	out.println("</table>");
	
	pstmt.close();
	%>
	<h4>Revenue</h4>
	<h5>Total Revenue</h5>
	<% 
	LocalDateTime now = LocalDateTime.now();
	//now.getMonthValue(), now.getDayOfMonth(),now.getYear()
	
	query = "SELECT ITEM.Price, BUYING_AMMOUNT.AMMOUNT  FROM BUYING, BUYING_AMMOUNT, ITEM " 
			+ " WHERE BUYING.Buying_Num=BUYING_AMMOUNT.Buying_Num AND BUYING.Item_Num=ITEM.Item_Num";
	int sum = 0;
	
	System.out.println(query);
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	//System.out.println(rs.getString(1));
	while(rs.next()){
		sum += Integer.parseInt(rs.getString(1));
	}
	out.println("<h5>");
	out.println(sum);
	out.println("</h5>");
	%>
	<h5>This Month's Revenue</h5>
	<% 
	query = "SELECT ITEM.Price, BUYING_AMMOUNT.AMMOUNT  FROM BUYING, BUYING_AMMOUNT, ITEM " 
	+ " WHERE BUYING.Buying_Num=BUYING_AMMOUNT.Buying_Num AND BUYING.Item_Num=ITEM.Item_Num AND "
	+ "YEAR(Buying_Date)=" + now.getYear() +  " AND MONTH(Buying_Date)=" +now.getMonthValue();
	sum = 0;
	
	System.out.println(query);
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	//System.out.println(rs.getString(1));
	while(rs.next()){
		sum += Integer.parseInt(rs.getString(1)) * Integer.parseInt(rs.getString(2));
	}
	out.println("<h5>");
	out.println(sum);
	out.println("</h5>");
	%>
	<h5>Today's Revenue</h5>
	<% 
	query = "SELECT ITEM.Price, BUYING_AMMOUNT.AMMOUNT  FROM BUYING, BUYING_AMMOUNT, ITEM " 
			+ " WHERE BUYING.Buying_Num=BUYING_AMMOUNT.Buying_Num AND BUYING.Item_Num=ITEM.Item_Num AND "
			+ "YEAR(Buying_Date)=" + now.getYear() +  " AND MONTH(Buying_Date)=" +now.getMonthValue()
			+ " AND DAY(Buying_Date)=" + now.getDayOfMonth();
	sum = 0;
	
	System.out.println(query);
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	//System.out.println(rs.getString(1));
	while(rs.next()){
		sum += Integer.parseInt(rs.getString(1));
	}
	out.println("<h5>");
	out.println(sum);
	out.println("</h5>");
	%>
</body>
</html>