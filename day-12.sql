-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH DailyActivity AS(
  SELECT
    DATE(m.sent_at) AS chat_date,
    u.user_name,
    COUNT(m.message_id) AS message_count
  FROM
    npn_messages AS m
  JOIN
    npn_users AS u ON m.sender_id = u.user_id
  GROUP BY
    chat_date,
    u.user_name
  ),
  RankedActivity AS (
    SELECT
      chat_date,
      user_name,
      message_count,
      RANK() OVER (
        PARTITION BY chat_date
        ORDER BY message_count DESC
      ) AS activity_rank
  FROM
    DailyActivity
  )
  SELECT
    chat_date,
    user_name,
    message_count
  FROM
    RankedActivity
  WHERE
    activity_rank = 1
  ORDER BY
  chat_date;
