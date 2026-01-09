-- ============================================
-- BÀI TẬP 3 – CƠ BẢN
-- TẢI, IMPORT DATABASE & TRUY VẤN + INDEX
-- Database: social_network_pro
-- ============================================

-- 1. SỬ DỤNG DATABASE
USE social_network_pro;

-- ============================================
-- 2. TRUY VẤN USER Ở HÀ NỘI (CHƯA CÓ INDEX)
-- ============================================

-- Truy vấn dữ liệu
SELECT *
FROM users
WHERE hometown = 'Hà Nội';

-- Kiểm tra hiệu năng truy vấn (chưa có index)
EXPLAIN ANALYZE
SELECT *
FROM users
WHERE hometown = 'Hà Nội';

-- ============================================
-- 3. TẠO INDEX CHO CỘT hometown
-- ============================================

CREATE INDEX idx_hometown
ON users(hometown);

-- ============================================
-- 4. TRUY VẤN LẠI SAU KHI CÓ INDEX
-- ============================================

-- Truy vấn dữ liệu
SELECT *
FROM users
WHERE hometown = 'Hà Nội';

-- Kiểm tra hiệu năng truy vấn (đã có index)
EXPLAIN ANALYZE
SELECT *
FROM users
WHERE hometown = 'Hà Nội';

-- ============================================
-- 5. XÓA INDEX idx_hometown
-- ============================================

DROP INDEX idx_hometown ON users;

-- ============================================
-- KẾT THÚC FILE
-- ============================================
