<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.User" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>Chic Dashboard</title>
    <link rel="stylesheet" type="text/css" href="base.css">
	<script>
	    function handleUserAction(selectElement, userId) {
	        const action = selectElement.value;
	        if (action === "block") {
	            if (confirm("Êtes-vous sûr de vouloir bloquer cet utilisateur ?")) {
	                window.location.href = "UserServlet?action=block&id=" + userId;
	            }
	        } else if (action === "unblock") {
	            if (confirm("Êtes-vous sûr de vouloir débloquer cet utilisateur ?")) {
	                window.location.href = "UserServlet?action=unblock&id=" + userId;
	            }
	        } else if (action === "delete") {
	            if (confirm("Êtes-vous sûr de vouloir supprimer cet utilisateur ?")) {
	                window.location.href = "UserServlet?action=delete&id=" + userId;
	            }
	        }
	        // Réinitialiser la liste déroulante
	        selectElement.selectedIndex = 0;
	    }
	</script>
</head>
<body>
	<!-- Include Navbar -->
	<%@ include file="admin-navbar.jsp" %>
	
    <h1>Gestion des Utilisateurs</h1>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Email</th>
                <th>Rôle</th>
                <th>Statut</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            List<User> users = (List<User>) request.getAttribute("users");

            if (users != null && !users.isEmpty()) {
                for (User user : users) {
        %>
	        <tr>
	            <td><%= user.getId() %></td>
	            <td><%= user.getName() %></td>
	            <td><%= user.getEmail() %></td>
	            <td><%= user.getRole() %></td>
	            <td><%= user.getStatus() %></td>
	            <td>
				    <select onchange="handleUserAction(this, <%= user.getId() %>)">
				        <option value="" selected disabled>Actions</option>
				        <% if ("active".equals(user.getStatus())) { %>
				            <option value="block">Block</option>
				        <% } else if ("blocked".equals(user.getStatus())) { %>
				            <option value="unblock">Unblock</option>
				        <% } %>
				        <option value="delete">Delete</option>
				    </select>
				</td>
	        </tr>
        <%
                }
            } else {
        %>
	        <tr>
	            <td colspan="6" style="text-align: center;">No users found.</td>
	        </tr>
        <%
            }
        %>
	    </tbody>
    </table>
</body>
</html>
