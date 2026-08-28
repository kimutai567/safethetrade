<?php
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    header('Allow: POST');
    exit('Method not allowed.');
}

$email = strtolower(trim((string) ($_POST['email'] ?? '')));
$password = (string) ($_POST['password'] ?? '');
$confirmPassword = (string) ($_POST['confirm_password'] ?? '');
$termsAccepted = isset($_POST['terms']) && $_POST['terms'] === '1';

$errorMessage = null;
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $errorMessage = 'Please enter a valid email address.';
} elseif (strlen($password) < 8) {
    $errorMessage = 'Password must be at least 8 characters.';
} elseif ($password !== $confirmPassword) {
    $errorMessage = 'Passwords do not match.';
} elseif (!$termsAccepted) {
    $errorMessage = 'You must accept the Terms of Service.';
}

if ($errorMessage !== null) {
    http_response_code(422);
    exit(htmlspecialchars($errorMessage, ENT_QUOTES, 'UTF-8'));
}

require __DIR__ . '/db.php';

try {
    $statement = $pdo->prepare(
        'INSERT INTO users (email, password_hash, referral_code) VALUES (:email, :password_hash, :referral_code)'
    );
    $statement->execute([
        'email' => $email,
        'password_hash' => password_hash($password, PASSWORD_DEFAULT),
        'referral_code' => 'fa2be851',
    ]);
} catch (PDOException $exception) {
    if (($exception->errorInfo[1] ?? null) === 1062) {
        http_response_code(409);
        exit('An account with that email already exists.');
    }
    http_response_code(500);
    exit('Unable to create the account. Please try again.');
}
?>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration complete | SafeTheTrade</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <main class="result-page">
    <div class="result-card">
      <span class="result-icon">✓</span>
    <p class="eyebrow">Registration complete</p>
    <h1>Welcome to<br><em>SafeTheTrade.</em></h1>
    <p>Your account was created successfully. Proceed to login to continue.</p>
    <a class="submit-button result-link" href="login.php" onclick="window.location.href = 'login.php'; return false;">Proceed to login <span class="button-arrow">↗</span></a>
    </div>
  </main>
</body>
</html>
