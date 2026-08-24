-- Har department me kitne doctors available hain?
-- Department-wise Doctor Count




SELECT
    department,
    COUNT(*) AS total_doctors
FROM doctors
GROUP BY department
ORDER BY total_doctors DESC;



SELECT
    d.doctor_name,
    d.department,
    COUNT(a.appointment_id) AS total_appointments
FROM doctors d
JOIN appointments a
    ON d.doctor_id = a.doctor_id
GROUP BY
    d.doctor_id,
    d.doctor_name,
    d.department
ORDER BY total_appointments DESC
LIMIT 10;



-- Repeat Patients

SELECT
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    COUNT(a.appointment_id) AS total_appointments
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY
    p.patient_id,
    p.first_name,
    p.last_name
HAVING COUNT(a.appointment_id) > 1
ORDER BY total_appointments DESC; 


-- Repeat Patients se Kitna Revenue Aa Raha Hai?

SELECT
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    COUNT(DISTINCT a.appointment_id) AS total_appointments,
    SUM(b.amount) AS total_revenue
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
JOIN billing b
    ON a.appointment_id = b.appointment_id
GROUP BY
    p.patient_id,
    p.first_name,
    p.last_name
HAVING COUNT(DISTINCT a.appointment_id) > 1
ORDER BY total_revenue DESC;


-- Diagnosis-wise Treatment Cost

SELECT
    diagnosis,
    COUNT(*) AS total_cases,
    ROUND(AVG(treatment_cost), 2) AS avg_treatment_cost,
    SUM(treatment_cost) AS total_treatment_cost
FROM appointments
WHERE appointment_status = 'Completed'
GROUP BY diagnosis
ORDER BY avg_treatment_cost DESC;

-- Doctor Workload vs Revenue

SELECT
    d.doctor_name,
    d.department,
    COUNT(a.appointment_id) AS total_appointments,
    SUM(b.amount) AS total_revenue,
    ROUND(AVG(a.treatment_cost), 2) AS avg_treatment_cost
FROM doctors d
JOIN appointments a
    ON d.doctor_id = a.doctor_id
JOIN billing b
    ON a.appointment_id = b.appointment_id
WHERE a.appointment_status = 'Completed'
GROUP BY
    d.doctor_id,
    d.doctor_name,
    d.department
ORDER BY total_revenue DESC;



