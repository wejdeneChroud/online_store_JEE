package dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Product;

public class ProductDAO {
    private String jdbcURL = "jdbc:postgresql://localhost:5432/projetjee";
    private String jdbcUsername = "postgres";
    private String jdbcPassword = "wej2003";

    private static final String INSERT_PRODUCTS_SQL = "INSERT INTO products (nom, description, prix, image, stock, category) VALUES (?, ?, ?, ?, ?, ?);";
    private static final String UPDATE_STOCK_SQL = "UPDATE products SET stock = ? WHERE id = ?";
    private static final String SELECT_PRODUCT_BY_ID = "SELECT id, nom, description, prix, image, stock, category FROM products WHERE id = ?;";
    private static final String SELECT_ALL_PRODUCTS = "SELECT * FROM products;";
    private static final String DELETE_PRODUCTS_SQL = "DELETE FROM products WHERE id = ?;";
    private static final String UPDATE_PRODUCTS_SQL = "UPDATE products SET nom = ?, description = ?, prix = ?, image = ?, stock = ?, category = ? WHERE id = ?;";
    private static final String SEARCH_PRODUCTS_SQL = "SELECT * FROM products WHERE LOWER(nom) LIKE ? OR LOWER(description) LIKE ?";

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException e) {
            // Handle SQL exception
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            // Handle class not found exception
            e.printStackTrace();
        }
        return connection;
    }

    public boolean insertProduct(Product product) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_PRODUCTS_SQL)) {
        	preparedStatement.setString(1, product.getName());
            preparedStatement.setString(2, product.getDescription());
            preparedStatement.setDouble(3, product.getPrice());
            preparedStatement.setString(4, product.getImagePath());
            preparedStatement.setInt(5, product.getStock());
            preparedStatement.setString(6, product.getCategory());
            return preparedStatement.executeUpdate() > 0;
        }
    }
    
    public boolean updateStock(int productId, int newStock) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_STOCK_SQL)) {
            preparedStatement.setInt(1, newStock);
            preparedStatement.setInt(2, productId);
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Product getProductById(int id) {
        Product product = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PRODUCT_BY_ID)) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
            	product = new Product(
                        rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("description"),
                        rs.getDouble("prix"),
                        rs.getString("image"),
                        rs.getInt("stock"),
                        rs.getString("category")
                    );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    public List<Product> selectAllProducts() {
        List<Product> products = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_PRODUCTS)) {
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
            	products.add(new Product(
                        rs.getInt("id"),
                        rs.getString("nom"),
                        rs.getString("description"),
                        rs.getDouble("prix"),
                        rs.getString("image"),
                        rs.getInt("stock"),
                        rs.getString("category")
                    ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public boolean deleteProduct(int id) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_PRODUCTS_SQL)) {
            preparedStatement.setInt(1, id);
            return preparedStatement.executeUpdate() > 0;
        }
    }

    public boolean updateProduct(Product product) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PRODUCTS_SQL)) {
        	preparedStatement.setString(1, product.getName());
            preparedStatement.setString(2, product.getDescription());
            preparedStatement.setDouble(3, product.getPrice());
            preparedStatement.setString(4, product.getImagePath());
            preparedStatement.setInt(5, product.getStock());
            preparedStatement.setString(6, product.getCategory());
            preparedStatement.setInt(7, product.getId());
            return preparedStatement.executeUpdate() > 0;
        }
    }
    
    public List<Product> selectProductsByCategoryWithLimit(String category, int limit) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products WHERE category = ? LIMIT ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, category);
            preparedStatement.setInt(2, limit);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                products.add(new Product(
                    rs.getInt("id"),
                    rs.getString("nom"),
                    rs.getString("description"),
                    rs.getDouble("prix"),
                    rs.getString("image"),
                    rs.getInt("stock"),
                    rs.getString("category")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public List<Product> searchProducts(String query) {
        List<Product> products = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SEARCH_PRODUCTS_SQL)) {
            String searchKeyword = "%" + query.toLowerCase() + "%";
            preparedStatement.setString(1, searchKeyword);
            preparedStatement.setString(2, searchKeyword);

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                products.add(new Product(
                    rs.getInt("id"),
                    rs.getString("nom"),
                    rs.getString("description"),
                    rs.getDouble("prix"),
                    rs.getString("image"),
                    rs.getInt("stock"),
                    rs.getString("category")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }


 }
