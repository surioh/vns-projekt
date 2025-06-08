package hbv.web;

public class Product {
	private long id;
	private String productName;
	private String productOrigin;
	private float pricePerKilo;

	public Product(long id, String productName, String productOrigin, float pricePerKilo) {
		this.id = id;
		this.productName = productName;
		this.productOrigin = productOrigin;
		this.pricePerKilo = pricePerKilo;
	}

	public String output() {
		return String.format("%d | %4s | %4s | %4.2f", id, productName, productOrigin, pricePerKilo);
	}
}
