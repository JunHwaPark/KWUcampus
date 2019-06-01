<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="dbPractice.connect.DBconnect" %>
<%@ page import="dbPractice.note.Note_student" %>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	conn = DBconnect.getConnection();
	stmt = conn.createStatement();
	conn.setAutoCommit(false);

	String studentID = (String)session.getAttribute("Sid");
	int Nno = Integer.parseInt(request.getParameter("Nno"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	rs = Note_student.getNoteContent(stmt, studentID, Nno);
	rs.next();
	int index = rs.getInt("Nno");
	String Pname = rs.getString("Pname");
	String Content = rs.getString("Content");
%>
	<%=index%>
	<br>
	<%=Pname%>
	<br>
	<%=Content%>
</body>
</html>