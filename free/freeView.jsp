
<%@page import="java.util.ArrayList"%>
<%@page import="com.study.free.vo.FreeBoardVO"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/inc/header.jsp"%>
<title>자유게시판 - 글 보기</title>
</head>
<body>
	<%@ include file="/WEB-INF/inc/top.jsp"%>
	<%
	int boNo = Integer.parseInt(request.getParameter("boNo"));
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	try {
		conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:study");
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT										 ");
		sb.append("  	   to_char(bo_reg_date, 'YYYY-MM-DD') AS bo_reg_date  ");
		sb.append(" 	 , to_char(bo_reg_date, 'YYYY-MM-DD') AS bo_reg_date	  ");
		sb.append("    , bo_no       , bo_title , bo_category ");
		sb.append("    , bo_writer   , bo_pass  , bo_content  ");
		sb.append("    , bo_ip       , bo_hit   , bo_del_yn   ");
		sb.append(" FROM											 ");
		sb.append("     free_board								 ");
		sb.append(" WHERE 	bo_no  =  ?						 ");
		
		ps = conn.prepareStatement(sb.toString());
		ps.setInt(1, boNo);		
		rs = ps.executeQuery();
		
		if (rs.next()) {
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

			request.setAttribute("free", free);
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		if(conn != null) {try{conn.close();}catch(Exception e){}}
		if(ps != null) {try{ps.close();}catch(Exception e){}}
		if(rs != null) {try{rs.close();}catch(Exception e){}}
	}
	%>
	

	
	<div class="alert alert-warning">
			해당 글이 존재하지 않습니다.
			또는 조회수증가 실패했습니다.
	</div>	
		<a href="freeList.jsp" class="btn btn-default btn-sm">
		<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
		&nbsp;목록
	</a>


		<div class="container">
			<div class="page-header">
				<h3>
					자유게시판 - <small>글 보기</small>
				</h3>
			</div>
			<table class="table table-striped table-bordered">
				<tbody>
					<tr>
						<th>글번호</th>
						<td>${free.boNo }</td>
					</tr>
					<tr>
						<th>글제목</th>
						<td>${free.boTitle }</td>
					</tr>
					<tr>
						<th>글분류</th>
						<td>${free.boCategory }</td>
					</tr>
					<tr>
						<th>작성자명</th>
						<td>${free.boWriter }</td>
					</tr>
					<!-- 비밀번호는 보여주지 않음  -->
					<tr>
						<th>내용</th>
						<td>${free.boContent }</td>
					</tr>
					<tr>
						<th>등록자 IP</th>
						<td>${free.boIp }</td>
					</tr>
					<tr>
						<th>조회수</th>
						<td>${free.boHit }</td>
					</tr>
					<tr>
						<th>최근등록일자</th>
						<td>${free.boModDate ne null ? free.boModDate : free.boRegDate }</td>
					</tr>
					<tr>
						<th>삭제여부</th>
						<td>${free.boDelYn }</td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="pull-left">
								<a href="freeList.jsp" class="btn btn-default btn-sm"> <span class="glyphicon glyphicon-list" aria-hidden="true"></span> &nbsp;&nbsp;목록
								</a>
							</div>
							<div class="pull-right">
								<a href="freeEdit.jsp?boNo=${free.boNo }" class="btn btn-success btn-sm"> <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> &nbsp;&nbsp;수정
								</a>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- container -->

</body>
</html>






