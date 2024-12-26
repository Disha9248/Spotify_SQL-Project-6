
--------------- SPOTIFY DATA ANALYSIS PROJECT ------------------ 

---------------- EASY KEY PROBLEMS ------------------------

-- 1) Retrieve the names of all tracks that have more than 1 billion streams.
-- 2) List all albums along with their respective artists.
-- 3) Get the total number of comments for tracks where licensed = TRUE.
-- 4) Find all tracks that belong to the album type single.
-- 5) Count the total number of tracks by each artist.


---------------- SOLUTION ------------------------

SELECT *
FROM spotify_data;



-- 1) Retrieve the names of all tracks that have more than 1 billion streams.

SELECT track,
       stream
FROM spotify_data
WHERE stream > 1000000000;



-- 2) List all albums along with their respective artists.

SELECT DISTINCT album,
       artist
FROM spotify_data;



-- 3) Get the total number of comments for tracks where licensed = TRUE.

SELECT track,
       SUM(commentss) AS total_no_of_comments,
       licensed
FROM spotify_data
GROUP BY track, licensed
HAVING licensed = 'TRUE';



-- 4) Find all tracks that belong to the album type single.

SELECT track,
       album_type
FROM spotify_data
WHERE album_type = 'single';



-- 5) Count the total number of tracks by each artist.

SELECT artist,
       COUNT(track) AS no_of_tracks
FROM spotify_data
GROUP BY artist
ORDER BY no_of_tracks;


---------------- MEDIUM KEY PROBLEMS ------------------------

-- 1) Calculate the average danceability of tracks in each album.
-- 2) Find the top 5 tracks with the highest energy values.
-- 3) List all tracks along with their views and likes where official_video = TRUE.
-- 4) For each album, calculate the total views of all associated tracks.
-- 5) Retrieve the track names that have been streamed on Spotify more than YouTube.


---------------- SOLUTION ------------------------

SELECT *
FROM spotify_data;


-- 1) Calculate the average danceability of tracks in each album.

SELECT album,
	   AVG(danceability) AS avg_danceability
FROM spotify_data
GROUP BY album
ORDER BY avg_danceability DESC;



-- 2) Find the top 5 tracks with the highest energy values.

SELECT track,
       energy
FROM spotify_data
ORDER BY energy DESC
LIMIT 5;



-- 3) List all tracks along with their views and likes where official_video = TRUE.

SELECT track,
       SUM(viewss) AS viewss,
	   SUM(likes) AS likes,
	   official_video
FROM spotify_data
WHERE official_video = 'TRUE'
GROUP BY track,official_video;



-- 4) For each album, calculate the total views of all associated tracks.

SELECT album,
       track,
       SUM(viewss) AS total_views
FROM spotify_data
GROUP BY album,track
ORDER BY album,total_views DESC;



-- 5) Retrieve the track names that have been streamed on Spotify more than YouTube.

SELECT track
FROM spotify_data
GROUP BY track
HAVING SUM(CASE WHEN most_playedon = 'Spotify' THEN stream ELSE 0 END) >
       SUM(CASE WHEN most_playedon = 'Youtube' THEN stream ELSE 0 END);



---------------- ADVANCED KEY PROBLEMS ------------------------

-- 1) Find the top 3 most-viewed tracks for each artist using window functions.
-- 2) Write a query to find tracks where the liveness score is above the average.
-- 3) Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
-- 4) Find tracks where the energy-to-liveness ratio is greater than 1.2.
-- 5) Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.


---------------- SOLUTION ------------------------

SELECT *
FROM spotify_data;



-- 1) Find the top 3 most-viewed tracks for each artist using window functions.

WITH top_3_tracks AS (

	SELECT artist,
	       track,
	       SUM(viewss) AS total_views,
		   RANK() OVER(PARTITION BY artist ORDER BY SUM(viewss) DESC) AS rank
	FROM spotify_data
	GROUP BY artist,track
	ORDER BY artist,total_views DESC
	
)

SELECT *
FROM top_3_tracks
WHERE rank <= 3;



-- 2) Write a query to find tracks where the liveness score is above the average.

SELECT track,
       liveness
FROM spotify_data
WHERE liveness > (
                    SELECT AVG(liveness)
					FROM spotify_data
);



-- 3) Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.

WITH energy_values AS (

	SELECT album,
		   MAX(energy) AS highest_energy,
		   MIN(energy) AS lowest_energy
	FROM spotify_data
	GROUP BY album
	ORDER BY album

)

SELECT *,
       ROUND((highest_energy - lowest_energy)::NUMERIC,2) AS difference
FROM energy_values;


-- 4) Find tracks where the energy-to-liveness ratio is greater than 1.2.

WITH energy_to_liveness_ratio AS (
	
	SELECT track,
		   energy,
		   liveness,
		   (energy/liveness) AS ratio
	FROM spotify_data
	
)

SELECT track
FROM energy_to_liveness_ratio
WHERE ratio > 1.2

 

-- 5) Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.

SELECT track,
       viewss,
	   likes,
	   SUM(likes) OVER(ORDER BY viewss) AS cumulative_likes
FROM spotify_data
ORDER BY viewss;


---------------- QUERY OPTIMIZATION -------------------------


-- 4) Find all tracks that belong to the album type single.

-- Execution time - 36.815 ms

EXPLAIN ANALYSE 
SELECT track,
       album_type
FROM spotify_data
WHERE album_type = 'single';


-- Execution Time: 7.324 ms
-- Using limit and order by

EXPLAIN ANALYSE 
SELECT track,
       album_type
FROM spotify_data
WHERE album_type = 'single'
ORDER BY track
LIMIT 20;

CREATE INDEX album_index ON spotify_data(album_type);


-------------- AFTER INDEX ---------------------


-- Execution Time: 2.254 ms

EXPLAIN ANALYSE 
SELECT track,
       album_type
FROM spotify_data
WHERE album_type = 'single';


-- Execution Time: 3.126 ms
-- Using limit and order by

EXPLAIN ANALYSE 
SELECT track,
       album_type
FROM spotify_data
WHERE album_type = 'single'
ORDER BY track
LIMIT 20;


