<%@ page contentType="text/html; charset=UTF-8" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="styles.css">

<nav class="navbar">
    <!-- Logo -->
    <div class="navbar-left">
        <a href="HomeServlet" class="navbar-logo">Chic</a>
    </div>

    <!-- Center Links -->
    <div class="navbar-center">
        <a href="HomeServlet" class="navbar-link">Home</a>
        <!-- Dropdown for Categories -->
        <div class="navbar-dropdown">
            <a href="#" class="navbar-link">Categories</a>
            <div class="dropdown-content">
                <a href="CategoryServlet?category=Homme">Homme</a>
                <a href="CategoryServlet?category=Femme">Femme</a>
                <a href="CategoryServlet?category=Enfant">Enfant</a>
            </div>
        </div>
        <a href="HistoriqueServlet" class="navbar-link">Order History</a>
        <!-- <a href="contact.jsp" class="navbar-link">Contact Us</a>
        <a href="about.jsp" class="navbar-link">About Us</a> -->
    </div>

    <!-- Right Icons -->
    <div class="navbar-right">
        <!-- Search Bar -->
        <form action="SearchServlet" method="GET" class="navbar-search-form">
            <input type="text" name="query" placeholder="Search..." class="navbar-search-input" required>
            <button type="submit" class="navbar-search-button"><i class="fas fa-search"></i></button>
        </form>
        <a href="CartServlet" class="navbar-icon"><i class="fas fa-shopping-cart"></i></a>
        <!-- User Dropdown Menu -->
        <div class="navbar-dropdown">
            <span class="navbar-icon user-icon"><i class="fas fa-user"></i></span>
            <div class="dropdown-content">
                <a href="UserAccountServlet">Account Details</a>
                <a href="LogoutServlet">Logout</a>
            </div>
        </div>
        <!-- Hamburger Menu Icon -->
        <span class="navbar-icon menu-icon" onclick="toggleSidebar()"><i class="fas fa-bars"></i></span>
    </div>
</nav>

<!-- Sidebar  -->
<div class="sidebar" id="sidebar">
    <span class="close-btn" onclick="toggleSidebar()">&times;</span>
    <a href="HomeServlet">Home</a>
    <a href="CategoryServlet?category=Homme">Homme</a>
    <a href="CategoryServlet?category=Femme">Femme</a>
    <a href="CategoryServlet?category=Enfant">Enfant</a>
    <a href="HistoriqueServlet">Order History</a>
    <a href="UserAccountServlet">Account Details</a>
    <a href="LogoutServlet">Logout</a>
</div>

<script>
function toggleSidebar() {
    const sidebar = document.getElementById("sidebar");
    if (sidebar.style.left === "0px") {
        sidebar.style.left = "-250px"; 
    } else {
        sidebar.style.left = "0px"; 
    }
}
</script>