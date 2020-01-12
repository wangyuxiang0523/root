<%--
  Created by IntelliJ IDEA.
  User: wyx
  Date: 2019/10/19
  Time: 15:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="<%=request.getContextPath()%>/commons/datatable/DataTables-1.10.18/css/dataTables.bootstrap.min.css" rel="stylesheet"/>
    <link href="<%=request.getContextPath()%>/commons/fileInput/css/fileinput.min.css">
    <script src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/commons/datatable/DataTables-1.10.18/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/commons/datatable/DataTables-1.10.18/js/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/commons/dateFormat.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/commons/bootbox/bootbox.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/commons/fileInput/js/fileinput.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/commons/fileInput/js/locales/zh.js"></script>
</head>
<body>
<div class="container">
    <div class="panel panel-danger">
        <div  class="panel-heading">
            <div class="panel-body">
                <form>
                    电影名<input id="name">
                    是否上架<input id="status1" name="status" value="1" type="radio">上架<input id="status2" name="status" value="2" type="radio">下架
                    上架时间<input type="date" id="a">到<input type="date" id="b">
                    <input type="button" value="查询" onclick="seach()"/>
                    <input type="reset">
                </form>
            </div>
        </div>
    </div>
</div>

<script type="text/html" id="addMovieForm">
<form id="userForm">
    <input type="hidden" name="imgUrl" id="imgUrl"/>
    <div class="form-group panel-body" style="margin-bottom:-20px;">
        <label>电影名</label>
        <input type="text" class="radio-inline form-control" name="name" style="width: 150px;">
    </div>
    <div class="form-group panel-body" style="margin-bottom:-20px;">
        <label>价格</label>
        <input type="text" class="radio-inline form-control" name="price" style="width: 150px">
    </div>

    <div class="form-group panel-body" style="margin-bottom:-20px;">
        <label>上架时间</label>
        <input type="date" class="radio-inline form-control" name="showTime" style="width: 150px">
    </div>
    <div class="panel-body" style="margin-bottom:-20px;">
        <label class="control-label">状态</label>
        <label class="radio-inline">
            <input type="radio" name="status"  value="1">上架
        </label>
        <label class="radio-inline">
            <input type="radio" name="status"  value="2">下架
        </label>
    </div>

    <div class="col-sm-10 control-label">
        <label>图片</label>
        <input type="file"  name="photo" id="photo" multiple class="form-control">
    </div>
</form>
</script>
<table id="table" class="table table-bordered table-striped"></table>
<button type="button" class="btn glyphicon glyphicon-plus" onclick="addUser()">添加用户</button>
            <script>
                var table = $("#table").DataTable({
                    "autoWidth": true,
                    "info": true,
                    "lengthChange": true,
                    "lengthMenu": [2, 5, 10],
                    "ordering": false,
                    "paging": true,
                    "processing": true,
                    "serverSide": true,
                    "ajax": {
                        url: "<%=request.getContextPath()%>/movieList",
                        type: "post",
                        "dataSrc": function (result) {

                            return result.data
                        }
                    },
                    "columns": [
                        {"data": "id", "title": "主键"},
                        {"data": "name", "title": "电影名"},
                        {"data": "price", "title": "价格"},

                        {
                            "data": "status", "title": "状态", render: function (data, type, row, meta) {
                                return data == 1 ? "上架" : "下架"
                            }
                        },
                        {"data": "showTime", "title": "上架日期",render: function (data, type, row, meta) {
                                if (data != null) {
                                    return new Date(data).Format("yyyy-MM-dd")
                                }
                                return "";
                            }



                        },

                        {
                            "data": "imgUrl", "title": "头像", render: function (data, type, row, meta) {
                                return "<img src='<%=request.getContextPath()%>/" + data + "'width='50px'>"
                            }

                        },
                        {
                            "data": "id", "title": "操作", render: function (data, type, row, meta) {
                                    return '<button type="button" class="btn glyphicon glyphicon-edit" onclick="updateMovie(' + data + ')">修改信息</button>';
                            }
                        }

                    ],
                    "language": {
                        "url": "<%=request.getContextPath()%>/commons/datatable/Chinese.json"
                    }

                })
                function seach() {
                    var jsonData = {};
                    var name = $("#name").val();
                    var status = $("[name='status']:checked").val();
                    var startTime= $("#a").val();
                    var endTime= $("#b").val();
                    jsonData.name = name;
                    jsonData.status = status;
                    jsonData.startTime=startTime;
                    jsonData.endTime=endTime;
                    table.settings()[0].ajax.data = jsonData;
                    table.ajax.reload();
                }
                function addUser() {
                    bootbox.confirm({
                        message: $("#addMovieForm").html(),
                        size: "large",
                        buttons: {
                            confirm: {
                                label: '确定',
                                className: 'btn-success'
                            },
                            cancel: {
                                label: '取消',
                                className: 'btn-danger'
                            }
                        },
                        callback: function (result) {

                            if (result) {
                                $.ajax({
                                    url: "<%=request.getContextPath()%>/addMovie",
                                    type: "post",
                                    dataType: "json",
                                    data: $("#userForm").serialize(),
                                    success: function (result) {
                                        if (result.data == false) {
                                            alert(result.message)
                                            location.reload();
                                        }
                                    },
                                    error: function () {
                                        bootbox.alert("添加失败")
                                    }
                                })
                            }
                        }

                    })

                    $("#photo").fileinput({
                        language: 'zh',
                        uploadUrl: "<%=request.getContextPath()%>/uploadFile",
                        showCaption: false,//是否显示标题,就是那个文本框
                        dropZoneEnabled: false,//是否显示拖拽区域，默认不写为true，但是会占用很大区域
                    }).on("fileuploaded", function (event, result, previewId, index) {
                        var url = result.response.data;
                        alert(url);
                        $("#imgUrl").val(url);
                    })

                }
                function updateMovie(id) {

                    var a = "";
                    $.ajax({
                        url: "<%=request.getContextPath()%>/getMovieById",
                        type: "post",
                        data: {"id": id},
                        dataType: "html",
                        async: false,
                        success: function (result) {
                            a = result;
                            alert(a)
                        },
                        error: function () {
                            alert("回显失败")
                        }
                    })

                    bootbox.dialog({
                        title: "修改用户信息",
                        message: a,
                        size: "large",

                        buttons: {
                            cancel: {
                                label: "取消",
                                className: 'btn-danger',
                                callback: function () {
                                    alert("取消保存！")
                                }
                            },
                            queding: {
                                label: "保存",
                                className: 'btn-warning',
                                callback: function () {
                                    $.ajax({
                                        url: "<%=request.getContextPath()%>/updateMovie",
                                        type: "post",
                                        dataType: "",
                                        data: $("#updateForm").serialize(),
                                        success: function (result) {
                                            bootbox.alert("成功修改");
                                            location.reload();
                                        },
                                        error: function () {
                                            bootbox.alert("修改失败");
                                        }
                                    })
                                }
                            }
                        }
                    })
                }

            </script>
</body>
</html>
