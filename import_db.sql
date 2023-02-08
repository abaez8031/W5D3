PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS students;

CREATE TABLE students (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  associated_author INTEGER NOT NULL,

  FOREIGN KEY (associated_author) REFERENCES students(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES students(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  user INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  reply TEXT NOT NULL,


  FOREIGN KEY (user) REFERENCES students(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (id) REFERENCES replies(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (

  id INTEGER PRIMARY KEY,
  question INTEGER NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (question) REFERENCES questions(id),
  FOREIGN KEY (author_id) REFERENCES students(id)
);

INSERT INTO
  students(fname,lname)
VALUES
  ('Ariel', 'Baez'),
  ('Keval', 'Shah');

INSERT INTO
  questions(title,body,associated_author)
VALUES
  ('Ariel Question', 'ARIEL ARIEL ARIEL', (SELECT id FROM students WHERE fname = 'Ariel')),
  ('Keval Question', 'KEVAL KEVAL KEVAL', (SELECT id FROM students WHERE fname = 'Keval'));

-- INSERT INTO
--   question_follows(user_id,question_id)
-- VALUES
--   ((SELECT id FROM students WHERE fname = 'Ariel'), (SELECT id FROM questions WHERE associated_author = students.id));