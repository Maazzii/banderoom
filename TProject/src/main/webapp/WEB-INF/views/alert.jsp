<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
    var msg = "${msg}";
    var url = "<%=request.getContextPath()%>${url}";
    alert(msg);
	if(${close != null}){
		opener.location.href=url; //opener 부모창
		self.close();//현재 내 창
	}
    location.href = url;
</script>
</head>
<body>
	
</body>
</html>