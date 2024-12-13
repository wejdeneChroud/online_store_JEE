<%@ page import="dao.ProductDAO, model.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>Chic Dashboard</title>
    <link rel="stylesheet" href="base.css">
</head>
<body>
	<!-- Include Navbar -->
	<%@ include file="admin-navbar.jsp" %>
	
    <%
	    Product product = (Product) request.getAttribute("product");
	%>
	<div class="form-container">
        <h1>Formulaire Produit</h1>
		<form action="ProductServlet" method="post" enctype="multipart/form-data" class="styled-form">
		    <input type="hidden" name="action" value="<%= product == null ? "insert" : "update" %>">
		    <input type="hidden" name="id" value="<%= product != null ? product.getId() : "" %>">
		    
		    <div class="form-group">
                <label for="name">Nom :</label>
                <input type="text" name="name" id="name" value="<%= product != null ? product.getName() : "" %>" placeholder="Entrez le nom du produit" required>
            </div>
            
            <div class="form-group">
                <label for="description">Description :</label>
                <textarea name="description" id="description" rows="4" placeholder="Entrez la description du produit" required>
				    <%= product != null ? product.getDescription() : "" %>
				</textarea>
            </div>
            
            <div class="form-group">
                <label for="price">Prix :</label>
                <input type="number" step="0.01" name="price" id="price"  value="<%= product != null ? product.getPrice() : "" %>" placeholder="Entrez le prix du produit" required>
            </div>
		    
            <div class="form-group">
                <label for="stock">Stock :</label>
                <input type="number" name="stock" id="stock" value="<%= product != null ? product.getStock() : "" %>" placeholder="Entrez la quantité en stock" required>
            </div>
            
            <div class="form-group">
                <label for="category">Catégorie :</label>
                <input type="text" name="category" id="category"  value="<%= product != null ? product.getCategory() : "" %>" placeholder="Entrez la catégorie du produit" required>
            </div>
       		
            <div class="form-group">
                <label for="image">Image :</label>
                <input type="file" name="image" id="image" required>
            </div>
            
		    <div class="form-group">
                <button type="submit" class="btn-primary">Enregistrer</button>
            </div>
		</form>
	
</body>
</html>