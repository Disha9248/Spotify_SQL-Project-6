# Spotify SQL Project 

![Spotify logo](https://github.com/user-attachments/assets/81d073e0-67e4-452a-a883-1531d6cbcfb7)

[Click Here to get Dataset](https://www.kaggle.com/datasets/sanjanchaudhari/spotify-dataset)


## Overview
This project involves analyzing a Spotify dataset with various attributes about tracks, albums, and artists using **SQL**. 
It covers an end-to-end process of normalizing a denormalized dataset, performing SQL queries of varying complexity 
(easy, medium, and advanced), and optimizing query performance. The primary goals of the project are to practice SQL skills
and generate valuable insights from the dataset.

---

## Project Steps

### 1. Data Exploration
Before diving into SQL, it’s important to understand the dataset thoroughly. The dataset contains attributes such as:
- `Artist`: The performer of the track.
- `Track`: The name of the song.
- `Album`: The album to which the track belongs.
- `Album_type`: The type of album (e.g., single or album).
- Various metrics such as `danceability`, `energy`, `loudness`, `tempo`, and more.



### 2. Querying the Data
After the data is inserted, various SQL queries  written to explore and analyze the data. Queries are categorized into 
**easy**, **medium**, and **advanced** levels to help me progressively develop SQL proficiency.

#### Easy Queries
- Simple data retrieval, filtering, and basic aggregations.
  
#### Medium Queries
- More complex queries involving grouping, aggregation functions, and joins.
  
#### Advanced Queries
- Nested subqueries, window functions, CTEs, and performance optimization.



### 3. Query Optimization
In advanced stages, the focus shifts to improving query performance. Some optimization strategies include:
- **Indexing**: Adding indexes on frequently queried columns.
- **Query Execution Plan**: Using `EXPLAIN ANALYZE` to review and refine query performance.

---

## Practice Questions

### Easy Level
1. Retrieve the names of all tracks that have more than 1 billion streams.
2. List all albums along with their respective artists.
3. Get the total number of comments for tracks where `licensed = TRUE`.
4. Find all tracks that belong to the album type `single`.
5. Count the total number of tracks by each artist.

### Medium Level
1. Calculate the average danceability of tracks in each album.
2. Find the top 5 tracks with the highest energy values.
3. List all tracks along with their views and likes where `official_video = TRUE`.
4. For each album, calculate the total views of all associated tracks.
5. Retrieve the track names that have been streamed on Spotify more than YouTube.

### Advanced Level
1. Find the top 3 most-viewed tracks for each artist using window functions.
2. Write a query to find tracks where the liveness score is above the average.
3. Use a `WITH` clause to calculate the difference between the highest and lowest energy values for tracks in each album.
4. Find tracks where the energy-to-liveness ratio is greater than 1.2.
5. Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.

---

## Query Optimization Technique 

To improve query performance, carried out the following optimization process:

- **Initial Query Performance Analysis Using `EXPLAIN`**
    - Began by analyzing the performance of a query using the `EXPLAIN` function.
    - The query retrieved tracks based on the `album_type` column, and the performance metrics were as follows:
        - Execution time (E.T.): **7.324 ms**
        - Planning time (P.T.): **0.106 ms**
    - Below is the **screenshot** of the `EXPLAIN` result before optimization:
      
        ![EXPLAIN Before Index](https://github.com/user-attachments/assets/306a722f-ca38-4186-a2a2-45abf30cbf50)


- **Index Creation on the `album_type` Column**
    - To optimize the query performance, we created an index on the `album_type` column. This ensures faster retrieval of rows where the artist is queried.
    - **SQL command** for creating the index:
      ```sql
      CREATE INDEX album_index ON spotify_data(album_type);
      ```
      

- **Performance Analysis After Index Creation**
    - After creating the index, ran the same query again and observed significant improvements in performance:
        - Execution time (E.T.): **3.126 ms**
        - Planning time (P.T.): **0.108 ms**
    - Below is the **screenshot** of the `EXPLAIN` result after index creation:
      
       ![EXPLAIN After Index](https://github.com/user-attachments/assets/27405565-0614-428e-a757-a4ca347466af)
      


- **Graphical Performance Comparison**
    - A graph illustrating the comparison between the initial query execution time and the optimized query execution time after index creation.
    - **Graph view** shows the significant drop in both execution and planning times:
      
      ![Performance_Graph_Before](https://github.com/user-attachments/assets/ee95aded-ee86-437e-9b20-af2f4217bff4)
      
      ![Performance_Graph_After](https://github.com/user-attachments/assets/c059758d-486e-4c40-806e-0bda3d6fad48)



This optimization shows how indexing can drastically reduce query time, improving the overall performance of our database operations in the Spotify project.

---

## Technology Stack
- **Database**: PostgreSQL
- **SQL Queries**: DDL, DML, Aggregations, Joins, Subqueries, Window Functions
- **Tools**: pgAdmin 4


## Conclusion

This project demonstrates the power of data analytics in uncovering trends in music streaming platforms. The insights gained can guide artists, streaming 
services, and marketers in making informed decisions to enhance user experiences and maximize engagement. Future work could involve integrating additional 
datasets, such as user demographics or listening patterns, to create a more holistic understanding of track performance.
