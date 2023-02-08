DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
)

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  associated_author INTEGER NOT NULL,

  FOREIGN KEY (associated_author) REFERENCES users(id)
)

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (

)

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY
  reply_id INTEGER NOT NULL
  user_reply INTEGER NOT NULL
  question_id INTEGER NOT NULL


  FOREIGN KEY (reply_id) REFERENCES questions(id)
  FOREIGN KEY (user_reply) REFERENCES users(id)
)

