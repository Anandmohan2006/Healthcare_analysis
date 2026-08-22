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


SELECT gender, COUNT(*) AS total_patients
FROM patients
GROUP BY gender;