/* =========================================================
   FULL DATABASE – SOCIAL NETWORK (THEO ERD)
   ========================================================= */

CREATE DATABASE IF NOT EXISTS social_network_pro
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE social_network_pro;

SET FOREIGN_KEY_CHECKS = 0;

/* ======================
   1. USERS
   ====================== */
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  full_name VARCHAR(100) NOT NULL,
  gender ENUM('Nam','Nữ') DEFAULT 'Nam',
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(100) NOT NULL,
  birthdate DATE,
  hometown VARCHAR(100),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

/* ======================
   2. POSTS
   ====================== */
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  post_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  content TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

/* ======================
   3. COMMENTS
   ====================== */
DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
  comment_id INT AUTO_INCREMENT PRIMARY KEY,
  post_id INT NOT NULL,
  user_id INT NOT NULL,
  content TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

/* ======================
   4. LIKES
   ====================== */
DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  post_id INT NOT NULL,
  user_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (post_id, user_id),
  FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

/* ======================
   5. FRIENDS
   ====================== */
DROP TABLE IF EXISTS friends;
CREATE TABLE friends (
  user_id INT NOT NULL,
  friend_id INT NOT NULL,
  status ENUM('pending','accepted','blocked') DEFAULT 'pending',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, friend_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (friend_id) REFERENCES users(user_id)
);

/* ======================
   6. MESSAGES
   ====================== */
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
  message_id INT AUTO_INCREMENT PRIMARY KEY,
  sender_id INT NOT NULL,
  receiver_id INT NOT NULL,
  content TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (sender_id) REFERENCES users(user_id),
  FOREIGN KEY (receiver_id) REFERENCES users(user_id)
);

/* ======================
   7. NOTIFICATIONS
   ====================== */
DROP TABLE IF EXISTS notifications;
CREATE TABLE notifications (
  notification_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  type VARCHAR(50),
  content VARCHAR(255),
  is_read BOOLEAN DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

SET FOREIGN_KEY_CHECKS = 1;

/* =========================================================
   VIEW 1: Người dùng họ “Nguyễn”
   ========================================================= */
DROP VIEW IF EXISTS view_users_firstname;
CREATE VIEW view_users_firstname AS
SELECT user_id, username, full_name, email, created_at
FROM users
WHERE full_name LIKE 'Nguyễn%';

SELECT * FROM view_users_firstname;

/* =========================================================
   VIEW 2: Tổng số bài viết của mỗi user
   ========================================================= */
DROP VIEW IF EXISTS view_user_post;
CREATE VIEW view_user_post AS
SELECT
  u.user_id,
  COUNT(p.post_id) AS total_user_post
FROM users u
LEFT JOIN posts p ON u.user_id = p.user_id
GROUP BY u.user_id;

SELECT * FROM view_user_post;

/* =========================================================
   JOIN VIEW + USERS
   ========================================================= */
SELECT
  u.full_name,
  v.total_user_post
FROM users u
JOIN view_user_post v ON u.user_id = v.user_id
ORDER BY v.total_user_post DESC;

/* =========================================================
   TRUY VẤN MẪU THƯỜNG GẶP
   ========================================================= */

-- 1. Danh sách bài viết + tên người đăng
SELECT p.post_id, u.full_name, p.content, p.created_at
FROM posts p
JOIN users u ON p.user_id = u.user_id;

-- 2. Số lượt like mỗi bài viết
SELECT p.post_id, COUNT(l.user_id) AS total_likes
FROM posts p
LEFT JOIN likes l ON p.post_id = l.post_id
GROUP BY p.post_id;

-- 3. Danh sách bạn bè đã chấp nhận
SELECT u1.full_name AS user_name, u2.full_name AS friend_name
FROM friends f
JOIN users u1 ON f.user_id = u1.user_id
JOIN users u2 ON f.friend_id = u2.user_id
WHERE f.status = 'accepted';

-- 4. Người chưa từng đăng bài
SELECT u.full_name
FROM users u
LEFT JOIN posts p ON u.user_id = p.user_id
WHERE p.post_id IS NULL;
