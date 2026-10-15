<?php
$host = getenv('DB_HOST');
$host = $host !== false && $host !== '' ? $host : '127.0.0.1';
$port = getenv('DB_PORT');
$dbname = getenv('DB_NAME');
$dbname = $dbname !== false && $dbname !== '' ? $dbname : 'safethetrade';
$username = getenv('DB_USER');
$username = $username !== false && $username !== '' ? $username : 'root';
$password = getenv('DB_PASSWORD');
$password = $password !== false ? $password : '';

$dsn = "mysql:host=$host;dbname=$dbname;charset=utf8mb4";
if ($port !== false && $port !== '') {
    $dsn .= ";port=$port";
}
$options = [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES => false,
];

try {
    $pdo = new PDO($dsn, $username, $password, $options);
} catch (PDOException $exception) {
    error_log('Database connection failed: ' . $exception->getMessage());
    http_response_code(500);
    exit('Database connection failed. Check the database settings and server logs.');
}
