<%@ page import="java.sql.*"%>
<%--
<%@ page import="java.sql.DriverManager" %>
  Created by IntelliJ IDEA.
  User: User
  Date: 2019-05-31
  Time: 오후 3:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>$Title$</title>
  </head>
  <body>
<%
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
try{
    String userCode = request.getParameter("user_code"); // 사용자 구분 학생 or 교수
    String id = request.getParameter("userID");
    String pwd = request.getParameter("userPassword");

    if(userCode.equals("1")) // 학생
    {
        String sql = "select * from student WHERE Sid = '" + id + "' AND Spassword = '" + pwd + "';"; // id와 pwd로 검색
        rs = stmt.executeQuery(sql);

        if(rs.next()) // DB에 존재
        {
            session.setAttribute("id", rs.getString("Sid"));
            session.setAttribute("name", rs.getString("Sname"));

            out.println("<script> location.href = 'material.jsp'; </script>"); // 이어질 페이지 설정
        }
        else
        {
            out.println("<script> alert('정보가 일치하지 않습니다.'); location.href = 'login.jsp'; </script>");
        }
    }
    else if(userCode.equals("2")) // 교수
    {
        String sql = "select * from professor WHERE Pid='" + id + "' AND Ppassword='" + pwd + "';"; // id와 pwd로 검색

        rs = stmt.executeQuery(sql);

        if(rs.next()) // DB에 존재
        {
            session.setAttribute("id", rs.getString("Pid"));
            session.setAttribute("name", rs.getString("Pname"));

            out.println("<script> location.href = 'Smanagement.jsp'; </script>"); // 이어질 페이지 설정
        }
        else
        {
            out.println("<script> alert('정보가 일치하지 않습니다.'); location.href = 'login.jsp'; </script>");
        }
    }
    else
    {
        out.println("<script> alert('없는 usercode 입니다.'); location.href = 'login.jsp'; </script>");
    }
}
catch (Exception e) {
    out.println("Login error! : " + e.getMessage());
}


%>
  </body>
</html>
