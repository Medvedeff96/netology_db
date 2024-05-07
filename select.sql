# Название и продолжительность самого длительного трека
SELECT name,continuity 
FROM tracks 
WHERE continuity  = (SELECT MAX(continuity) FROM tracks);


# Название треков, продолжительность которых не менее 3,5 минут
SELECT name
FROM tracks 
WHERE continuity>TIME '00:03:30';


# Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT name
FROM collections
WHERE year>=2018 and year<=2020;


# Исполнители, чьё имя состоит из одного слова
SELECT name 
FROM artists
WHERE name NOT LIKE '% %';


# Название треков, которые содержат слово «мой» или «my»
SELECT name 
FROM tracks
WHERE name LIKE '%My%'
   or name LIKE '%мой%';


# Количество исполнителей в каждом жанре


SELECT genres.name, COUNT(*) FROM genres
JOIN artistsgenres ON artistsgenres.genreid = genres.id
JOIN artists ON artistsgenres.artistid = artists.id
GROUP BY genres.name


# Количество треков, вошедших в альбомы 2019–2020 годов
SELECT COUNT(*) FROM tracks
JOIN albums ON albums.id = tracks.albumid
WHERE albums.year BETWEEN 2019 AND 2020;


# Средняя продолжительность треков по каждому альбому
SELECT albums.name, AVG(tracks.continuity) FROM tracks
JOIN albums ON albums.id = tracks.albumid
GROUP BY albums.id
ORDER BY AVG(tracks.continuity);


# Все исполнители, которые не выпустили альбомы в 2020 году
SELECT artists.name FROM artists
LEFT join (SELECT DISTINCT artists.id, artists.name 
FROM artists
JOIN artistalbums ON artistalbums.artistid = artists.id
JOIN albums ON albums.id = artistalbums.albumid
WHERE albums.year = 2020) AS artists2020 ON artists.id = artists2020.id
WHERE artists2020.id IS NULL;


# Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами)
SELECT DISTINCT collections.name FROM collections
JOIN collectiontracks ON collectiontracks.collectionid = collections.id
JOIN tracks ON tracks.id = collectiontracks.trackid
JOIN albums ON tracks.albumid = albums.id
JOIN artistalbums ON albums.id = artistalbums.albumid
JOIN artists ON artists.id = artistalbums.artistid
WHERE artists.id = (SELECT id FROM artists WHERE name = 'Баста');