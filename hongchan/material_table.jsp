<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%!
    String server = "jdbc:mysql://localhost/"; // MySQL 서버 주소
    String database = "University"; // MySQL DATABASE 이름
    String user_name = "root"; //  MySQL 서버 아이디
    String password = ""; // MySQL 서버 비밀번호

    Connection con = null;
    Statement st = null;
    ResultSet rs = null;

    String profID = "3456789012";   // Given by request ( or Session)
    String courseID;
%>
<%
    // 1.드라이버 로딩
    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        System.err.println("Driver load 오류 : " + e.getMessage());
    }

    // 2.연결
    try {
        con = DriverManager.getConnection(server + database + "?serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false", user_name, password);
        System.out.println("[강의자료 테이블] 데이터베이스 연결 완료.");
    } catch(SQLException e) {
        System.err.println("getConnection 오류 :" + e.getMessage());
    }
    st = con.createStatement();
%>
<html>
<head>
    <meta charset="utf-8">
</head>
<body>
    <table id="tbMaterial">
        <tr>
            <td>선택</td>
            <td>No</td>
            <td>제목</td>
            <td>등록일</td>
            <td>조회수</td>
        </tr>
        <%
            // 요청을 받은 강의 아이디 저장
            courseID = request.getParameter("courseID");
            // 로그 출력
            System.out.println("[강의자료 테이블] 요청된 강의ID : " + courseID);
            String query = "select * from MATERIALS where cid='" + courseID+"'";

            rs = st.executeQuery(query);
            
            while(rs.next()){
        %>
        <tr>
            <td><input type="checkbox"></td>
            <td><%=rs.getString("Mno")%></td>
            <td><%=rs.getString("Title")%></td>
            <td><%=rs.getString("Date")%></td>
            <td><%=rs.getString("Views")%></td>
        </tr>
        <%}%>
    </table>
</body>
</html>