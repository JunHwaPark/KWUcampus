<%--
  Created by IntelliJ IDEA.
  User: hongchanyun
  Date: 2019-05-30
  Time: 22:09
  To change this template use File | Settings | File Templates.
--%>
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

    String profID = "3456789012";   // Given by request (김용혁 교수님 아이디)
%>
<%
    // 1.드라이버 로딩
    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        System.err.println("[강의자료] Driver load 오류 : " + e.getMessage());
    }

    // 2.연결
    try {
        con = DriverManager.getConnection(server + database + "?serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false", user_name, password);
        System.out.println("[강의자료] 데이터베이스 연결 완료.");
    } catch(SQLException e) {
        System.err.println("[강의자료] getConnection 오류 :" + e.getMessage());
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
    <title>강의자료실</title>
    <meta charset="utf-8">
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
<h2>강의 자료실</h2>
<select name="subject" id="courseSelect">
    <%
        String query = "select Cid, CName from COURSE where pid=" + profID;
        rs = st.executeQuery(query);

        while(rs.next()) {
            // selectbox 구성
            out.println("<option value=" + rs.getString("Cid") + ">" + rs.getString("CName") + "</option>");
        }
    %>
</select>
<input id="btnGo" type="button" value="GO" onclick="clickBtnGo()"><br><br>

<a href="">등록</a><br>

<iframe name="myframe" id="myframe" src="material_table.jsp" width="700" height="500"></iframe>
<form name="materialInfoFrom">
    <input type="hidden" id="courseID" name="courseID" value="">
</form>

</body>
</html>
