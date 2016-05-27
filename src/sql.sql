-- Table: users

CREATE TABLE users
(
  user_id bigserial NOT NULL,
  username character(20),
  parola character(20),
  varsta integer,
  oras character(20),
  blocat boolean,
  CONSTRAINT user_pk PRIMARY KEY (user_id)
)
WITH (
OIDS=FALSE
);
ALTER TABLE users
OWNER TO fasttrackit_dev;


-- Table: post

CREATE TABLE post
(
  id integer NOT NULL,
  mesaj character(50),
  data date
)
WITH (
OIDS=TRUE
);
ALTER TABLE post
OWNER TO fasttrackit_dev;


--populare tabel users

INSERT INTO users (username,parola,varsta,oras,blocat) VALUES
  ('ionel','12345',35,'cluj',FALSE),
  ('manu','645321',22,'cluj',TRUE),
  ('andreea','hello',18,'timisoara',FALSE),
  ('daniel','badboy1',28,'constanta',TRUE),
  ('amalia','flowerpower',15,'galati',FALSE),
  ('beniamin','parola',29,'oradea',TRUE),
  ('larisa','elcapitan',45,'arad',TRUE)


--populare tabel post

INSERT INTO post (id, mesaj,data) VALUES
  (2,'hello world','20160512'),
  (1, 'cucu bau','20160530'),
  (3, 'socant, da click pentru a afla','20160414'),
  (1, 'am gasit un bug','20160325'),
  (4, 'va pup dulce pe totzi','20160421'),
  (5, 'niiiiinge!','20160111')

-- Postarile lui Ionel

SELECT mesaj,data
FROM post
WHERE post.id=1;

-- afisare useri

SELECT username
FROM users;

-- afisare useri neblocati

SELECT username
FROM users
WHERE blocat = false;

-- afisare user cu cea mai mica varsta

SELECT username
FROM users
WHERE varsta = (select min(varsta) from users);

-- afisare media varstei userilor blocati

SELECT AVG (varsta)
FROM users
WHERE blocat=true;

-- useri neblocati din dej

SELECT username
FROM users
WHERE blocat = false AND oras = 'dej';

--afisare postari ale userilor blocati din Constanta, cu varsta peste 20 ani

SELECT post.mesaj
FROM post
INNER JOIN users
ON users.user_id=post.id
WHERE users.oras = 'constanta' AND users.blocat = TRUE AND users.varsta > 20;

-- userul cu cele mai multe postari

SELECT username
FROM users
JOIN post
ON users.user_id = post.id
GROUP BY username
ORDER BY count(*) DESC
LIMIT 1;

--afisare postari ale userilor al caror nume incepe cu i si data postarii itnre 1 martie 2016 si 31 martie 2016
SELECT mesaj
FROM post
JOIN users
ON users.user_id=post.id
WHERE username LIKE 'i%' AND (post.data >'20160301' AND post.data<'20160331');

-- mesajele postate in ordine descrescatoare indiferent de user

SELECT mesaj
FROM post
JOIN users
ON users.user_id=post.id
ORDER BY post.data DESC;


-- sterge postarile userilor sub 25 ani care contin "hello"

DELETE FROM post
USING users
WHERE users.user_id = post.id
AND mesaj LIKE '%hello%' AND varsta < 25;
