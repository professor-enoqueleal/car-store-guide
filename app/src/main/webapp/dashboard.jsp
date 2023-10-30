<!DOCTYPE html>
<html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <meta http-equiv="Content-Type" content="text/html" charset=UTF-8>
    <link href="/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/dashboard.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
    <title>Car Store | Dashboard</title>
</head>
<body>

    <header class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
        <a class="navbar-brand col-md-3 col-lg-2 me-0 px-3 fs-6" href="#">CarStore</a>
        <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <input class="form-control form-control-dark w-100 rounded-0 border-0" type="text" placeholder="Search" aria-label="Search">
        <div class="navbar-nav">
            <div class="nav-item text-nowrap">
                <a class="nav-link px-3" href="/logout">Sign out</a>
            </div>
        </div>
    </header>

  <div class="container-fluid">

    <div class="row">

        <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">

            <div class="position-sticky pt-3 sidebar-sticky">

                <c:if test="${sessionScope.loggedUser != null}">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" aria-current="page" href="#"><span data-feather="user" class="align-text-bottom"></span>
                                 <span>${sessionScope.loggedUser}</span>
                             </a>
                        </li>
                    </ul>
                    <hr>
                </c:if>

                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="/find-all-cars"><span data-feather="home" class="align-text-bottom"></span> Home </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/"><span data-feather="file-text" class="align-text-bottom"></span> New Car</a>
                    </li>
                </ul>

            </div>

        </nav>

        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">

            <h2>Cars</h2>

            <div class="table-responsive">

                <table class="table table-striped table-sm">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <c:if test="${sessionScope.loggedUser != null}">
                            <th>Actions</th>
                        </c:if>
                    </tr>
                    <c:forEach var="car" items="${cars}">
                        <tr>
                            <td>${car.id}</td>
                            <td>${car.name}</td>
                            <c:if test="${sessionScope.loggedUser != null}">
                                <td>
                                    <form action="/delete-car" method="post">
                                        <input type="hidden" id="id" name="id" value="${car.id}">
                                        <button type="submit" class="btn btn-primary btn-sm">Delete</button>

                                        <a class="btn btn-secondary btn-sm" href="index.jsp?id=${car.id}&name=${car.name}">Update</a>
                                    </form>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </table>

            </div>

        </main>

      </div>

  </div>

  	<script src="/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
  	<script src="/js/feather.min.js"></script>
  	<script src="/js/dashboard.js"></script>

</body>
</html>
