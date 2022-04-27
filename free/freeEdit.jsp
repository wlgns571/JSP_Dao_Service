
<%@page import="com.study.free.vo.FreeBoardVO"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<%@include file="/WEB-INF/inc/header.jsp"%>
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
			sb.append("      bo_no       , bo_title , bo_category ");
			sb.append("    , bo_writer   , bo_pass  , bo_content  ");
			sb.append("    , bo_ip       , bo_hit   , bo_reg_date ");
			sb.append("    , bo_mod_date , bo_del_yn				 ");
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
		해당 글이 존재하지 않습니다.</div>
		<a href="freeList.jsp" class="btn btn-default btn-sm"> 
		<span class="glyphicon glyphicon-list" 
		aria-hidden="true">
		</span> &nbsp;목록
		</a>
		<div class="container">
			<div class="page-header">
				<h3>
					자유게시판 - <small>글 수정</small>
				</h3>
			</div>
			<form action="freeModify.jsp" method="post">
				<table class="table table-striped table-bordered">
					<colgroup>
						<col width="20%" />
						<col />
					</colgroup>
					<tr>
						<th>글번호</th>
						<td>${free.boNo }<input type="hidden" name="boNo" value="${free.boNo }"></td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" name="boTitle" value="${free.boTitle }" class="form-control input-sm" required="required"></td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${free.boWriter }<input type="hidden" name="boWriter" value="${free.boWriter }">
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="boPass" value="" class="form-control input-sm" required="required" pattern="\w{4,}" title="알파벳과 숫자로 4글자 이상 입력"> <span class="text-danger"> <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> 글 등록시에 입력한 비밀번호를 입력하세요.
						</span></td>
					</tr>
					<tr>
						<th>분류</th>
						<td>
							<select name="boCategory" class="form-control input-sm" required="required">
								<option value="">-- 선택하세요--</option>
								<option value="BC01" ${free.boCategory eq "BC01" ? "selected='selected'" : ""} >프로그램</option>
								<option value="BC02" ${free.boCategory eq "BC02" ? "selected='selected'" : ""}>웹</option>
								<option value="BC03" ${free.boCategory eq "BC03" ? "selected='selected'" : ""}>사는 이야기</option>
								<option value="BC04" ${free.boCategory eq "BC04" ? "selected='selected'" : ""}>취업</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea rows="10" name="boContent" class="form-control input-sm">${free.boContent }</textarea></td>
					</tr>
					<tr>
						<th>IP</th>
						<td>${free.boIp }</td>
					</tr>
					<tr>
						<th>조회수</th>
						<td>${free.boHit }</td>
					</tr>
					<tr>
						<th>최근등록일자</th>
						<td>${free.boModDate eq null ? free.boRegDate : free.boModDate  }</td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="pull-left">
								<a href="freeList.jsp" class="btn btn-default btn-sm"> <span class="glyphicon glyphicon-list" aria-hidden="true"></span> &nbsp;&nbsp;목록
								</a>
							</div>
							<div class="pull-right">
								<button type="submit"  class="btn btn-sm btn-primary">
									<span class="glyphicon glyphicon-save" aria-hidden="true"></span> &nbsp;&nbsp;저장
								</button>

								<button type="submit" formaction="freeDelete.jsp" class="btn btn-sm btn-danger">
									<span class="glyphicon glyphicon-remove" aria-hidden="true"></span> &nbsp;&nbsp;삭제
								</button>
							</div>
						</td>
					</tr>
				</table>
			</form>

		</div>
		<!-- container -->

</body>
</html>


