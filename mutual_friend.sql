WITH
karl_friends AS (
  SELECT friend_id
  FROM friends
  WHERE user_id = (SELECT user_id FROM users WHERE user_name = 'Karl')
),
hans_friends AS (
  SELECT friend_id
  FROM friends
  WHERE user_id = (SELECT user_id FROM users WHERE user_name = 'Hans')
),
mutual_friends AS (
  SELECT k.friend_id AS user_id
  FROM karl_friends k
  INNER JOIN hans_friends h ON k.friend_id = h.friend_id
)
SELECT u.user_id, u.user_name
FROM mutual_friends mf
JOIN users u ON mf.user_id = u.user_id;

