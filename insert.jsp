<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*"  %>
<html><head><title>수강신청 입력</title></head>
<body>
<%@ include file="top.jsp" %>
<%   if (session_id==null) response.sendRedirect("login.jsp");  %>

<table width="75%" align="center" border>
<br>
<tr><th>과목번호</th><th>분반</th><th>과목명</th><th>학점</th>
      <th>수강신청</th></tr>
<%
Connection myConn = null;
Statement stmt = null;
String mySQL = null;

String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user = "db01";
String passwd = "ss2";
String jdbc_driver = "oracle.jdbc.driver.OracleDriver";

ResultSet myResultSet;

String c_id="";
int c_id_no;
String c_name;
int c_unit;

	try {
		Class.forName(jdbc_driver);
	         myConn =  DriverManager.getConnection (dburl, user, passwd);
		stmt = myConn.createStatement();	
    } catch(SQLException ex) {
	     System.err.println("SQLException: " + ex.getMessage());
    }

	mySQL = "select c_id,c_id_no,c_name,c_unit from course where c_id not in (select c_id from enroll where s_id='" + session_id + "')";
	
myResultSet = stmt.executeQuery(mySQL);

if (myResultSet != null) {
	while (myResultSet.next()) {	
		 c_id = myResultSet.getString("c_id");
		 c_id_no = myResultSet.getInt("c_id_no");			
		c_name = myResultSet.getString("c_name");
		c_unit = myResultSet.getInt("c_unit");			
%>

<tr>
  <td align="center"><%=c_id %></td> <td align="center"><%=c_id_no %></td> 
  <td align="center"><%=c_name %></td><td align="center"><%=c_unit %></td>
  <td align="center"><a href="insert_verify.jsp?c_id=<%=c_id %>&c_id_no=<%= c_id_no %>">신청</a></td>
</tr>
<%
	}//while문 끝
	}//if문 끝
 

	stmt.close();  myConn.close();
%>
</table></body></html>
    