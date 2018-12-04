<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page language="java" import="java.text.*, java.sql.*, java.io.*, java.time.LocalDateTime" %>
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
	
	String query = "";
	int maxnum = 0;
	query = "SELECT MAX(Buying_Num) FROM BUYING";
	pstmt=conn.prepareStatement(query);
	ResultSet res1=pstmt.executeQuery();
	if(res1.next()){
		maxnum = Integer.parseInt(res1.getString(1));
		maxnum++;
	}
	else maxnum = 1;
	
	//Search ADD_CART to find buying list
	query = "SELECT ADD_CART.Item_Num, ADD_CART.Ammount, ITEM.Stock FROM ADD_CART, ITEM WHERE " 
			+ " ADD_CART.Item_Num=ITEM.Item_Num AND " + "Customer_ID='" + user_id + "'";
	pstmt=conn.prepareStatement(query);
	rs = pstmt.executeQuery();
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();

	while(rs.next()){
			//which has enough stock
			if((Integer.parseInt(rs.getString(3)) - Integer.parseInt(rs.getString(2)))<0){
				out.println("<script>alert('This Item is out of stock');</script>");
				out.println("<script>location.href='cart.jsp';</script>");
			}
			else{
				//Find Shop which has enough ammount
				query = "SELECT Shop_Num, Ammount FROM DISPLAY WHERE Item_Num ="+rs.getString(1)+" and Ammount > " + rs.getString(2);
				System.out.println(query);
				pstmt = conn.prepareStatement(query);
				res1 = pstmt.executeQuery();
				if(!res1.next()){
					out.println("<script>alert('There is no shop to handle ammount');</script>");
					out.println("<script>location.href='cart.jsp';</script>");
				}
				else{
					//INSERT BUYING
					int shopnum = Integer.parseInt(res1.getString(1));
					LocalDateTime now = LocalDateTime.now();
					query = "INSERT INTO BUYING VALUES(?,?,?,?,?)";
					pstmt=conn.prepareStatement(query);
					pstmt.setString(1,Integer.toString(maxnum));
					pstmt.setString(2,user_id);
					pstmt.setString(3,rs.getString(1));
					pstmt.setString(4,Integer.toString(shopnum));
					System.out.println(now.getYear() + "-" + now.getMonthValue()
					+ "-" + now.getDayOfMonth());
					//now.getMonthValue(), now.getDayOfMonth(),now.getYear()
					pstmt.setString(5,now.getYear() + "-" + now.getMonthValue()
					+ "-" + now.getDayOfMonth());
					try{
						int res= pstmt.executeUpdate();
						System.out.println(res+" row updated.");
						}catch(SQLException ex2) {
							System.err.println("sql error = " + ex2.getMessage());
							System.exit(1);
					}
					
					System.out.println("BUYING ENDED");
					
					//INSERT BUYING_AMMOUNT
					query = "INSERT INTO BUYING_AMMOUNT VALUES(" + maxnum + "," + rs.getString(2) + ")";
					pstmt=conn.prepareStatement(query);
					try{
						int res= pstmt.executeUpdate();
						System.out.println(res+" row updated.");
						}catch(SQLException ex2) {
							System.err.println("sql error = " + ex2.getMessage());
							System.exit(1);
					}
					
					System.out.println("BUYING_AMMOUNT ENDED");
					
					//UPDATE DISPLAY
					query = "UPDATE DISPLAY SET Ammount=" + Integer.toString(Integer.parseInt(res1.getString(2)) - Integer.parseInt(rs.getString(2))) 
					+ " WHERE Shop_Num=" + shopnum + " AND Item_Num=" + rs.getString(1);
					pstmt=conn.prepareStatement(query);
					try{
						int res= pstmt.executeUpdate();
						System.out.println(res+" row updated.");
						}catch(SQLException ex2) {
							System.err.println("sql error = " + ex2.getMessage());
							System.exit(1);
					}
					
					System.out.println("DISPLAY ENDED");
					
					//UPDATE ITEM
					query = "UPDATE ITEM SET Stock=" 
					+ Integer.toString(Integer.parseInt(rs.getString(3)) - Integer.parseInt(rs.getString(2))) + 
					" WHERE Item_Num=" + rs.getString(1);
					pstmt=conn.prepareStatement(query);
					try{
						int res= pstmt.executeUpdate();
						System.out.println(res+" row updated.");
						}catch(SQLException ex2) {
							System.err.println("sql error = " + ex2.getMessage());
							System.exit(1);
					}
					
					System.out.println("ITEM ENDED");
					
					//DELETE ADD_CART
					query = "DELETE FROM ADD_CART WHERE Customer_ID='" + user_id 
					+ "' AND Item_Num=" + rs.getString(1);
					pstmt=conn.prepareStatement(query);
					try{
						int res= pstmt.executeUpdate();
						System.out.println(res+" row updated.");
						}catch(SQLException ex2) {
							System.err.println("sql error = " + ex2.getMessage());
							System.exit(1);
					}
					
					System.out.println("ADD_CART ENDED");
					
					maxnum++;
				}
			}
	}
	if(!rs.next())
		response.sendRedirect("cart.jsp");
	%>
</body>
</html>