<%@ page import="java.sql.*"%>
<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2019-05-31
  Time: 오후 3:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title>$Title$</title>
    <%
      if(session.getAttribute("id") == null) // 로그인 중인지 확인
      {
        out.println("<script> alert('로그인이 되어 있지 않습니다.'); location.href = 'index.jsp'; </script>");
      }

      Connection conn = null;
      Statement stmt = null;
      ResultSet rs = null;


      try {
        String url = "jdbc:mysql://localhost:3306/UNIVERSITY?characterEncoding=UTF-8&serverTimezone=UTC"; // DB 주소 (DB 이름 UNIVERSITY)
        String user = "root"; // DB user 이름
        String password = "mysqlPracticeRoot@123"; // DB password

        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
        stmt = conn.createStatement();
      }
      catch(Exception e){
        out.println("DB connection error! : " + e.getMessage());
      }

    %>
  </head>
  <body>
  <form method="post" action="Smanagement.jsp" accept-charset="utf-8">
    과목 명 : <select name="Cid" id="Cid" tabindex="1" onchange="document.getElementById('CidToSA').value  = this.options[this.options.length - 1].text">
<%
  String sql1 = "select Cid, CName from course where Pid='" + session.getAttribute("id") + "';"; // 과목 이름 가져오기
  String Cid = null; // 현재 선택한 과목 번호
  rs = stmt.executeQuery(sql1);

  while(rs.next())
  {
    out.println("<option value='" + rs.getString("Cid") + "'>" + rs.getString("CName") +"</option>");
    Cid = rs.getString("Cid");
  }
  %>
    </select>
    <input type="submit" value="수강생관리">
  </form>

  <%
    if( request.getParameter("Pid") != null)
    {
      Cid = request.getParameter("Pid");
    }

    String sql2 = "select Sid from enroll where Cid='" + Cid + "';";
    rs = stmt.executeQuery((sql2));
    String Sids = "('null')";

    if(rs.next())
    {
      Sids = "('" + rs.getString("Sid") + "'";
      while(rs.next())
      {
        Sids += ",'" + rs.getString("Sid") + "'";
      }
      Sids += ")";
    }

    String sql3 = "select * from student where Sid in " + Sids + ";";

    rs = stmt.executeQuery(sql3);
    %>

  <form action="sendAction.jsp" method="post" >
    <table >
    <%
      out.println("<tr><th></th><th>학번</th><th>이름</th><th>학년</th><th>이메일</th><th>전화번호</th><th>부서</th></tr>");
      while(rs.next())
      {
        out.println("<tr>");
          out.println("<td><input type='checkbox' name='Sids' value='" + rs.getString("Sid") + "'</td>");
          out.println("<td>" + rs.getString("Sid") + "</td>");
          out.println("<td>" + rs.getString("Sname") + "</td>");
          out.println("<td>"   + rs.getString("Year") + "</td>");
          out.println("<td>" + rs.getString("Email") + "</td>");
          out.println("<td>" + rs.getString("Pno") + "</td>");
          out.println("<td>" + rs.getString("Dept") + "</td>");
        out.println("</tr>");
      }
    %>
    </table>
    <br><br><br>
    <input type="text" name="Cid" value="<%=Cid%>" style="display: none">
    <p>
      내용 : <textarea rows="32" cols="16" size="512" style="width: 500px; height: 200px;" name="contents"></textarea>
    </p>
    <input type="submit" value="쪽지보내기">
  </form>

  </body>
</html>