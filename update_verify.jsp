<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<html>
<head><title> ������û ����� ���� ���� </title></head>
<body>
��..
<%  
	String session_id= (String)session.getAttribute("user");
	Connection myConn = null;
	Statement stmt = null;
	String mySQL = null;

	String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "db01";
	String passwd = "ss2";
	String jdbc_driver = "oracle.jdbc.driver.OracleDriver";

	String s_id = request.getParameter("s_id");
	String s_pwd = request.getParameter("s_pwd");
	String s_name = request.getParameter("s_name");
	String s_major = request.getParameter("s_major");
	String s_grade = request.getParameter("s_grade");

	try{
		Class.forName(jdbc_driver);
		myConn = DriverManager.getConnection (dburl, user, passwd);
		stmt = myConn.createStatement();
		mySQL = "update student set s_id ='"+s_id+"', s_pwd='"+s_pwd+"', s_name='"+s_name+"', s_major='"+s_major+"',s_grade='"+s_grade+"'" ;
		ResultSet rs = stmt.executeQuery(mySQL);
		
		out.println("<script>alert('ȸ�������� �����Ǿ����ϴ�.');</script>");
		out.println("<script>location.href= \"update.jsp\";</script>");
	
     } catch(SQLException ex) {
  	   String sMessage;
   	   if (ex.getErrorCode() == 20002) sMessage="��ȣ�� 4�ڸ� �̻��̾�� �մϴ�";
	  else if (ex.getErrorCode() == 20003) sMessage="��ȣ�� ������ �Էµ��� �ʽ��ϴ�.";
	  else sMessage="��� �� �ٽ� �õ��Ͻʽÿ�";	
     }
	finally{
		if(stmt != null){
			stmt.close();
			myConn.close();
		}
	}
%>
��
</body></html>
