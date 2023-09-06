<html>

<head>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <meta http-equiv="Content-Type" content="text/html" charset=UTF-8>
    <link href="/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<form action="/create-car" method="post" enctype="multipart/form-data" class="container">

    <h2>Create Car</h2>

    <div>
        <label>Car Name</label>
        <input type="text" name="car-name" id="car-name" value="${param.name}">
        <input type="hidden" id="id" name="id" value="${param.id}">
    </div>
    <br>
    <div>
        <label for="image">Choose file</label>
        <input type="file" name="image" id="image">
    </div>

    <br>

    <button type="submit">Save</button>

</form>

</body>
</html>
