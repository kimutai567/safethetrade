# SafeTheTrade

SafeTheTrade is a PHP and MySQL website prototype for secure digital-asset trading. It includes a public marketplace, account registration, and login flow.
All payments platform in the world and all the cryptocurrencies are available.
#Connect with traders worldwide.

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
5. The local defaults in `db.php` connect to `127.0.0.1`, database `safethetrade`, user `root`, and an empty password. Override them with environment variables if your local setup uses different values:

   ```text
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_NAME=safethetrade
   DB_USER=root
   DB_PASSWORD=
   ```

6. Open the site through Apache:

   ```text
   http://localhost/Safe the trade prototype/index.html
   ```

Do not open the PHP files by double-clicking them. PHP must run through a web server.

## Online Hosting Setup

1. Create a MySQL database and database user in the hosting control panel.
2. Import `schema.sql` into the new database.
3. Upload all project files to the site's `public_html` folder.
4. Configure the `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, and `DB_PASSWORD` environment variables in the hosting control panel. The local defaults are only for development; do not commit production credentials.
5. Open the domain and test registration and login.

## User Flow

1. A visitor opens `index.html`.
2. They select `Sign up` and submit the registration form.
3. `register.php` validates the form and stores a password hash in MySQL.
4. They select `Log in` to open `login.html`.
5. `login.php` checks the email and password, then sends a successful user to the marketplace.

## Important Notes

- Keep database credentials private and secure.
- Use a strong database password in production.
- Use HTTPS on the live website.
- The marketplace content is currently prototype data and is not connected to live trading services.
- Before production use, add authorization checks to private pages and implement logout and session timeout.
-Intergartion of payment plaform across the world with documentation on how to use it.
