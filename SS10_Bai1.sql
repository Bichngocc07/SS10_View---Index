/* 1. Tạo CSDL */
CREATE DATABASE IF NOT EXISTS view_practice;
USE view_practice;

/* 2. Xóa bảng nếu đã tồn tại */
DROP TABLE IF EXISTS users;

/* 3. Tạo bảng users */
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50),
    full_name VARCHAR(100),
    gender ENUM('Male','Female'),
    email VARCHAR(100),
    password VARCHAR(100),
    birthday DATE,
    hometown VARCHAR(100),
    created_at DATETIME
);

/* 4. Thêm dữ liệu mẫu */
INSERT INTO users 
(username, full_name, gender, email, password, birthday, hometown, created_at)
VALUES
('user1', 'Nguyễn Văn An', 'Male', 'an@gmail.com', '123', '2000-01-01', 'Hà Nội', NOW()),
('user2', 'Trần Thị Bình', 'Female', 'binh@gmail.com', '123', '1999-05-10', 'Hải Phòng', NOW()),
('user3', 'Nguyễn Thị Hoa', 'Female', 'hoa@gmail.com', '123', '2001-08-15', 'Đà Nẵng', NOW()),
('user4', 'Lê Văn Cường', 'Male', 'cuong@gmail.com', '123', '1998-12-20', 'TP.HCM', NOW());

/* ================================
   5. Tạo VIEW hiển thị người họ Nguyễn
   ================================ */
CREATE VIEW view_users_firstname AS
SELECT
    user_id,
    username,
    full_name,
    email,
    created_at
FROM users
WHERE full_name LIKE 'Nguyễn%';

/* 6. Truy vấn VIEW */
SELECT * FROM view_users_firstname;

/* ================================
   7. Thêm người dùng mới họ Nguyễn
   ================================ */
INSERT INTO users
(username, full_name, gender, email, password, birthday, hometown, created_at)
VALUES
('nguyenvana', 'Nguyễn Văn A', 'Male', 'nguyenvana@gmail.com', '123456', '2000-02-02', 'Hà Nội', NOW());

/* 8. Kiểm tra VIEW sau khi thêm */
SELECT * FROM view_users_firstname;

/* ================================
   9. Xóa người dùng vừa thêm
   ================================ */
DELETE FROM users
WHERE username = 'nguyenvana';

/* 10. Kiểm tra VIEW sau khi xóa */
SELECT * FROM view_users_firstname;