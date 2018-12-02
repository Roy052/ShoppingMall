<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page language="java" import="java.text.*, java.sql.*, java.io.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>MySQL test</h2>
	<%
	String url;
	Connection conn=null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String dbName = "a";
	String id = "root";
	String pw = "Asdf1234";
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost/" + dbName,id,pw);
		if(conn==null)
			System.out.println("실패");
		else
			System.out.println("성공");
	}catch(ClassNotFoundException e){
		e.printStackTrace();
	}catch(SQLException se){
		se.printStackTrace();
	}catch(Exception ex){
		ex.printStackTrace();
	}finally{
		try{ // 연결 해제(한정돼 있으므로)

            if(rs!=null){        rs.close();            }

            if(pstmt!=null){    pstmt.close();        }

            if(stmt!=null){    stmt.close();        }

            if(conn!=null){    conn.close();        }

        }catch(SQLException se2){

            se2.printStackTrace();
            }
        }
	
	%>

</body>
</html>