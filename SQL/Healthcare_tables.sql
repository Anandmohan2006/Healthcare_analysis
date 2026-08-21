CREATE DATABASE healthcare;

USE healthcare;

-- --------------------------------------------------
--              Patients table
-- --------------------------------------------------        
             
CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    gender VARCHAR(10),
    date_of_birth DATE,
    city VARCHAR(50),
    registration_date DATE
);



-- --------------------------------------------------
--              Doctor table
-- --------------------------------------------------

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    specialization VARCHAR(100),
    experience_years INT,
    consultation_fee DECIMAL(10,2)
);

-- --------------------------------------------------
--              Appointment table
-- --------------------------------------------------

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL, 
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_status VARCHAR(20) NOT NULL,
    diagnosis VARCHAR(100),
    treatment_cost DECIMAL(10,2),

    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- --------------------------------------------------
--              Billing table
-- --------------------------------------------------

CREATE TABLE billing (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT NOT NULL,
    patient_id INT NOT NULL,
    bill_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(20),
    payment_status VARCHAR(20),

    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);




