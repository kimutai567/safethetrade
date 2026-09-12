# SafeTheTrade

SafeTheTrade is a PHP and MySQL website prototype for secure digital-asset trading. It includes a public marketplace, account registration, and login flow.

## Project Files

- `index.html` - Main page, marketplace, and registration form
- `login.html` - Login page interface
- `style.css` - Shared layout and visual styling
- `register.php` - Validates and saves new accounts
- `login.php` - Validates login details against the database
- `db.php` - MySQL database connection settings
- `schema.sql` - Creates the database and `users` table

## Requirements

For online hosting, use a hosting provider that supports:

- PHP
- MySQL or MariaDB
- A web server such as Apache or Nginx

XAMPP is not required for production. XAMPP is only one option for local testing.

## Local Setup With XAMPP

1. Install and start Apache and MySQL in XAMPP.
2. Copy this project folder into XAMPP's `htdocs` directory.
3. Open phpMyAdmin at `http://localhost/phpmyadmin`.
4. Import `schema.sql` into phpMyAdmin.
5. Check the database settings in `db.php`:
6. Use chrome , Edge, firefox or Brave.

   ```php
   $host = '127.0.0.1';
   $dbname = 'safethetrade';
   $username = 'root';
   $password = '';
   ```

7. Open the site through Apache:

   ```text
   http://localhost/Safe the trade prototype/index.html
   ```

Do not open the PHP files by double-clicking them. PHP must run through a web server.

## Online Hosting Setup

1. Create a MySQL database and database user in the hosting control panel.
2. Import `schema.sql` into the new database.
3. Upload all project files to the site's `public_html` folder.
4. Update `db.php` with the hosting database host, name, username, and password.
5. Open the domain and test registration and login.

## User Flow

1. A visitor opens `index.html`.
2. They select `Sign up` and submit the registration form.
3. `register.php` validates the form and stores a password hash in MySQL.
4. They select `Log in` to open `login.html`.
5. `login.php` checks the email and password, then sends a successful user to the marketplace.

## Important Notes

- Keep database credentials private.
- Use a strong database password in production.
- Use HTTPS on the live website.
- The marketplace content is currently prototype data and is not connected to live trading services.
- Before production use, add authorization checks to private pages and implement logout and session timeout.
