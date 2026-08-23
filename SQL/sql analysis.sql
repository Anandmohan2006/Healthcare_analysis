-- --------------------------------------------------
--              SQL Analysis
-- --------------------------------------------------

SELECT COUNT(*)
FROM patients;

select count(*)
from doctors ;

select count(*)
from appointments ;

select count(*)
from billing ;





SELECT appointment_status, COUNT(*)
FROM appointments
GROUP BY appointment_status;



SELECT SUM(amount) AS total_revenue
FROM billing;
 
 
--  TOTAL REVENUE OF EACH DEPARTMENT --
 
SELECT 
    d.department,
    SUM(b.amount) AS total_revenue
FROM billing b
JOIN appointments a
    ON b.appointment_id = a.appointment_id
JOIN doctors d
    ON a.doctor_id = d.doctor_id
GROUP BY d.department
ORDER BY total_revenue DESC;



-- Hospital me kis department ke paas sabse zyada patient appointments hain? --

SELECT
    d.department,
    COUNT(a.appointment_id) AS total_appointments
FROM appointments a
JOIN doctors d
    ON a.doctor_id = d.doctor_id
GROUP BY d.department
ORDER BY total_appointments DESC;

-- Hospital management wants to know the gender distribution of its patients

SELECT gender, COUNT(*) AS total_patients 
FROM patients
GROUP BY gender;


select first_name 
from patients
where city = 'mumbai';

-- Hospital ke patients sabse zyada kis city se aa rahe hain?

SELECT city, COUNT(*) AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC;

-- Hospital ke patients kis age group me sabse zyada hain?

SELECT
    CASE
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) <= 18 THEN '0-18'
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) <= 35 THEN '19-35'
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) <= 60 THEN '36-60'
        ELSE '61+'
    END AS age_group,
    COUNT(*) AS total_patients
FROM patients
GROUP BY age_group
ORDER BY total_patients desc;

-- Patients me sabse common diagnosis kya hai?

SELECT diagnosis, COUNT(*) AS total_cases
FROM appointments
GROUP BY diagnosis
ORDER BY total_cases DESC;

-- Kaunsi diagnosis hospital ke liye sabse zyada revenue generate kar rahi hai?

SELECT
    a.diagnosis,
    SUM(b.amount) AS total_revenue
FROM appointments a
JOIN billing b
    ON a.appointment_id = b.appointment_id
GROUP BY a.diagnosis
ORDER BY total_revenue DESC;

-- Top 10 Doctors by Appointments

SELECT
    d.doctor_name,
    d.department,
    COUNT(a.appointment_id) AS total_appointments
FROM doctors d
JOIN appointments a
    ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name, d.department
ORDER BY total_appointments DESC
LIMIT 10;

-- Kaunse 10 doctors hospital ke liye sabse zyada revenue generate kar rahe hain?

SELECT
    d.doctor_name,
    d.department,
    SUM(b.amount) AS total_revenue
FROM doctors d
JOIN appointments a
    ON d.doctor_id = a.doctor_id
JOIN billing b
    ON a.appointment_id = b.appointment_id
GROUP BY d.doctor_id, d.doctor_name, d.department
ORDER BY total_revenue DESC
LIMIT 10;  

-- Department-wise Cancellation Rate

SELECT
    d.department,
    COUNT(*) AS total_appointments,

    SUM(
        CASE
            WHEN a.appointment_status = 'Cancelled'
            THEN 1
            ELSE 0
        END
    ) AS cancelled_appointments,

    (
        SUM(
            CASE
                WHEN a.appointment_status = 'Cancelled'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*)
    ) * 100 AS cancellation_rate

FROM appointments a

JOIN doctors d
    ON a.doctor_id = d.doctor_id

GROUP BY d.department

ORDER BY cancellation_rate DESC;


-- Hospital ki monthly revenue performance kya hai, aur kaunsa month sabse zyada revenue generate karta hai?

SELECT
    DATE_FORMAT(b.bill_date, '%Y-%m') AS month,
    SUM(b.amount) AS total_revenue
FROM billing b
GROUP BY month
ORDER BY total_revenue DESC;

-- Patients hospital bills ka payment kis method se sabse zyada kar rahe hain?

SELECT
    payment_method,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_revenue
FROM billing
GROUP BY payment_method
ORDER BY total_revenue DESC;