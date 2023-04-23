<!DOCTYPE html>
<html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
</head>
<body>
  <div>
    <h1>Cars</h1>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="car" items="${cars}">
            <tr>
                <td>${car.id}</td>
                <td>${car.name}</td>
                <td>
                    <form action="/delete-car" method="post">
                        <input type="hidden" id="id" name="id" value="${car.id}">
                        <button type="submit">Delete</button>
                        <span> | </span>
                        <a href="index.jsp?id=${car.id}&name=${car.name}">Update</a>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
  </div>
</body>
</html>
