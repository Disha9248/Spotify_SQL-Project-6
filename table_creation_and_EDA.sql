
--------------- SPOTIFY DATA ANALYSIS PROJECT ------------------ 

-- table creation ---

CREATE TABLE spotify_data (

artist VARCHAR(300),
track VARCHAR(300),
album VARCHAR(300),
album_type VARCHAR(50),
danceability FLOAT,
energy FLOAT,
loudness FLOAT,	
speechiness FLOAT,
acousticness FLOAT,
instrumentalness FLOAT,	
liveness FLOAT,	
valence FLOAT,
tempo FLOAT,
duration_min FLOAT,	
title VARCHAR(300),
channel VARCHAR(200),
viewss BIGINT,
likes BIGINT,
commentss BIGINT,
licensed VARCHAR(10),
official_video VARCHAR(10),
stream BIGINT,
energyLiveness FLOAT,
most_playedon VARCHAR(50)

);



-- EDA 

SELECT COUNT(*)
FROM spotify_data; 

SELECT COUNT(DISTINCT artist)
FROM spotify_data; 

SELECT COUNT(DISTINCT aLbum)
FROM spotify_data; 

SELECT COUNT(DISTINCT album_type)
FROM spotify_data; 

SELECT DISTINCT album_type
FROM spotify_data; 

SELECT DISTINCT track
FROM spotify_data; 

SELECT AVG(loudness) AS loudness, 
       AVG(instrumentalness) AS instrumentalness, 
	   AVG(tempo) AS tempo,
	   AVG(duration_min) AS duration_min
FROM spotify_data; 

SELECT MAX(duration_min)
FROM spotify_data; 

SELECT MIN(duration_min)
FROM spotify_data; 

SELECT *
FROM spotify_data
WHERE duration_min = 0; 

DELETE
FROM spotify_data
WHERE duration_min = 0; 

SELECT AVG(viewss) AS viewss, 
       AVG(likes) AS likes, 
	   AVG(commentss) AS commentss
FROM spotify_data; 


SELECT DISTINCT licensed
FROM spotify_data; 

SELECT COUNT(*)
FROM spotify_data
WHERE  licensed = 'TRUE'; 

SELECT DISTINCT most_playedon
FROM spotify_data;