<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.io.File" %>
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
    String material;
    int currentMno;

    String title;
    String content;
    String date;
    int views;

    String attachment;
%>
<%

    // 1.드라이버 로딩
    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        System.err.println("[강의자료 추가] Driver load 오류 : " + e.getMessage());
    }

    // 2.연결
    try {
        con = DriverManager.getConnection(server + database + "?serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false", user_name, password);
        System.out.println("[강의자료 추가] 데이터베이스 연결 완료.");
    } catch(SQLException e) {
        System.err.println("[강의자료 추가] getConnection 오류 :" + e.getMessage());
    }
    st = con.createStatement();
%>
<html>
<head>
    <meta charset="utf-8">
    <%
        /*
         * 파일 업로드 기능 수행 (cos.jar 라이브러리 사용)
         * 파일이름 중 '+'가 있으면 띄어쓰기로 인식해 파일 다운로드 에러!
         */
        System.out.println("[강의자료 추가] 첨부파일 업로드 시작 ==========");
        ServletContext context = getServletConfig().getServletContext();

        String saveFolder = context.getRealPath("upload");  // 업로드 폴더 지정
        String encType = "utf-8";
        int maxSize = 30 * 1024 * 1024;     // 업로드 최대 크기 (30MB)
        System.out.println("저장 Servlet 경로 " + saveFolder);

        MultipartRequest multi = null;
        try{
            multi = new MultipartRequest(request, saveFolder, maxSize, encType, new DefaultFileRenamePolicy());

            Enumeration en = multi.getFileNames();
            int i = 0;
            while(en.hasMoreElements()){
                String name = (String)en.nextElement();
                String originFile = multi.getOriginalFileName(name);
                String systemFile = multi.getFilesystemName(name);  // 이름 중복 막기 위해 변경된 이름
                String fileType = multi.getContentType(name);

                File file = multi.getFile(name);    // 실제 파일 객체 가져와 저장
                System.out.println("파일 원본 이름 : " + originFile + " / 파일 타입 : " + fileType);
                if(systemFile != null){
                    attachment = systemFile;
                    System.out.println("파일 크기 :  " + file.length());
                }
            }
        }catch(Exception e){
            System.err.println("!파일 업로드 간 문제 발생! " + e.getMessage());
        }
        System.out.println("저장된 파일 :  " + attachment);
        System.out.println("[강의자료 추가] 첨부파일 업로드 종료 ==========");
    %>
    <%
        /*
         * 1. 등록일 이상한 문제 수정
         * 2. 번호 처음 등록하면 2로 시작! 수정(비어있을 때는 ++없애면 될듯)
         */

        // 요청으로 받은 제목, 내용, 강의ID 저장 (file 때문에 request 대신 multi로 받음)
        title = multi.getParameter("title");
        content = multi.getParameter("content");
        courseID = multi.getParameter("courseID");
        String log = "[강의자료 추가] 강의ID : " + courseID + " / 제목 : " + title;
        System.out.println(log);

        String query = "select * from MATERIALS where cid='" + courseID+"'";
        rs = st.executeQuery(query);

        // 강의 자료 글 번호 계산
        while(rs.next()) {
            currentMno = rs.getInt("Mno");
        }
        currentMno++;

        // 조회수 0으로 초기화 및 등록 시간 가져오기 / 등록 시간 추후 수정!!
        views = 0;
        /*
        long time = System.currentTimeMillis();
        SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd");
        date = dayTime.format(new Date(time));
         */
        date = "2019-06-02";

        // 강의자료 데이터베이스에 새로운 글 등록
        query = "insert into MATERIALS values ('"+ courseID + "',"+ currentMno + ",'"+ title + "','" + content + "','" + date +  "'," + views + ")";
        st.executeUpdate(query);

        // 첨부파일 데이터베이스에 새로운 첨부파일 등록
        query = "insert into ATTACHMENTS values ('"+ courseID + "',"+ currentMno + ",1,'" + attachment + "')";
        st.executeUpdate(query);

        response.sendRedirect("material_table.jsp?courseID="+courseID);
    %>
</head>
<body>
</body>
</html>