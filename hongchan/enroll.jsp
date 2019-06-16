<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%!
    String server = "jdbc:mysql://localhost/"; // MySQL 서버 주소
    String database = "University"; // MySQL DATABASE 이름
    String user_name = "root"; //  MySQL 서버 아이디
    String password = ""; // MySQL 서버 비밀번호

    Connection con = null;
    Statement st = null;
    ResultSet cours = null;

    Map<String, String> profInfo = new HashMap<String, String>();
    Map<String, String> courseInfo = new HashMap<String, String>();

    String studentID = "1";   // Given by request or session(처음에 로그인 시 세션 등록)
%>
<%
    // 1.드라이버 로딩
    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        System.err.println("[강의등록] Driver load 오류 : " + e.getMessage());
    }

    // 2.연결
    try {
        con = DriverManager.getConnection(server + database + "?serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false", user_name, password);
        System.out.println("[강의등록] 데이터베이스 연결 완료.");
    } catch(SQLException e) {
        System.err.println("[강의등록] getConnection 오류 :" + e.getMessage());
    }
    st = con.createStatement();
    /*
    // 3.해제
    try {
        if(con != null)
            con.close();
    } catch (SQLException e) {}
    */
%>
<html>
<head>
    <title>수강신청 및 포기</title>
    <meta charset="utf-8">
    <link href="main.css"  rel="stylesheet" type="text/css" />
    <script type="text/javascript">


        function clickBtnGo(){
            // select box에서 선택된 강의이름을 가져와 강의ID를 저장
            var target = document.getElementById("courseSelect");
            var cID = target.options[target.selectedIndex].value;

            // 전송 할 강의ID 설정
            document.getElementById("courseID").value = cID;

            // iframe 리로드
            document.materialInfoFrom.target = "myframe";
            document.materialInfoFrom.action = "material_table.jsp";
            document.materialInfoFrom.submit();
        }
    </script>
</head>
<body>
<%
    // 교수님 아이디를 키로 이름을 값으로 해쉬맵 생성
    String query = "select Pid, Pname from professor";
    ResultSet rs = st.executeQuery(query);
    while(rs.next()){
        profInfo.put(rs.getString("Pid"), rs.getString("Pname"));
    }

    // 강의 아이디를 키로 이름을 값으로 해쉬맵 생성
    query = "select Cid, CName from course";
    rs = st.executeQuery(query);
    while(rs.next()){
        courseInfo.put(rs.getString("Cid"), rs.getString("CName"));
    }
%>
<h1>강의 수강 및 포기</h1>

<h3>현재 수강중인 강의</h3>
<form action="enroll_action.jsp" method="get">
    <input type="submit" value="수강 포기">
    <br><br>

    <table id="tbGiveUp">
        <tr>
            <td class="check">선택</td>
            <td>학정번호</td>
            <td>과목명</td>
            <td>담당교수</td>
            <td>개설학과</td>
        </tr>
        <%
            query = "select * from enroll where Sid = " + studentID;
            cours = st.executeQuery(query);

            while(cours.next()) {
                String courseID = cours.getString("Cid");
                // 해시테이블에서 강의 이름 가져옴
                String courseName = courseInfo.get(courseID);

                // 테이블에서 교수 이름 가져옴
                query = "select Pid from course where Cid='" + courseID+"'";
                Statement stt = con.createStatement();
                rs = stt.executeQuery(query);
                String pName = null;
                if(rs.next()) {
                    String pID = rs.getString("Pid");
                    pName = profInfo.get(pID);
                }
        %>
        <tr>
            <td class="check"><input type="checkbox" name="giveup" value="<%=courseID%>"></td>
            <td><%=courseID%></td>
            <td><%=courseName%></td>
            <td><%=pName%></td>
            <td>소프트웨어학부</td>
        </tr>
        <%}%>
    </table>
</form>

<br><br><hr><br>

<h3>신청 가능한 강의</h3>
<form action="enroll_action.jsp" method="get">
    <input type="submit" value="수강 신청">
    <br><br>
    <table id="tbEnroll">
        <tr>
            <td class="check">선택</td>
            <td>학정번호</td>
            <td>과목명</td>
            <td>담당교수</td>
            <td>개설학과</td>
        </tr>
        <%
            String query1 = "select * from course";
            cours = st.executeQuery(query1);

            while(cours.next()) {
                String profID = cours.getString("Pid");
                // 해시테이블에서 교수 이름 가져옴
                String profName = profInfo.get(profID);
                String Cid = cours.getString("Cid");
        %>
        <tr>
            <td class="check"><input type="checkbox" name="enroll" value="<%=Cid%>"></td>
            <td><%=Cid%></td>
            <td><%=cours.getString("CName")%></td>
            <td><%=profName%></td>
            <td>소프트웨어학부</td>
        </tr>
        <%}%>
    </table>
</form>
</body>
</html>
