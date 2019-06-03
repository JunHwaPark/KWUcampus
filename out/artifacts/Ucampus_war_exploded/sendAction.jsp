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
<%
  Connection conn = null;
  Statement stmt = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;
  int cnt = 0;
  String []Sids = request.getParameterValues("Sids");
  try {
    String url = "jdbc:mysql://localhost:3306/UNIVERSITY?characterEncoding=UTF-8&serverTimezone=UTC"; // DB 주소 (DB 이름 UNIVERSITY)
    String user = "root"; // DB user 이름
    String password = "mysqlPracticeRoot@123"; // DB password

    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(url, user, password);
    stmt = conn.createStatement();

    String sql = "INSERT INTO NOTE VALUES(?, ?, ?, ?);";
    String sql2 = "SELECT COUNT(*) AS CNT FROM NOTE;";

    pstmt = conn.prepareStatement(sql);

    rs = stmt.executeQuery(sql2);
    while(rs.next())
      cnt = rs.getInt("CNT");
  }
  catch(Exception e){
    out.println("DB connection error! : " + e.getMessage());
  }
try{

  for(int i = 0; i < Sids.length; i++)
  {
    pstmt.setString(1, Sids[i]);
    pstmt.setInt(2, cnt++);
    pstmt.setString(3, (String) request.getParameter("contents"));
    pstmt.setString(4, (String) request.getParameter("Cid"));
    pstmt.executeUpdate();
  }
}
catch (Exception e) {
    out.println("Login error! : " + e.getMessage());
}
%>
<script>
  location.href="Smanagement.jsp";
</script>
  </body>
</html>
