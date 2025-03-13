--Baza de date relationala

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE playlists (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    mood VARCHAR(50), 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE songs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    playlist_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    youtube_link VARCHAR(255),
    spotify_link VARCHAR(255),
    FOREIGN KEY (playlist_id) REFERENCES playlists(id) ON DELETE CASCADE
);

CREATE TABLE reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    playlist_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5), 
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (playlist_id) REFERENCES playlists(id) ON DELETE CASCADE
);

CREATE TABLE favorites (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    playlist_id INT NULL, 
    song_id INT NULL, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (playlist_id) REFERENCES playlists(id) ON DELETE CASCADE,
    FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE
);


SELECT * FROM users;

SELECT * FROM playlists WHERE user_id = 1;

SELECT * FROM songs WHERE playlist_id = 2;

SELECT users.username, reviews.rating, reviews.comment
FROM reviews
JOIN users ON reviews.user_id = users.id;

SELECT songs.title, songs.artist 
FROM favorites 
JOIN songs ON favorites.song_id = songs.id 
WHERE favorites.user_id = 3;