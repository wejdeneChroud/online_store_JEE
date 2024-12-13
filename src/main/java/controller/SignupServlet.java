package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

import java.io.IOException;

import dao.UserDAO;

/**
 * Servlet implementation class SignupServlet
 */
public class SignupServlet extends HttpServlet {
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match. Please try again.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        // Validate password format
        if (!isValidPassword(password)) {
            request.setAttribute("error", "Password must be at least 7 characters long and include at least 2 special characters.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        if (!userDAO.isEmailAvailable(email)) {
            request.setAttribute("error", "Email is already registered!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        User newUser = new User(name, email, password, "client");
        boolean isSuccess = userDAO.insertUser(newUser);

        if (isSuccess) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", "Error during registration!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }

    private boolean isValidPassword(String password) {
        if (password.length() < 7) {
            return false;
        }
        int specialCharCount = 0;
        for (char c : password.toCharArray()) {
            if (!Character.isLetterOrDigit(c)) {
                specialCharCount++;
            }
        }
        return specialCharCount >= 2;
    }

}
