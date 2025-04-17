SELECT 
    h.nationality,
    SUM(a.n_beds) AS total_beds
FROM 
    airbnb_apartments a
JOIN 
    airbnb_hosts h ON a.host_id = h.host_id
GROUP BY 
    h.nationality
ORDER BY 
    total_beds DESC;
