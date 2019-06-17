<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="dbPractice.Connect.DBConnect" %>

<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	conn = DBConnect.getConnection();
	stmt = conn.createStatement();

	String profID = null;
	String courseID;
	profID = (String)session.getAttribute("id");
%>
<html>
<head>
    <meta charset="utf-8">
</head>
<body>
<%
    // 요청을 받은 강의 아이디 저장
    courseID = request.getParameter("courseID");
%>
<a href="Pmaterial_addform.jsp?&cid=<%=courseID%>">강의자료 등록</a>

    <table id="tbMaterial">
        <tr>
            <td>선택</td>
            <td>No</td>
            <td>제목</td>
            <td>등록일</td>
            <td>조회수</td>
        </tr>
        <%

            // 로그 출력
            System.out.println("[강의자료 테이블] 요청된 강의ID : " + courseID);

            String query = "select * from MATERIALS where cid='" + courseID+"'";
            rs = stmt.executeQuery(query);

            // 강의자료 글 목록 생성
            while(rs.next()){
        %>
        <tr>
            <td><input type="checkbox"></td>
            <td><%=rs.getString("Mno")%></td>
            <td width="100"><a href="Pmaterial_content.jsp?mno=<%=rs.getString("Mno")%>&cid=<%=courseID%>"><%=rs.getString("Title")%></a></td>
            <td><%=rs.getString("Date")%></td>
            <td><%=rs.getString("Views")%></td>
        </tr>
        <%}
        	//DB사용 후 close() 필수!
        	stmt.close();
        	rs.close();
        	conn.close();
        %>
    </table>
</body>
</html>