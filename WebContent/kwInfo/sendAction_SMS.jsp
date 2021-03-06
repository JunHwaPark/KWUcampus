<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="dbPractice.Connect.DBConnect"%>

<%@ page import="java.util.HashMap"%>
<%@ page import="net.nurigo.java_sdk.api.Message"%>
<%@ page import="net.nurigo.java_sdk.exceptions.CoolsmsException"%>
<%@ page import="org.json.simple.JSONObject"%>

<%--
<%@ page import="java.sql.DriverManager" %>
  Created by IntelliJ IDEA.
  User: User
  Date: 2019-05-31
  Time: 오후 3:37
  To change this template use File | Settings | File Templates.
--%>

<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>$Title$</title>

<%
	if (session.getAttribute("id") == null) // 로그인 중인지 확인
	{
		out.println("<script> alert('로그인이 되어 있지 않습니다.'); location.href = 'index.jsp'; </script>");
	}

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	conn = DBConnect.getConnection();
	stmt = conn.createStatement();

	request.setCharacterEncoding("utf-8");
	String[] Sids = request.getParameterValues("Sids");

	String[] To = new String[65];

	String sql1 = "select Pno from student where Sid='";

	for (int i = 0; i < Sids.length; i++) {
		rs = stmt.executeQuery(sql1 + Sids[i] + "';");
		if (rs.next()) {
			To[i] = rs.getString("Pno");
		}
	}
%>
</head>
<BODY>
	<%
		String api_key = "NCSU7YMYZRJPTEHY";
		String api_secret = "PBTHJHGLUQIB4VRMAFRA1ZY7RSVFCNIH";

		long unixTime = System.currentTimeMillis() / 1000;

		String From = "01055718002";
		String text = request.getParameter("contents");
		String type = "SMS";
	%>
	<%
		for (int i = 0; i < Sids.length; i++) {
			Message coolsms = new Message(api_key, api_secret);
			HashMap<String, String> params = new HashMap<String, String>();

			params.put("to", To[i]); // 수신번호
			params.put("from", "01055718002"); // 발신번호
			params.put("type", type); // Message type ( SMS, LMS, MMS, ATA )
			params.put("text", text); // 문자내용
			params.put("app_version", "JAVA SDK v1.2"); // application name and version
			try {
				JSONObject obj = (JSONObject) coolsms.send(params);
			} catch (CoolsmsException e) {
				out.println("<script>");
				out.println("alert('sms 발송 실패');");
				out.println("alert('" + e.getMessage() + "');");
				out.println("alert('" + e.getCode() + "');");
				out.println("location.href='Smanagement_SMS.jsp';");
				out.println("</script>");
			}
		}

		out.println("<script>");
		out.println("alert('sms 발송 성공');");
		out.println("location.href='Smanagement_SMS.jsp';");
		out.println("</script>");
		
		//DB사용 후 close() 필수!
		stmt.close();
		rs.close();
		conn.close();
	%>
</body>
</html>