-- SQL Advent Calendar - Day 5
-- Title: Elf Vacation Status
-- Difficulty: medium
--
-- Question:
-- Some elves took time off after the holiday rush, but not everyone has returned to work. List all elves by name, showing their return date. If they have not returned from vacation, list their return date as "Still resting".
--
-- Some elves took time off after the holiday rush, but not everyone has returned to work. List all elves by name, showing their return date. If they have not returned from vacation, list their return date as "Still resting".
--

-- Table Schema:
-- Table: elves
--   elf_id: INT
--   elf_name: VARCHAR
--
-- Table: vacations
--   elf_id: INT
--   start_date: DATE
--   return_date: DATE
--

-- My Solution:

WITH LatestReturn AS (
  SELECT
      elf_id,
      MAX(return_date) AS most_recent_return
  FROM
      vacations
  GROUP BY
      elf_id
  )
SELECT
    e.elf_name,
    COALESCE(
      STRFTIME('%Y-%m-%d', lr.most_recent_return),
      'Still resting'
  )AS return_status

  FROM
      elves AS e
  LEFT JOIN
      latestReturn As lr ON e.elf_id = lr.elf_id;
