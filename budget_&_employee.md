### 🧠 **STEP 1: Understand the Problem**

Given a list of projects and employees mapped to each project, calculate by the amount of project budget allocated to each employee. The output should include the project title and the project budget rounded to the closest integer. Order your list by projects with the highest budget per employee first.

⛳It's straightforward only but bit twisted, read the question carefully and give it a try! 👇

𝐒𝐜𝐡𝐞𝐦𝐚 𝐚𝐧𝐝 𝐃𝐚𝐭𝐚𝐬𝐞𝐭:
CREATE TABLE ms_projects(id int, title varchar(15), budget int);
INSERT INTO ms_projects VALUES (1, 'Project1',  29498),(2, 'Project2',  32487),(3, 'Project3',  43909),(4, 'Project4',  15776),(5, 'Project5',  36268),(6, 'Project6',  41611),(7, 'Project7',  34003),(8, 'Project8',  49284),(9, 'Project9',  32341),(10, 'Project10',    47587),(11, 'Project11',    11705),(12, 'Project12',    10468),(13, 'Project13',    43238),(14, 'Project14',    30014),(15, 'Project15',    48116),(16, 'Project16',    19922),(17, 'Project17',    19061),(18, 'Project18',    10302),(19, 'Project19',    44986),(20, 'Project20',    19497);

CREATE TABLE ms_emp_projects(emp_id int, project_id int);
INSERT INTO ms_emp_projects VALUES (10592,  1),(10593,  2),(10594,  3),(10595,  4),(10596,  5),(10597,  6),(10598,  7),(10599,  8),(10600,  9),(10601,  10),(10602, 11),(10603, 12),(10604, 13),(10605, 14),(10606, 15),(10607, 16),(10608, 17),(10609, 18),(10610, 19),(10611, 20);

You're given:
- A list of **projects** (`ms_projects`), each with:
  - an `id`
  - a `title`
  - a `budget`
  
- A list of **employee-project mappings** (`ms_emp_projects`), where each row links:
  - an `emp_id` to a `project_id`

Your **goal** is to find:
- How much **budget is allocated per employee** for each project
- Output the **project title**, **total project budget** (rounded), and **budget per employee**
- Sort by **highest budget per employee**

---

### 📐 **STEP 2: How to Think Through It**

#### 2.1 — What do we need?
- `project title`: from `ms_projects`
- `project budget`: from `ms_projects`
- `number of employees per project`: we’ll get this by **counting** how many `emp_id`s map to each `project_id` in `ms_emp_projects`
- Then, **divide** budget by number of employees

#### 2.2 — What operation connects the two tables?
- **Join** them using `project_id` (in `ms_emp_projects`) and `id` (in `ms_projects`)

#### 2.3 — What grouping is needed?
- We want to **group by project**, so we can count employees for each project.

---

### 🧱 **STEP 3: Write the Query Part-by-Part**

#### ✅ Part 1: Start with the JOIN
We want to combine project info with employee mapping.

```sql
FROM ms_projects p
JOIN ms_emp_projects ep
  ON p.id = ep.project_id
```

Now we have a "combined" view where each row has:
- project info (like title, budget)
- and the emp_id working on it

---

#### ✅ Part 2: SELECT what we need
From this joined data, we select:
- `p.title` — project name
- `p.budget` — total budget
- `ROUND(p.budget * 1.0 / COUNT(ep.emp_id))` — budget per employee

We multiply by `1.0` to ensure **float division** before rounding.

```sql
SELECT 
  p.title,
  p.budget,
  ROUND(p.budget * 1.0 / COUNT(ep.emp_id)) AS budget_per_employee
```

---

#### ✅ Part 3: Group the results
We want 1 result per project, so we **group by project**.

```sql
GROUP BY p.id, p.title, p.budget
```

We use `p.id` in the `GROUP BY` to make it more precise (since `title` and `budget` could theoretically repeat, though unlikely).

---

#### ✅ Part 4: Order the results
We want to show projects with **highest budget per employee first**:

```sql
ORDER BY budget_per_employee DESC
```

---

### 🧩 Final Query (Assembled)

```sql
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
```

---

### 🧪 BONUS: What if a project had more than one employee?

The query still works! For example:
- Project A has budget = 10,000 and 2 employees
- Then `10000 / 2 = 5000` → that becomes the `budget_per_employee`

