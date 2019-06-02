<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
    String material;
    int currentMno;

    String title;
    String content;
    String date;
    int views;

    String attachment;
%>
<%
    // 1.드라이버 로딩
    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        System.err.println("[강의자료 추가] Driver load 오류 : " + e.getMessage());
    }

    // 2.연결
    try {
        con = DriverManager.getConnection(server + database + "?serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false", user_name, password);
        System.out.println("[강의자료 추가] 데이터베이스 연결 완료.");
    } catch(SQLException e) {
        System.err.println("[강의자료 추가] getConnection 오류 :" + e.getMessage());
    }
    st = con.createStatement();
%>
<html>
<head>
    <meta charset="utf-8">
    <%
        // 여기서는 데이터베이스 연동 x add.jsp에서만 연동
        // 제목, 내용, 강의 아이디 보내기 / 등록일 = 시간 가져오기, 조회수 = 0, 밑에 작성한 게시글 번호 계산
        // 보낼 때 hidden 타입으로 value만 보내기

        // 요청으로 받은 제목, 내용, 강의ID 저장
        title = request.getParameter("title");
        content = request.getParameter("content");
        courseID = request.getParameter("courseID");
        material = request.getParameter("material");    // 나중에 수정
        String log = "[강의자료 추가] 강의ID : " + courseID + " / 제목 : " + title;
        System.out.println(log);

        String query = "select * from MATERIALS where cid='" + courseID+"'";
        rs = st.executeQuery(query);

        // 강의 자료 글 번호 계산
        while(rs.next()) {
            currentMno = rs.getInt("Mno");
        }
        currentMno++;

        // 조회수 0으로 초기화 및 등록 시간 가져오기
        views = 0;
        long time = System.currentTimeMillis();
        SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd");
        date = dayTime.format(new Date(time));

        // 데이터베이스에 새로운 글 등록
        query = "insert into MATERIALS values ('"+ courseID + "',"+ currentMno + ",'"+ title + "','" + content + "','" + date +  "'," + views + ")";
        st.executeUpdate(query);

        response.sendRedirect("material_table.jsp?courseID="+courseID);
    %>
</head>
<body>
</body>
</html>