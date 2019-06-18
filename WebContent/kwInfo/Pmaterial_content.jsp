<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="dbPractice.Connect.DBConnect" %>
<%@ page import="java.util.ArrayList" %>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	conn = DBConnect.getConnection();
	stmt = conn.createStatement();

	String profID = null;
	String courseID;
	String materialNo;
	profID = (String)session.getAttribute("id");

	String title = null;
	String content = null;
	String date = null;
	String views = null;

	String attachment;

	// 우선 강의자료 하나라고 가정하고 구현하기, 나중에 시간나면 여러 강의자료고 바꿈
	//ArrayList<String> attachments = new ArrayList();
	//boolean isAttachment;
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
    stmt.executeUpdate(query);

    // 값들 가져와 변수에 저장
    query = "select * from MATERIALS where Cid='" + courseID + "'and Mno='" + materialNo + "'";
    rs = stmt.executeQuery(query);
    if(rs.next()){
        title = rs.getString("Title");
        views = rs.getString("Views");
        content = rs.getString("Content");
        date = rs.getString("Date");
    }

    // 첨부파일 있는지 확인
    query = "select * from ATTACHMENTS where Cid='" + courseID + "'and Mno='" + materialNo + "'";
    rs = stmt.executeQuery(query);

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
<%
    if(attachment.equals("강의자료가 없습니다.")){
%>
<p>첨부파일 : 강의자료가 없습니다.</p>
<%
    }else{
%>
<p>첨부파일 : <a href="attachment_download.jsp?filename=<%=attachment%>"><%=attachment%></a></p>
<%
	}

	//DB사용 후 close() 필수!
	stmt.close();
	rs.close();
	conn.close();
%>
</body>
</html>