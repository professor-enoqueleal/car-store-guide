<html>

<head>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <meta http-equiv="Content-Type" content="text/html" charset=UTF-8>
    <link href="/webjars/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/dashboard.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
    <title>Car Store | New Car</title>
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

                <h2>Create Car</h2>

                <div class="table-responsive">

                    <form action="/create-car" method="post" enctype="multipart/form-data" class="container">

                        <input type="hidden" id="id" name="id" value="${param.id}">

                        <div class="mb-3">
                            <label class="form-label" for="car-name" >Name</label>
                            <input class="form-control" type="text" name="car-name" id="car-name" value="${param.name}">
                        </div>

                        <div class="mb-3">
                            <label class="form-label" for="brand">Brand</label>
                            <input class="form-control" type="text" name="brand" id="brand">
                        </div>

                        <div class="mb-3">
                            <label class="form-label" for="version">Version</label>
                            <input class="form-control" type="text" name="version" id="version">
                        </div>

                        <div class="mb-3">
                            <label class="form-label" for="year">Year</label>
                            <input class="form-control" type="text" name="year" id="year">
                        </div>

                        <div class="mb-3">
                            <label class="form-label" for="year-model">Year Model</label>
                            <input class="form-control" type="text" name="year-model" id="year-model">
                        </div>

                        <div class="mb-3">
                            <label class="form-label" for="image">Choose file</label>
                            <input class="form-control" type="file" name="image" id="image">
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <button class="btn btn-primary" type="submit">Save</button>
                        </div>

                    </form>

                </div>

        </main>

     </div>

   </div>

    <script src="/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="/js/feather.min.js"></script>
    <script src="/js/dashboard.js"></script>

</body>
</html>
