<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en"> 
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login and Signup</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f9f9f9;
        }

        .container {
            display: flex;
            width: 800px;
            height: 400px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        .login-section, .signup-section {
            width: 50%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 30px;
        }

        .login-section {
            background-color: #fff;
            text-align: center;
        }

        .signup-section {
            background-color: #e97c32;
            color: white;
        }

        h2 {
            font-size: 24px;
            margin-bottom: 20px;
            text-align: center;
        }

        p {
            font-size: 14px;
            margin-bottom: 20px;
            text-align: center;
        }

        input[type="email"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .button {
            background-color: #e97c32;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .button:hover {
            background-color: #c86b2a;
        }

        .signup-button {
            background-color: white;
            color: #e97c32;
            border: 2px solid white;
        }

        .signup-button:hover {
            color: #c86b2a;
            border-color: #c86b2a;
        }

        a {
            text-decoration: none;
            color: #e97c32;
            font-size: 14px;
            text-align: center;
        }

        a:hover {
            text-decoration: underline;
        }
        
        .error-message {
            display: flex;
            align-items: center;
            background-color: #F8D7DA;
            border: 1px solid #F5C2C7;
            color: #842029;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-size: 0.9rem;
        }

        .error-message i {
            font-size: 1.2rem;
            margin-right: 10px;
        }

        .error-message a {
            color: #842029;
            text-decoration: underline;
            margin-left: 5px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Login Section -->
        <div class="login-section">
            <h2>Se connecter</h2>
            <p>ou utilisez votre compte</p>
	        <% if (request.getAttribute("error") != null) { %>
	        <div class="error-message">
	            <i class="fas fa-exclamation-circle"></i>
	            <span><%= request.getAttribute("error") %></span>
	        </div>
	        <% } %>
            <form action="LoginServlet" method="post">
                <input type="email" name="email" placeholder="Email" required>
                <input type="password" name="password" placeholder="Mot de passe" required>
                <a href="#">Mot de passe oublié ?</a><br><br>
                <button type="submit" class="button">Se connecter</button>
            </form>
        </div>
        
        <!-- Signup Section -->
        <div class="signup-section">
            <h2>Bonjour et bienvenue dans notre boutique !</h2>
            <p>Renseignez vos informations personnelles et découvrez une expérience d'achat unique avec nous.</p>
            <a href="signup.jsp" class="button signup-button">S'inscrire</a>
        </div>
    </div>
</body>
</html>
