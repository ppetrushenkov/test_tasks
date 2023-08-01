-- Active: 1690281644481@@127.0.0.1@5432@postgres
WITH RECURSIVE r AS (
	SELECT "key", id, phone, mail
	FROM t 
	WHERE phone = '87778885566'
	UNION
	SELECT t."key", t.id, t.phone, t.mail 
	FROM t 
	JOIN r 
		ON 
			t."key" = r."key" OR
			t.id = r.id 	  OR
			t.phone = r.phone OR 
			t.mail = r.mail
		
)
SELECT * FROM r;