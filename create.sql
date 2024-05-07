CREATE TABLE IF NOT EXISTS Artists (
	Id SERIAL PRIMARY KEY,
	Name VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Genres (
	Id SERIAL PRIMARY KEY,	
	Name VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS ArtistsGenres (
	ArtistId INTEGER REFERENCES Artists(Id),
	GenreId INTEGER REFERENCES Genres(Id),
	constraint pk_ArtistsGenres PRIMARY KEY (ArtistId, GenreId)
);

CREATE TABLE IF NOT EXISTS Albums (	
	Id SERIAL PRIMARY KEY,
	Name VARCHAR(80) NOT NULL UNIQUE,
	Year INTEGER CHECK (Year > 1950 and Year < 2050)
);

CREATE TABLE IF NOT EXISTS Artistalbums	 (
	ArtistId INTEGER REFERENCES Artists(Id),
	AlbumId INTEGER REFERENCES Albums(Id),
	constraint pk_Artistalbums PRIMARY KEY (ArtistId, AlbumId)
);

CREATE TABLE IF NOT EXISTS Tracks (
	Id SERIAL PRIMARY KEY,
	AlbumId INTEGER REFERENCES Albums(Id),
	Name VARCHAR(80) NOT NULL,
	Continuity TIME,
	constraint pk_Tracks UNIQUE (Name, AlbumId)
);

CREATE TABLE IF NOT EXISTS Collections (	
	Id SERIAL PRIMARY KEY,
	Name VARCHAR(80) NOT NULL,
	Year INTEGER CHECK (Year > 1950 and Year < 2050)
);

CREATE TABLE IF NOT EXISTS CollectionTracks (
	CollectionId INTEGER REFERENCES Collections(Id),
	TrackId INTEGER REFERENCES Tracks(Id),
	constraint pk_CollectionTracks PRIMARY KEY (CollectionId, TrackId)
);