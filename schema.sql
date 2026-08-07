-- ============================================================
-- Project: SQL E-Commerce Database
-- Author: Mille Soni
-- Database: PostgreSQL
-- ============================================================

-- ============================================================
-- DROP TABLES (Allows script to be run multiple times)
-- ============================================================

DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

-- ============================================================
-- CUSTOMERS TABLE
-- ============================================================

CREATE TABLE customers (

    customer_id SERIAL PRIMARY KEY,   

    first_name VARCHAR(50) NOT NULL,

    last_name VARCHAR(50) NOT NULL,

    email VARCHAR(100) UNIQUE NOT NULL,

    phone VARCHAR(20),

    city VARCHAR(50),

    registration_date DATE NOT NULL

);

-- ============================================================
-- CATEGORIES TABLE
-- ============================================================

CREATE TABLE categories (

    category_id SERIAL PRIMARY KEY,

    category_name VARCHAR(50) UNIQUE NOT NULL

);

-- ============================================================
-- PRODUCTS TABLE
-- ============================================================

CREATE TABLE products (

    product_id SERIAL PRIMARY KEY,

    category_id INTEGER NOT NULL,

    product_name VARCHAR(100) NOT NULL,

    description TEXT,

    price DECIMAL(10,2) NOT NULL,

    stock_quantity INTEGER NOT NULL,

    FOREIGN KEY (category_id)
        REFERENCES categories(category_id)

);

-- ============================================================
-- ORDERS TABLE
-- ============================================================

CREATE TABLE orders (

    order_id SERIAL PRIMARY KEY,

    customer_id INTEGER NOT NULL,

    order_date DATE NOT NULL,

    status VARCHAR(20) NOT NULL,

    total_amount DECIMAL(10,2),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)

);

-- ============================================================
-- ORDER ITEMS TABLE
-- ============================================================

CREATE TABLE order_items (

    order_item_id SERIAL PRIMARY KEY,

    order_id INTEGER NOT NULL,

    product_id INTEGER NOT NULL,

    quantity INTEGER NOT NULL,

    unit_price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)

);

-- ============================================================
-- PAYMENTS TABLE
-- ============================================================

CREATE TABLE payments (

    payment_id SERIAL PRIMARY KEY,

    order_id INTEGER NOT NULL,

    payment_date DATE NOT NULL,

    payment_method VARCHAR(50),

    payment_status VARCHAR(30),

    amount DECIMAL(10,2),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)

);

-- ============================================================
-- CREATE INDEXES
-- ============================================================

CREATE INDEX idx_customer_email
ON customers(email);

CREATE INDEX idx_product_name
ON products(product_name);

CREATE INDEX idx_order_date
ON orders(order_date);

CREATE INDEX idx_payment_date
ON payments(payment_date);

-- ============================================================
-- END OF SCHEMA
-- ============================================================