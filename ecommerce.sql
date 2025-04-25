-- Table to store brand information
CREATE TABLE brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each brand
    brand_name VARCHAR(255) NOT NULL -- Name of the brand
);

-- Table to store product categories, with support for hierarchical categories
CREATE TABLE product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each category
    category_name VARCHAR(255) NOT NULL, -- Name of the category
    parent_category_id INT, -- Reference to parent category for hierarchical structure
    FOREIGN KEY (parent_category_id) REFERENCES product_category(category_id) -- Self-referencing foreign key
);

-- Table to store product details
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each product
    name VARCHAR(255) NOT NULL, -- Name of the product
    brand_id INT, -- Reference to the brand of the product
    base_price DECIMAL(10, 2) NOT NULL, -- Base price of the product
    category_id INT, -- Reference to the category of the product
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id), -- Foreign key to the brand table
    FOREIGN KEY (category_id) REFERENCES product_category(category_id) -- Foreign key to the product_category table
);

-- Table to store size categories (e.g., clothing sizes, shoe sizes)
CREATE TABLE size_category (
    size_category_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each size category
    category_name VARCHAR(255) NOT NULL -- Name of the size category
);

-- Table to store size options within a size category
CREATE TABLE size_option (
    size_option_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each size option
    size_category_id INT, -- Reference to the size category
    size_name VARCHAR(50) NOT NULL, -- Name of the size (e.g., Small, Medium, Large)
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id) -- Foreign key to the size_category table
);

-- Table to store color options
CREATE TABLE color (
    color_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each color
    color_name VARCHAR(50) NOT NULL -- Name of the color
);

-- Table to store individual product items (e.g., specific SKU)
CREATE TABLE product_item (
    product_item_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each product item
    product_id INT, -- Reference to the product
    sku VARCHAR(100) NOT NULL, -- Stock Keeping Unit (SKU) for the product item
    stock_quantity INT NOT NULL, -- Quantity of the product item in stock
    FOREIGN KEY (product_id) REFERENCES product(product_id) -- Foreign key to the product table
);

-- Table to store variations of a product item (e.g., color and size combinations)
CREATE TABLE product_variation (
    variation_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each variation
    product_item_id INT, -- Reference to the product item
    color_id INT, -- Reference to the color
    size_option_id INT, -- Reference to the size option
    FOREIGN KEY (product_item_id) REFERENCES product_item(product_item_id), -- Foreign key to the product_item table
    FOREIGN KEY (color_id) REFERENCES color(color_id), -- Foreign key to the color table
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id) -- Foreign key to the size_option table
);

-- Table to store attribute categories (e.g., material, weight)
CREATE TABLE attribute_category (
    attribute_category_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each attribute category
    category_name VARCHAR(255) NOT NULL -- Name of the attribute category
);

-- Table to store attribute types (e.g., numeric, text)
CREATE TABLE attribute_type (
    attribute_type_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each attribute type
    type_name VARCHAR(50) NOT NULL -- Name of the attribute type
);

-- Table to store product-specific attributes
CREATE TABLE product_attribute (
    attribute_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each attribute
    product_id INT, -- Reference to the product
    attribute_category_id INT, -- Reference to the attribute category
    attribute_value TEXT, -- Value of the attribute
    FOREIGN KEY (product_id) REFERENCES product(product_id), -- Foreign key to the product table
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id) -- Foreign key to the attribute_category table
);

-- Table to store product images
CREATE TABLE product_image (
    image_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each image
    product_item_id INT, -- Reference to the product item
    image_url VARCHAR(255) NOT NULL, -- URL of the image
    is_primary BOOLEAN DEFAULT FALSE, -- Indicates if the image is the primary image for the product item
    FOREIGN KEY (product_item_id) REFERENCES product_item(product_item_id) -- Foreign key to the product_item table
);