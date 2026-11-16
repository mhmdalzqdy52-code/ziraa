CREATE DATABASE IF NOT EXISTS agri_services_db;
USE agri_services_db;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone VARCHAR(30),
    user_type ENUM('farmer', 'supplier', 'mechanic', 'specialist', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE suppliers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    company_name VARCHAR(150) NOT NULL,
    location VARCHAR(200),
    contact_info VARCHAR(200),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT NOT NULL,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(80),
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    availability ENUM('In Stock', 'Limited', 'Out of Stock') DEFAULT 'In Stock',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
);

CREATE TABLE mechanics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    specialization VARCHAR(120),
    experience_years INT,
    description TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    provider_type ENUM('mechanic', 'specialist') NOT NULL,
    provider_id INT NOT NULL,
    service_name VARCHAR(150) NOT NULL,
    description TEXT,
    fee DECIMAL(10,2) DEFAULT 0.00
);

CREATE TABLE specialists (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    specialization VARCHAR(120),
    qualifications VARCHAR(200),
    experience_years INT,
    consultation_fee DECIMAL(10,2) NOT NULL,
    consultation_types VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE service_requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    farmer_id INT NOT NULL,
    mechanic_id INT,
    equipment_name VARCHAR(150) NOT NULL,
    problem_description TEXT NOT NULL,
    status ENUM('Pending', 'Accepted', 'In Progress', 'Completed', 'Rejected') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (farmer_id) REFERENCES users(id)
);

CREATE TABLE appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    farmer_id INT NOT NULL,
    specialist_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    appointment_type ENUM('In-Person', 'Online') NOT NULL,
    status ENUM('Pending Payment', 'Confirmed', 'Cancelled', 'Completed') DEFAULT 'Pending Payment',
    fee DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (farmer_id) REFERENCES users(id),
    FOREIGN KEY (specialist_id) REFERENCES specialists(id)
);

CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_status ENUM('Pending', 'Paid', 'Failed') DEFAULT 'Pending',
    payment_date TIMESTAMP NULL,
    transaction_reference VARCHAR(120),
    FOREIGN KEY (appointment_id) REFERENCES appointments(id)
);

CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
