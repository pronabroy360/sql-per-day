SELECT 
    p.title,
    p.budget,
    ROUND(p.budget * 1.0 / COUNT(ep.emp_id)) AS budget_per_employee
FROM 
    ms_projects p
JOIN 
    ms_emp_projects ep 
    ON p.id = ep.project_id
GROUP BY 
    p.id, p.title, p.budget
ORDER BY 
    budget_per_employee DESC;
