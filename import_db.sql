DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

PRAGMA foreign_keys = ON;


CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

INSERT INTO
  users (fname, lname)
VALUES
  ("Ariel", "Baez"),
  ("Keval", "Shah");


CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
  questions (title, body, author_id)
SELECT
  "Ariel Question", "ARIEL ARIEL ARIEL", 1
FROM
  users
WHERE
  users.fname = "Ariel" AND users.lname = "Baez";

INSERT INTO
  questions (title, body, author_id)
SELECT
  "Keval Question", "KEVAL KEVAL KEVAL", users.id
FROM
  users
WHERE
  users.fname = "Keval" AND users.lname = "Shah";

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = "Ariel" AND lname = "Baez"),
  (SELECT id FROM questions WHERE title = "Keval Question")),

  ((SELECT id FROM users WHERE fname = "Keval" AND lname = "Shah"),
  (SELECT id FROM questions WHERE title = "Keval Question")
);


-- REPLIES


CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  author_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
  replies (question_id, parent_reply_id, author_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = "Keval Question"),
  NULL,
  (SELECT id FROM users WHERE fname = "Ariel" AND lname = "Baez"),
  "How do you do?"
);

INSERT INTO
  replies (question_id, parent_reply_id, author_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = "Keval Question"),
  (SELECT id FROM replies WHERE body = "How do you do?"),
  (SELECT id FROM users WHERE fname = "Ariel" AND lname = "Baez"),
  "I am doing just fine."
);


CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = "Ariel" AND lname = "Baez"),
  (SELECT id FROM questions WHERE title = "Keval Question")
);

INSERT INTO 
  question_likes (user_id, question_id) 
VALUES 
  (1, 1);
INSERT INTO 
  question_likes (user_id, question_id) 
VALUES 
  (1, 2);