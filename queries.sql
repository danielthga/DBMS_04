--Query 5a:

SELECT 
    o.order_no,
    o.date,
    o.plate,
    w.description,
    w.hours
FROM customer c
JOIN "order" o ON c.cust_no = o.cust_no
JOIN work_item w ON o.order_no = w.order_no
WHERE c.cust_name = 'Berger, Franz'
ORDER BY o.date, w.item_no;

--Query 5b

SELECT 
    m.mech_name,
    ROUND(SUM(w.hours), 1) AS total_hours,
    COUNT(DISTINCT o.order_no) AS orders
FROM mechanic m
JOIN work_item w ON m.mech_id = w.mech_id
JOIN "order" o ON w.order_no = o.order_no
WHERE o.date BETWEEN '2026-03-01' AND '2026-03-31'
GROUP BY m.mech_id
ORDER BY total_hours DESC;

--Queries 5c

SELECT plate, model
FROM vehicle
EXCEPT
SELECT v.plate, v.model
FROM vehicle v
JOIN "order" o ON v.plate = o.plate;

-- Variant 2: NOT EXISTS

SELECT v.plate, v.model
FROM vehicle v
WHERE NOT EXISTS (
    SELECT 1
    FROM "order" o
    WHERE o.plate = v.plate
);
