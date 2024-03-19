<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Movie</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>
<body>
    <div class="container">
        <h1>Edit Movie</h1>
        <form:form action="/admin/updateMovie" method="post" modelAttribute="movie">
            <div class="mb-3">
                <label for="movieName" class="form-label">Movie Name</label>
                <form:input path="movieName" id="movieName" class="form-control"/>
            </div>
            <div class="mb-3">
                <label for="nation" class="form-label">Nation</label>
                <form:input path="nation" id="nation" class="form-control"/>
            </div>
            <div class="mb-3">
                <label for="director" class="form-label">Director</label>
                <form:input path="director" id="director" class="form-control"/>
            </div>
            <div class="mb-3">
                <label for="producer" class="form-label">Producer</label>
                <form:input path="producer" id="producer" class="form-control"/>
            </div>
            <div class="mb-3">
                <label for="actor" class="form-label">Actor</label>
                <form:input path="actor" id="actor" class="form-control"/>
            </div>
            <div class="mb-3">
                <label for="trailer" class="form-label">Trailer</label>
                <form:input path="trailer" id="trailer" class="form-control"/>
            </div>
            <div class="mb-3">
                <label for="describeMovie" class="form-label">Describe Movie</label>
                <form:textarea path="describeMovie" id="describeMovie" class="form-control"/>
            </div>
            <input type="hidden" name="movieId" value="${movie.movieId}"> <!-- To include movieId for updating -->
            <button type="submit" class="btn btn-primary">Save Changes</button>
        </form:form>
    </div>
</body>
</html>
