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
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	conn = DBConnect.getConnection();
	stmt = conn.createStatement();

	String profID = null;
	profID = (String)session.getAttribute("id");
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
            document.materialInfoFrom.action = "Pmaterial_table.jsp";
            document.materialInfoFrom.submit();
        }
    </script>
</head>
<body>
<h2>강의 자료실</h2>
<select name="subject" id="courseSelect">
    <%
        String query = "select Cid, CName from COURSE where pid=" + profID;
        rs = stmt.executeQuery(query);

        while(rs.next()) {
            // selectbox 구성
            out.println("<option value=" + rs.getString("Cid") + ">" + rs.getString("CName") + "</option>");
        }
    	//DB사용 후 close() 필수!
    	stmt.close();
    	rs.close();
    	conn.close();
    %>
</select>
<input id="btnGo" type="button" value="GO" onclick="clickBtnGo()"><br><br>
<br>

<iframe name="myframe" id="myframe" src="Pmaterial_table.jsp" width="700" height="500"></iframe>
<form name="materialInfoFrom">
    <input type="hidden" id="courseID" name="courseID" value="">
</form>

</body>
</html>
