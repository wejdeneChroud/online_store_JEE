package model;

public class Product {
    private int id;
    private String name;
    private String description;
    private double price;
    private String imagePath;
    private int stock;
    private String category;

    // Constructor without id, for creating new products
    public Product(String name, String description, double price, String imagePath, int stock, String category) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.imagePath = imagePath;
        this.stock = stock;
        this.setCategory(category);
    }

    // Constructor with id, for fetching from database
    public Product(int id, String name, String description, double price, String imagePath, int stock, String category) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.imagePath = imagePath;
        this.stock = stock;
        this.setCategory(category);
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    
    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
}
