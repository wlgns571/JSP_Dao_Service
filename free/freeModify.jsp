
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/inc/header.jsp"%>
<title>Insert title here</title>
</head>
<body>
<%@include file="/WEB-INF/inc/top.jsp"%>
<jsp:useBean id="freeBoard" class="com.study.free.vo.FreeBoardVO"></jsp:useBean>
<jsp:setProperty property="*" name="freeBoard"/>

	<%
		// edit에서 사용자가 수정한거 DB에서 수정되도록
		freeBoard.setBoIp(request.getRemoteAddr());	// Localhost = 0: 0: 0: 1
		Connection conn = null;
		PreparedStatement ps = null;
		// Reulstset은 필요 없다.
		try {
			conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:study");
			StringBuffer sb = new StringBuffer();
			sb.append(" UPDATE free_board SET        ");
			sb.append("       bo_title    = ?        ");
			sb.append("     , bo_category = ?        ");
			sb.append("     , bo_content  = ?        ");
			sb.append("     , bo_ip       = ?        ");
			sb.append("     , bo_hit      = bo_hit+1 ");
			sb.append("     , bo_mod_date  = sysdate  ");
			sb.append(" where bo_no       = ?		   ");
			ps = conn.prepareStatement(sb.toString());
			
			int cnt = 1;
			ps.setString(cnt++, freeBoard.getBoTitle());
			ps.setString(cnt++, freeBoard.getBoCategory());
			ps.setString(cnt++, freeBoard.getBoContent());
			ps.setString(cnt++, freeBoard.getBoIp());
			ps.setInt(cnt++, freeBoard.getBoNo());
			
			int resultCnt = ps.executeUpdate();
						
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(conn != null) {try{conn.close();}catch(Exception e){}}
			if(ps != null) {try{ps.close();}catch(Exception e){}}
		}
	%>
	
		<div class="alert alert-warning">
			해당 글이 존재하지 않습니다.
		</div>	

	
	
		<div class="alert alert-warning">
			수정 실패
		</div>	

		<div class="alert alert-warning">
			비밀번호가 틀립니다.
		</div>	
	
		
		

		<div class="alert alert-success">
			정상적으로 수정했습니다.
		</div>		
	
		
	<a href="freeView.jsp?boNo=" class="btn btn-default btn-sm">
		<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
		&nbsp;해당 뷰
	</a>	
	
	<a href="freeList.jsp" class="btn btn-default btn-sm">
		<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
		&nbsp;목록
	</a>


</body>
</html>