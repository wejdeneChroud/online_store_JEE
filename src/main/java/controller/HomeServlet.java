package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import dao.ProductDAO;

/**
 * Servlet implementation class HomeServlet
 */
public class HomeServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 7124506115837128813L;
	private ProductDAO productDAO;

    public void init() {
        productDAO = new ProductDAO();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Define categories
        String[] categories = {"Homme", "Femme", "Enfant"};

        // Fetch products for each category
        Map<String, List<Product>> categoryProducts = new LinkedHashMap<>();
        for (String category : categories) {
            List<Product> products = productDAO.selectProductsByCategoryWithLimit(category, 3);
            categoryProducts.put(category, products);
        }

        // Send data to JSP
        request.setAttribute("categoryProducts", categoryProducts);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
