**Problem Statement:**

Bank of Ireland has requested that you detect invalid transactions in December 2022. An invalid transaction is one that occurs outside of the bank's normal business hours. The following are the hours of operation for all branches:

* Monday - Friday: 09:00 - 16:00
* Saturday & Sunday: Closed
* Irish Public Holidays: 25th and 26th December

**Task:**
Determine the transaction ids of all invalid transactions.

**Dataset Schema:**

```sql
CREATE TABLE boi_transactions (
    transaction_id INT PRIMARY KEY,
    time_stamp DATETIME NOT NULL
);

INSERT INTO boi_transactions (transaction_id, time_stamp) VALUES
(1051, '2022-12-03 10:15'), (1052, '2022-12-03 17:00'),
(1053, '2022-12-04 10:00'), (1054, '2022-12-04 14:00'),
(1055, '2022-12-05 08:59'), (1056, '2022-12-05 16:01'),
(1057, '2022-12-06 09:00'), (1058, '2022-12-06 15:59'),
(1059, '2022-12-07 12:00'), (1060, '2022-12-08 09:00'),
(1061, '2022-12-09 10:00'), (1062, '2022-12-10 11:00'),
(1063, '2022-12-10 17:30'), (1064, '2022-12-11 12:00'),
(1065, '2022-12-12 08:59'), (1066, '2022-12-12 16:01'),
(1067, '2022-12-25 10:00'), (1068, '2022-12-25 15:00'),
(1069, '2022-12-26 09:00'), (1070, '2022-12-26 14:00'),
(1071, '2022-12-26 16:30'), (1072, '2022-12-27 09:00'),
(1073, '2022-12-28 08:30'), (1074, '2022-12-29 16:15'),
(1075, '2022-12-30 14:00'), (1076, '2022-12-31 10:00');
```

---

**Understanding the Problem:**

The goal is to find transactions that are invalid, meaning:

* Transactions that happen on a **Saturday** or **Sunday**.
* Transactions that happen on **December 25 or 26** (Irish public holidays).
* Transactions that happen **before 09:00** or **after 16:00**, even on weekdays.

In SQLite:

* `strftime('%w', time_stamp)` gives the day of the week: `0 = Sunday`, `6 = Saturday`.
* `time(time_stamp)` extracts the `HH:MM:SS` time portion.
* `strftime('%m-%d', time_stamp)` extracts the month-day part like '12-25'.

---

**Correct SQLite Query:**

```sql
SELECT transaction_id, time_stamp
FROM boi_transactions
WHERE (
    strftime('%w', time_stamp) IN ('0', '6') -- Sunday or Saturday
    OR strftime('%m-%d', time_stamp) IN ('12-25','12-26') -- Public Holidays
    OR time(time_stamp) < '09:00:00' -- Before business hours
    OR time(time_stamp) > '16:00:00' -- After business hours
);
```

---

**Explanation of Query Conditions:**

* `strftime('%w', time_stamp) IN ('0', '6')`: captures all Saturday and Sunday transactions.
* `strftime('%m-%d', time_stamp) IN ('12-25', '12-26')`: captures the public holidays.
* `time(time_stamp) < '09:00:00'`: filters out transactions that occurred before the start of the workday.
* `time(time_stamp) > '16:00:00'`: filters out transactions that occurred after the workday ended.

---

**Generalizing for All-Year Data:**
If your dataset includes transactions from other months and years too, the same query will still work. It will flag any transaction that occurred on weekends, outside working hours, or on the specified public holidays, regardless of the year or month.

If you want to restrict to a specific year (e.g., 2022), you can add this line:

```sql
AND strftime('%Y', time_stamp) = '2022'
```

---

**Final Notes:**

* The `strftime()` and `time()` functions make it easy to dissect `DATETIME` values in SQLite.
* You can use `NOT (...)` around the condition to extract valid transactions instead.
* Extend `strftime('%m-%d') IN (...)` for more holidays as needed.

This approach ensures accurate detection of invalid banking transactions based on business hours and specific rules set by Bank of Ireland.
