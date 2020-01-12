<%--
  Created by IntelliJ IDEA.
  User: wyx
  Date: 2019/10/16
  Time: 20:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form id="updateForm">
    <input type="hidden" value="${movie.id}" name="id"/>
    <input type="hidden" value="${movie.imgUrl}" id="imgUrl" name="imgUrl">
    <div class="form-group panel-body" style="margin-bottom:-20px;">
        <label>电影名</label>
        <input type="text" class="radio-inline form-control" name="name" style="width: 150px;" value="${movie.name}">
    </div>
    <div class="form-group panel-body" style="margin-bottom:-20px;">
        <label>价格</label>
        <input type="text" class="radio-inline form-control" name="price" style="width: 150px" value="${movie.price}">
    </div>

    <div class="form-group panel-body" style="margin-bottom:-20px;">
        <label>上架时间</label>

        <input type="date" class="radio-inline form-control" name="showTime" style="width: 150px" value="<fmt:formatDate value="${movie.showTime}" pattern="yyyy-MM-dd"></fmt:formatDate>">>
    </div>
    <div class="panel-body" style="margin-bottom:-20px;">
        <label class="control-label">状态</label>
        <label class="radio-inline">
            <input type="radio" name="status"  value="1" ${movie.status==1?"checked":""}>上架
        </label>
        <label class="radio-inline">
            <input type="radio" name="status"  value="2" ${movie.status==2?"checked":""}>下架
        </label>
    </div>

    <div class="col-sm-10 control-label">
        <label>图片</label>
        <input type="file"  name="photo" id="photo" multiple class="form-control">
    </div>
</form>

<script>

    var url = '${movie.imgUrl}'
    alert(url)
    var previewArr = [];
    previewArr.push(url)

    $("#photo").fileinput({

        language: 'zh',
        uploadUrl: "<%=request.getContextPath()%>/uploadFile",
        showCaption: false,//是否显示标题,就是那个文本框
        dropZoneEnabled: false,//是否显示拖拽区域，默认不写为true，但是会占用很大区域
        initialPreview: previewArr,
        initialPreviewAsData: true, // 特别重要

    }).on("fileuploaded", function (event, result, previewId, index) {
        var url = result.response.data;

        $("#imgUrl").val(url);
    })

</script>
</body>
</html>
