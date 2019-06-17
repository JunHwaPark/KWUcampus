<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="dbPractice.Connect.DBConnect" %>

<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    conn = DBConnect.getConnection();
    stmt = conn.createStatement();

    String studentID = null;
    String courseID;
    studentID = (String)session.getAttribute("id");
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.css">
</head>
<body>
<%
    // 요청을 받은 강의 아이디 저장
    courseID = request.getParameter("courseID");
%>
<table id="tbMaterial" class="table table-striped">
    <tr>
        <th scope="col">선택</th>
        <th scope="col">No</th>
        <th scope="col">제목</th>
        <th scope="col">등록일</th>
        <th scope="col">조회수</th>
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