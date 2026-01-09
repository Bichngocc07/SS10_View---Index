USE social_network_pro;

-- 1.1 Truy vấn: lấy các bài viết năm 2026 của user_id = 1
SELECT post_id, content, created_at
FROM posts
WHERE user_id = 1
  AND YEAR(created_at) = 2026;

-- 1.2 Kiểm tra kế hoạch thực thi (CHƯA có index)
EXPLAIN ANALYZE
SELECT post_id, content, created_at
FROM posts
WHERE user_id = 1
  AND YEAR(created_at) = 2026;

-- 1.3 Tạo composite index
CREATE INDEX idx_created_at_user_id
ON posts (created_at, user_id);

-- 1.4 Kiểm tra lại kế hoạch thực thi (ĐÃ có index)
EXPLAIN ANALYZE
SELECT post_id, content, created_at
FROM posts
WHERE user_id = 1
  AND created_at >= '2026-01-01'
  AND created_at < '2027-01-01';

-- =====================================================
-- PHẦN 2: UNIQUE INDEX (CHỈ MỤC DUY NHẤT)
-- =====================================================

-- 2.1 Truy vấn tìm user theo email
SELECT user_id, username, email
FROM users
WHERE email = 'an@gmail.com';

-- 2.2 Kiểm tra kế hoạch thực thi (CHƯA có index)
EXPLAIN ANALYZE
SELECT user_id, username, email
FROM users
WHERE email = 'an@gmail.com';

-- 2.3 Tạo unique index
CREATE UNIQUE INDEX idx_email
ON users(email);

-- 2.4 Kiểm tra lại kế hoạch thực thi (ĐÃ có index)
EXPLAIN ANALYZE
SELECT user_id, username, email
FROM users
WHERE email = 'an@gmail.com';

-- =====================================================
-- PHẦN 3: XÓA CHỈ MỤC
-- =====================================================

-- 3.1 Xóa composite index
DROP INDEX idx_created_at_user_id ON posts;

-- 3.2 Xóa unique index
DROP INDEX idx_email ON users;

-- =====================================================
-- KẾT THÚC BÀI TẬP 4
-- =====================================================
