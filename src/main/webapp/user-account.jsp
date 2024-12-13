<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chic</title>
    <link rel="stylesheet" href="base.css">
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <div class="account-details-container">
        <h1>Détails du Compte</h1>
        <%
            User user = (User) request.getAttribute("user");
        %>
        <div class="account-info">
            <p><strong>Nom :</strong> <%= user.getName() %></p>
            <p><strong>Email :</strong> <%= user.getEmail() %></p>
            <p><strong>Rôle :</strong> <%= user.getRole() %></p>
            <p><strong>Statut :</strong> <%= user.getStatus() %></p>
        </div>
    </div>
</body>
</html>
