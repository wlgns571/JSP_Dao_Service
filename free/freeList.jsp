
<%@page import="java.util.ArrayList"%>
<%@page import="com.study.free.vo.FreeBoardVO"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html lang="ko">
<head>
<%@include file="/WEB-INF/inc/header.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/inc/top.jsp"%>
<%
	// 1.연결 (Conn을 DBCP에서 얻으면 된다.) 2.수행 (PSTMT)  3.종료
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	try {
		conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:study");
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT										  				  ");
		sb.append("  	   to_char(bo_reg_date, 'YYYY-MM-DD') AS bo_reg_date  ");
		sb.append(" 	 , to_char(bo_reg_date, 'YYYY-MM-DD') AS bo_reg_date	  ");
		sb.append("    , bo_no       , bo_title , bo_category 				  ");
		sb.append("    , bo_writer   , bo_pass  , bo_content  				  ");
		sb.append("    , bo_ip       , bo_hit   , bo_del_yn  				  ");
		sb.append(" FROM											 				  ");
		sb.append("    free_board								 				  ");
		sb.append(" ORDER BY bo_no  asc							 				  ");
		
		ps = conn.prepareStatement(sb.toString());
		rs = ps.executeQuery();
		
		List<FreeBoardVO> freList = new ArrayList<FreeBoardVO>();
		while (rs.next()) {
			FreeBoardVO free = new FreeBoardVO();
			free.setBoNo(rs.getInt("bo_no"));
			free.setBoTitle(rs.getString("bo_title"));
			free.setBoCategory(rs.getString("bo_category"));
			free.setBoWriter(rs.getString("bo_writer"));
			free.setBoPass(rs.getString("bo_pass"));
			free.setBoContent(rs.getString("bo_content"));
			free.setBoIp(rs.getString("bo_ip"));
			free.setBoHit(rs.getInt("bo_hit"));
			free.setBoRegDate(rs.getString("bo_reg_date"));
			free.setBoModDate(rs.getString("bo_mod_date"));
			free.setBoDelYn(rs.getString("bo_del_yn"));
			
			// list에 담아주기
			freList.add(free);
		}
		// setAttribute 해주기
		request.setAttribute("freList", freList);
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		if(conn != null) {try{conn.close();}catch(Exception e){}}
		if(ps != null) {try{ps.close();}catch(Exception e){}}
		if(rs != null) {try{rs.close();}catch(Exception e){}}
	}
%>
<div class="container">
	<div class="page-header">
		<h3>자유게시판 - <small>글 목록</small></h3>
	</div>
<div class="row">
    <div class="col-sm-2 col-sm-offset-10 text-right" style="margin-bottom: 5px;" >
        <a href="freeForm.jsp" class="btn btn-primary btn-sm"> 
        	<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
        	&nbsp;새글쓰기
		</a>
    </div>
</div>
	<table class="table table-striped table-bordered table-hover">
	<colgroup>
		<col width="10%" />
		<col width="15%" />
		<col />
		<col width="10%" />
		<col width="15%" />
		<col width="10%" />
	</colgroup>
	<thead>
		<tr>
			<th>글번호</th>
			<th>분류</th>
			<th>제목</th>
			<th>작성자</th>
			<th>등록일</th>
			<th>조회수</th>
		</tr>
	</thead>	
	<tbody>
		<c:forEach items="${freList }" var="freList">
			<tr class="text-center">
				<td>${freList.boNo }</td>
				<td>${freList.boCategory }</td>
				<td class="text-left">
					<a href="freeView.jsp?boNo=${freList.boNo }">
						${freList.boTitle }
					</a>
				</td>
				<td>${freList.boWriter }</td>
				<td>${freList.boRegDate }</td>
				<td>${freList.boHit }</td>
			</tr>
		</c:forEach>
	</tbody>
	</table>
</div><!-- container --> 
</body>
</html>






