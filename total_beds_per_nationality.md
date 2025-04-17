Sure! Here's a comprehensive, well-structured guidebook for this problem — useful for documentation, onboarding, or even training purposes.

---

# 🛏️ Airbnb Beds Analysis by Host Nationality – Guidebook

---

## 📘 Problem Statement

Find the total number of available beds per hosts' nationality.
Output the nationality along with the corresponding total number of available beds. Sort records by the total available beds in descending order.

𝐒𝐜𝐡𝐞𝐦𝐚 𝐚𝐧𝐝 𝐃𝐚𝐭𝐚𝐬𝐞𝐭:
CREATE TABLE airbnb_apartments(host_id int,apartment_id varchar(5),apartment_type varchar(10),n_beds int,n_bedrooms int,country varchar(20),city varchar(20));
INSERT INTO airbnb_apartments VALUES(0,'A1','Room',1,1,'USA','NewYork'),(0,'A2','Room',1,1,'USA','NewJersey'),(0,'A3','Room',1,1,'USA','NewJersey'),(1,'A4','Apartment',2,1,'USA','Houston'),(1,'A5','Apartment',2,1,'USA','LasVegas'),(3,'A7','Penthouse',3,3,'China','Tianjin'),(3,'A8','Penthouse',5,5,'China','Beijing'),(4,'A9','Apartment',2,1,'Mali','Bamako'),(5,'A10','Room',3,1,'Mali','Segou')

CREATE TABLE airbnb_hosts(host_id int,nationality  varchar(15),gender varchar(5),age int);
INSERT INTO airbnb_hosts  VALUES(0,'USA','M',28),(1,'USA','F',29),(2,'China','F',31),(3,'China','M',24),(4,'Mali','M',30),(5,'Mali','F',30);

**Goal:**  
Calculate the **total number of available beds per host's nationality**, and return the results sorted in **descending order** of the number of beds.

---

## 🧱 Database Schema

### 1. Table: `airbnb_apartments`

| Column Name     | Data Type   | Description                           |
|------------------|--------------|----------------------------------------|
| host_id          | `int`        | ID of the host who owns the apartment |
| apartment_id     | `varchar(5)` | Unique ID for the apartment           |
| apartment_type   | `varchar(10)`| Type of listing (Room, Apartment etc.)|
| n_beds           | `int`        | Number of beds in the apartment       |
| n_bedrooms       | `int`        | Number of bedrooms                    |
| country          | `varchar(20)`| Country where the apartment is located|
| city             | `varchar(20)`| City where the apartment is located   |

### 2. Table: `airbnb_hosts`

| Column Name     | Data Type     | Description                          |
|------------------|----------------|---------------------------------------|
| host_id          | `int`          | Unique ID for the host               |
| nationality      | `varchar(15)`  | Nationality of the host              |
| gender           | `varchar(5)`   | Gender of the host                   |
| age              | `int`          | Age of the host                      |

---

## 🧪 Sample Data

### Table: `airbnb_apartments`

| host_id | apartment_id | apartment_type | n_beds | n_bedrooms | country | city      |
|---------|--------------|----------------|--------|------------|---------|-----------|
| 0       | A1           | Room           | 1      | 1          | USA     | NewYork   |
| 0       | A2           | Room           | 1      | 1          | USA     | NewJersey |
| 0       | A3           | Room           | 1      | 1          | USA     | NewJersey |
| 1       | A4           | Apartment      | 2      | 1          | USA     | Houston   |
| 1       | A5           | Apartment      | 2      | 1          | USA     | LasVegas  |
| 3       | A7           | Penthouse      | 3      | 3          | China   | Tianjin   |
| 3       | A8           | Penthouse      | 5      | 5          | China   | Beijing   |
| 4       | A9           | Apartment      | 2      | 1          | Mali    | Bamako    |
| 5       | A10          | Room           | 3      | 1          | Mali    | Segou     |

### Table: `airbnb_hosts`

| host_id | nationality | gender | age |
|---------|-------------|--------|-----|
| 0       | USA         | M      | 28  |
| 1       | USA         | F      | 29  |
| 2       | China       | F      | 31  |
| 3       | China       | M      | 24  |
| 4       | Mali        | M      | 30  |
| 5       | Mali        | F      | 30  |

---

## 🧠 Understanding the Logic

1. **Beds are stored in the `airbnb_apartments` table**, not the `hosts` table.
2. To analyze beds by **host nationality**, we need to **join** `airbnb_apartments` with `airbnb_hosts` using `host_id`.
3. Group the joined data by `nationality`.
4. Aggregate the number of beds using `SUM`.
5. Sort the results in descending order of the total beds.

---

## 🧾 SQL Solution

```sql
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
```

---

## ✅ Output

| nationality | total_beds |
|-------------|------------|
| China       | 8          |
| USA         | 7          |
| Mali        | 5          |

---

## 📝 Explanation

Let’s break it down:

- Host **ID 0 (USA)** has 3 apartments: A1, A2, A3 → Beds = 1+1+1 = 3  
- Host **ID 1 (USA)** has 2 apartments: A4, A5 → Beds = 2+2 = 4  
  - **Total for USA** = 3 + 4 = **7**

- Host **ID 3 (China)** has 2 apartments: A7, A8 → Beds = 3+5 = **8**

- Hosts **ID 4 and 5 (Mali)** have A9 and A10 → Beds = 2 + 3 = **5**

---

## 📚 Key SQL Concepts Used

- `JOIN`: To combine apartment and host data via `host_id`
- `SUM()`: To get total beds
- `GROUP BY`: To aggregate by nationality
- `ORDER BY`: To sort results

---

## 🧩 Extensions & Variations

- Show average beds per nationality: `AVG(n_beds)`
- Filter by minimum age of host
- Breakdown by gender + nationality
- Show top 1 nationality with max beds: Add `LIMIT 1`

---

Let me know if you'd like a PDF version of this guide or want me to turn this into a styled HTML or Markdown document for your team or website!