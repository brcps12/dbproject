<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<head>
	<title>내 강의 조회</title>
</head>

<%@ include file="top.jsp" %>
<%@ include file="dbconfig.jsp" %>

<%
	if (session_id == null)
		response.sendRedirect("login.jsp");
%>
<a href="create_course.jsp">강의 추가</a>
<table width="75%" align="center" border>
	<br/>
	<tr>
		<th>과목번호</th>
		<th>분반</th>
		<th>과목명</th>
		<th>학점</th>
		<th>요일</th>
		<th>시간</th>
		<th>장소</th>
		<th>수강생 조회</th>
		<th>수업 삭제</th>
	</tr>
	<%
	CallableStatement stmt = null;
	ResultSet myResultSet = null;
	String mySQL = "{call SelectTimeTableProfessor(?,?,?,?)}";
		stmt = myConn.prepareCall(mySQL);
		stmt.setInt(1,session_id);
		stmt.registerOutParameter(2,oracle.jdbc.OracleTypes.CURSOR);
		stmt.registerOutParameter(3,oracle.jdbc.OracleTypes.NUMBER);
		stmt.registerOutParameter(4,oracle.jdbc.OracleTypes.NUMBER);
		stmt.execute();
		myResultSet = (ResultSet)stmt.getObject(2);
		int sumCourse  = stmt.getInt(3);
		int sumUnit = stmt.getInt(4);
		if (myResultSet != null) {
			while (myResultSet.next()) {
				String c_id = myResultSet.getString("c_id");
				int c_id_no = myResultSet.getInt("c_id_no");
				String c_name = myResultSet.getString("c_name");
				int c_unit = myResultSet.getInt("c_unit");
				int t_day = myResultSet.getInt("t_day");
				int t_time = myResultSet.getInt("t_time");
				String t_where = myResultSet.getString("t_where");
	%>
	<tr>
		<td align="center"><%=c_id%></td>
		<td align="center"><%=c_id_no%></td>
		<td align="center"><%=c_name%></td>
		<td align="center"><%=c_unit%></td>
		<td align="center"><%=t_day%></td>
		<td align="center"><%=t_time%></td>
		<td align="center"><%=t_where%></td>
		<td align="center"><a
				href="view_student.jsp?c_id=<%=c_id%>&c_id_no=<%=c_id_no%>">조회</a></td>
		<td align="center"><a
				href="delete_course.jsp?c_id=<%=c_id%>&c_id_no=<%=c_id_no%>">삭제</a></td>
	</tr>
	<%
			}
		}
		stmt.close();
		myConn.close();
	%>
</table>
	<h3 align="center">총 <%=sumCourse %> 과목, <%=sumUnit %> 학점 수업입니다.</h3>
<%@ include file="footer.jsp"%>