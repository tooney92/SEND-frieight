# 📦 SEND Freight — Legacy Demurrage Mini-Service

## 📌 Important Notes

- This app was built as part of an assessment involving legacy schema reverse-engineering.
- For migration decisions, I’m aware of [Strong Migrations](https://github.com/ankane/strong_migrations) best practices. In some cases, I skipped strict compliance to keep things simple and focused on clarity and functionality.

## 💎 Ruby Version

- Ruby `3.3.4`
- Rails `7.1+`

## 🧰 System Dependencies

- MySQL (via Docker)
- Docker + Docker Compose
- `asdf` or `rbenv` recommended for Ruby version management

## ⚙️ Configuration

```bash
cp .env.example .env
```

Edit your `.env` file with DB credentials and other required settings.

## 🗃️ Database Creation

```bash
rails db:create
```

## 🛠️ Database Initialization

```bash
rails db:migrate
```

## 🧪 Seeding the Database

This project uses a **custom seed loader** (`db/seeder.rb`) to allow modular, environment-specific seeding.

### 📁 Seed File Structure

Seed files live under:

```
db/seed_files/
├── common/
│   ├── 00_customers.rb
│   ├── 01_bill_of_ladings.rb
│   └── 02_invoices.rb
├── development/
│   └── test_data.rb
└── test/
    └── test_data.rb
```

### 🚀 Running Seeds

You can selectively run seed files using the `seeds` environment variable:

```bash
rails db:seed seeds=00_customers
```

You can also pass multiple seeders (comma-separated):

```bash
rails db:seed seeds=00,01
```

If no `seeds=` is passed, it will load:

- All files in `db/seed_files/common/`
- All files in `db/seed_files/#{Rails.env}/`

This structure allows selective, repeatable seeding and separation of common vs. environment-specific data.

## 🧪 How to Run the Test Suite

```bash
bundle exec rspec
```

## 🛠️ Services

- Background Jobs: SolidQueue
- Database: MySQL 8 (via Docker)

## 🚀 Deployment Instructions

TBD – currently intended for local development and assessment use.
