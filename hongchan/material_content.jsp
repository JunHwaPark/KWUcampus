<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
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
    String materialNo;

    String title;
    String content;
    String date;
    String views;

    String attachment;
    // 우선 강의자료 하나라고 가정하고 구현하기, 나중에 시간나면 여러 강의자료고 바꿈
    //ArrayList<String> attachments = new ArrayList();
    //boolean isAttachment;

%>
<%
    // 1.드라이버 로딩
    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        System.err.println("[강의자료 내용] Driver load 오류 : " + e.getMessage());
    }

    // 2.연결
    try {
        con = DriverManager.getConnection(server + database + "?serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false", user_name, password);
        System.out.println("[강의자료 내용] 데이터베이스 연결 완료.");
    } catch(SQLException e) {
        System.err.println("[강의자료 내용] getConnection 오류 :" + e.getMessage());
    }
    st = con.createStatement();
%>
<html>
<head>
    <meta charset="utf-8">
</head>
<body>
<%
    courseID = request.getParameter("cid");
    materialNo = request.getParameter("mno");
    System.out.println("[강의자료 내용] 요청된 강의ID : " + courseID + " / 요청된 강의글 번호 : " + materialNo);

    // 조회수 업데이트
    String query = "update MATERIALS set Views=Views+1 where Cid='" + courseID + "'and Mno='" + materialNo + "'";
    st.executeUpdate(query);

    // 값들 가져와 변수에 저장
    query = "select * from MATERIALS where Cid='" + courseID + "'and Mno='" + materialNo + "'";
    rs = st.executeQuery(query);
    if(rs.next()){
        title = rs.getString("Title");
        views = rs.getString("Views");
        content = rs.getString("Content");
        date = rs.getString("Date");
    }

    // 강의자료 있는지 확인
    query = "select * from ATTACHMENTS where Cid='" + courseID + "'and Mno='" + materialNo + "'";
    rs = st.executeQuery(query);

    if(rs.next()){
        attachment = rs.getString("Aname");
    }
    else{
        attachment = "강의자료가 없습니다.";
    }
%>
<p>제목 : <%=title%></p>
<p>글 번호 : <%=materialNo%> &nbsp;&nbsp;&nbsp;등록일 : <%=date%> &nbsp;&nbsp;&nbsp;조회수 : <%=views%></p>
<hr>
<p><%=content%></p>
<hr>
<p>첨부파일 : <%=attachment%></p>
</body>
</html>