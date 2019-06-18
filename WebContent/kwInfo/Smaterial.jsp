<%--
  Created by IntelliJ IDEA.
  User: hongchanyun
  Date: 2019-05-30
  Time: 22:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dbPractice.Connect.DBConnect" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%
  Connection conn = null;
  Statement stmt = null;
  ResultSet rs = null;

  conn = DBConnect.getConnection();
  stmt = conn.createStatement();

  String studentID = null;
  studentID = (String)session.getAttribute("id");

  Map<String, String> courseInfo = new HashMap<String, String>();
%>
<%
  // 강의 아이디를 키로 이름을 값으로 해쉬맵 생성
  String query = "select Cid, CName from course";
  rs = stmt.executeQuery(query);
  while(rs.next()){
    courseInfo.put(rs.getString("Cid"), rs.getString("CName"));
  }
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
      document.materialInfoFrom.action = "Smaterial_table.jsp";
      document.materialInfoFrom.submit();
    }
  </script>
</head>
<body>
<br>
<a href="Smaterial.jsp">강의자료실</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="enroll.jsp">강의수강</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="logoutAction.jsp">로그아웃</a>
<br><hr><br>
<h2>강의 자료실</h2>
<select name="subject" id="courseSelect">
  <%
    query = "select * from enroll where Sid = " + studentID;
    Statement st = conn.createStatement();
    rs = st.executeQuery(query);

    while(rs.next()) {
      // selectbox 구성
      String courseID = rs.getString("Cid");
      // 해시테이블에서 강의 이름 가져옴
      String courseName = courseInfo.get(courseID);
      out.println("<option value=" + rs.getString("Cid") + ">" + courseName + "</option>");
    }
    //DB사용 후 close() 필수!
    stmt.close();
    rs.close();
    conn.close();
  %>
</select>
<input id="btnGo" type="button" value="GO" onclick="clickBtnGo()"><br><br>
<br>

<iframe name="myframe" id="myframe" src="Smaterial_table.jsp" width="700" height="500"></iframe>
<form name="materialInfoFrom">
  <input type="hidden" id="courseID" name="courseID" value="">
</form>

</body>
</html>
