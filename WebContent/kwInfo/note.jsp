<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="dbPractice.Connect.DBConnect" %>
<%@ page import="dbPractice.note.Note_student" %>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	conn = DBConnect.getConnection();
	stmt = conn.createStatement();
	conn.setAutoCommit(false);

	//noteContent.jsp처럼 세션에 저장해서 옮겨받으면 됨. 병합할 때 수정 필요
	String studentID = null;
	studentID = (String)session.getAttribute("id");
	//session.setAttribute("Sid", studentID);
%>
<html>
<head>
    <title>강의자료실</title>
    <meta charset="utf-8">
</head>
<body>
강의 자료실 <a href="note.jsp">쪽지</a>
<h2>쪽지 목록</h2>
<%
	rs = Note_student.getNoteList(stmt, studentID);
	while (rs.next()) {	//ID는 세션으로 유지되니, 전달할 때 굳이 쪽지 번호를 보호할 필요가 없음. get형식으로 쪽지 번호 전달.
		String str = "<a href =\"noteContent.jsp?Nno=" + rs.getInt("Nno") +  "\" target=\"_blank\">" +
		rs.getInt("Nno") + "       " + rs.getString("CName") + "         " + rs.getString("Pname") + "</a>";
		out.println(str);
	}
	//DB사용 후 close() 필수!
	stmt.close();
	rs.close();
	conn.close();
%>

</body>
</html>
