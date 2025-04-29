Problem:
Find the genre of the person with the most number of oscar winnings.
If there are more than one person with the same number of oscar wins, return the first one in alphabetic order based on their name. Use the names as keys when joining the tables.

𝐒𝐜𝐡𝐞𝐦𝐚 𝐚𝐧𝐝 𝐃𝐚𝐭𝐚𝐬𝐞𝐭:
CREATE TABLE nominee_information(name varchar(20), amg_person_id varchar(10), top_genre varchar(10), birthday datetime, id int);

INSERT INTO nominee_information VALUES('Jennifer Lawrence','P562566','Drama','1990-08-15',755),('Jonah Hill','P418718','Comedy','1983-12-20',747),('Anne Hathaway', 'P292630','Drama', '1982-11-12',744),('Jennifer Hudson','P454405','Drama', '1981-09-12',742),('Rinko Kikuchi', 'P475244','Drama', '1981-01-06', 739);

CREATE TABLE oscar_nominees(year int, category varchar(30), nominee varchar(20), movie varchar(30), winner int, id int);

INSERT INTO oscar_nominees VALUES(2008,'actress in a leading role','Anne Hathaway','Rachel Getting Married',0,77),(2012,'actress in a supporting role','Anne HathawayLes','Mis_rables',1,78),(2006,'actress in a supporting role','Jennifer Hudson','Dreamgirls',1,711),(2010,'actress in a leading role','Jennifer Lawrence','Winters Bone',1,717),(2012,'actress in a leading role','Jennifer Lawrence','Silver Linings Playbook',1,718),(2011,'actor in a supporting role','Jonah Hill','Moneyball',0,799),(2006,'actress in a supporting role','Rinko Kikuchi','Babel',0,1253);

---

### **1. Understand the Problem Clearly**

- You have two tables: 
  - `nominee_information` (about people: name, genre, etc.)
  - `oscar_nominees` (about Oscar nominations: who, when, which movie, whether they won).

- Your **final goal** is to:
  - Find the **person with the most Oscar wins** (`winner = 1`).
  - If multiple people have the same number, pick the **alphabetically first** person.
  - **Return their genre** (`top_genre`).

---

### **2. Think About the Data Flow**

Ask yourself:
- Where do I find "how many times" a person won? ➔ **In `oscar_nominees`** table (`winner` column).
- Where do I find the "genre" of a person? ➔ **In `nominee_information`** table.

**Thus, you must combine (JOIN) the two tables.**

---

### **3. Plan the Main Steps**

1. **JOIN the tables** based on `name` (nominee name = person name).

2. **Filter only the rows where `winner = 1`**, because we only care about wins.

3. **GROUP BY** person name to **count the number of wins**.

4. **Sort**:
   - Highest win count **first**.
   - If tie, **alphabetical order** of names.

5. **Pick the first person** from this sorted list.

6. **Return** their `top_genre`.

---

### **4. Tools You Need to Use**

In SQL, you will need:
- `JOIN`
- `WHERE` (to filter winners)
- `GROUP BY`
- `COUNT(*)`
- `ORDER BY win_count DESC, name ASC`
- `ROW_NUMBER()` (to select only the top one cleanly)

---

### **5. Very Simple Pseudocode**

Just to visualize before writing SQL:
```
JOIN nominee_information and oscar_nominees ON name = nominee
FILTER where winner = 1
GROUP BY name
COUNT wins
ORDER BY wins DESC, name ASC
SELECT the first one's top_genre
```

---

### **6. Potential Problems to Watch Out For**
- Matching names **exactly** (like "Anne HathawayLes" vs "Anne Hathaway" — this can cause missing joins).
- If there are **multiple top winners**, sorting alphabetically.
- Be careful: you need the `top_genre` of the person, not just their name.

---

### **7. Final Tips**

- Always **JOIN early** when information is scattered across two tables.
- **Filter unnecessary rows early** (`WHERE winner = 1`) to reduce the data you have to work with.
- **Aggregate (GROUP BY + COUNT)** when you want totals.
- Use **ROW_NUMBER()** when you need to pick **just one** based on some order.

---

### **Summary: A simple 4-step thinking process**

| Step | Action |
|-----|---------|
| 1 | JOIN nominee_information and oscar_nominees |
| 2 | FILTER only the winners (winner = 1) |
| 3 | GROUP BY name, COUNT wins |
| 4 | ORDER BY count desc, name asc, PICK first one's genre |

---

WITH winner_counts AS (
    SELECT 
        ni.name,
        ni.top_genre,
        COUNT(*) AS win_count
    FROM nominee_information ni
    JOIN oscar_nominees on ni.name = oscar_nominees.nominee
    WHERE oscar_nominees.winner = 1 --First, you filter out only students who passed (winner=1).
    GROUP BY ni.name, ni.top_genre
),
ranked_winners AS (
    SELECT 
        name,
        top_genre,
        win_count,
        ROW_NUMBER() OVER (ORDER BY win_count DESC, name ASC) AS rn
    FROM winner_counts
)
SELECT top_genre
FROM ranked_winners
WHERE rn = 1; --Then you pick the topper (rn=1).
