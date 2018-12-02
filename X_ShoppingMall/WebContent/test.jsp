<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!-- [IMPORTANT] Complete your scripting. -->
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>COMP322003/004: Databases</title>
</head>
<body>
	<h2>Lab #9: Oracle-Tomcat Conjunction</h2>
<%
	//test
	String serverIP = "localhost";
	String strSID = "xe";
	String portNum = "1521";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	String user = "knu";
	String pass = "comp322";
	//Complete your code.
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs1, rs2, rs3;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	
	String query = "SELECT Fname, Minit, Lname FROM EMPLOYEE, DEPARTMENT, PROJECT, WORKS_ON "
			+ "WHERE DEPARTMENT.Dnumber = " 
			+ request.getParameter("q1_dnum") 
			+ " and EMPLOYEE.Dno = DEPARTMENT.Dnumber and EMPLOYEE.Salary >= "
			+ request.getParameter("q1_salary") 
			+ " and PROJECT.Pname = '" 
			+ request.getParameter("q1_pname") 
			+ "' and WORKS_ON.Pno = PROJECT.Pnumber and WORKS_ON.Essn = EMPLOYEE.Ssn ORDER BY Lname ASC";
	pstmt = conn.prepareStatement(query);
	rs1=pstmt.executeQuery();
	
	query = "SELECT Fname, Lname FROM EMPLOYEE WHERE EMPLOYEE.Address LIKE '%" + request.getParameter("q2_address") + ", TX%' and EMPLOYEE.Super_ssn = '" + request.getParameter("q2_mgrssn") + "'";
	pstmt = conn.prepareStatement(query);
	rs2=pstmt.executeQuery();
	
	query = "SELECT Lname FROM EMPLOYEE, WORKS_ON, PROJECT WHERE PROJECT.Pname = '" + request.getParameter("q3_pname") + "' and PROJECT.Pnumber = WORKS_ON.Pno and EMPLOYEE.Ssn = WORKS_ON.Essn ORDER BY Lname DESC";
	pstmt = conn.prepareStatement(query);
	rs3=pstmt.executeQuery();
%>
    <h4>------ Q1 Result ------</h4>
<%  
	// Complete your code.
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs1.getMetaData();
	int cnt = rsmd.getColumnCount();
	for(int i=1; i<= cnt; i++){
		out.println("<th>" + rsmd.getColumnName(i) + "</th>");
	}
	while(rs1.next()){
		out.println("<tr>");
		out.println("<td>" + rs1.getString(1) + "</td>");
		out.println("<td>" + rs1.getString(2) + "</td>");
		out.println("<td>" + rs1.getString(3) + "</td>");
		out.println("</tr>");
	}
	out.println("</table>");
%>
    <h4>------ Q2 Result ------</h4>
<%  
	// Complete your code.
	out.println("<table border=\"1\">");
	rsmd = rs2.getMetaData();
	cnt = rsmd.getColumnCount();
	for(int i=1; i<= cnt; i++){
		out.println("<th>" + rsmd.getColumnName(i) + "</th>");
	}
	while(rs2.next()){
		out.println("<tr>");
		out.println("<td>" + rs2.getString(1) + "</td>");
		out.println("<td>" + rs2.getString(2) + "</td>");
		out.println("</tr>");
	}
	out.println("</table>");
%>
    <h4>------ Q3 Result ------</h4>
<%  
	// Complete your code.
	out.println("<table border=\"1\">");
	rsmd = rs3.getMetaData();
	cnt = rsmd.getColumnCount();
	for(int i=1; i<= cnt; i++){
		out.println("<th>" + rsmd.getColumnName(i) + "</th>");
	}
	while(rs3.next()){
		out.println("<tr>");
		out.println("<td>" + rs3.getString(1) + "</td>");
		out.println("</tr>");
	}
	out.println("</table>");
	pstmt.close();
	conn.close();
%>

</body>
</html>
