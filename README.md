# 📦 SEND Freight — Legacy Demurrage Mini-Service

## 📌 Overview

This app was built as part of an engineering assessment to reverse-engineer a legacy MySQL schema and implement core domain logic (demurrage billing) in a modern Rails 7 codebase.

The focus is on:
- Clean, testable architecture (models, services, jobs)
- Minimal assumptions over legacy fields
- JSON-only API (no frontend)
- Modular seed and test data

---

## 💎 Ruby & Rails Versions

- Ruby: `3.3.4`
- Rails: `7.1.x`

---

## 🧰 System Dependencies

- MySQL 8 (via Docker)
- Docker & Docker Compose
- `asdf` or `rbenv` (recommended for Ruby version management)

---

## ⚙️ Setup Steps

```bash
# Clone and set up
git clone https://github.com/your-org/send-freight.git
cd send-freight

# Install Ruby and Gems
asdf install
bundle install

# Copy and edit environment
cp .env.example .env
# (Ensure DB settings match your local or Docker setup)

# Set up the databases (main + SolidQueue)
bin/rails db:reset
bin/rails db:migrate
bin/rails db:migrate:queue  # For SolidQueue (uses separate DB)

# Seed with common and dev data
bin/rails db:seed
```

> ✅ SolidQueue uses a separate database via the `queue:` block in `database.yml`.

---

## 🗃️ Seed File Structure

Modular seeding powered by a custom `Seeder` loader.

```
db/seed_files/
├── common/        # Shared across environments
├── development/   # Dev-only data
└── test/          # Fixtures for specs
```

Run specific seed files:

```bash
rails db:seed seeds=00_customers,01_bill_of_ladings
```

Defaults to loading all in `common/` and your current `Rails.env/`.

---

## ✅ How to Run Tests

```bash
bundle exec rspec
```

Includes:
- Model specs
- Service object specs (`Demurrage::InvoiceGenerator`)
- Request specs for API (`/api/v1/invoices`)
- Job spec for `Demurrage::InvoiceGenerationJob`

---

## 🔧 Background Job Processor

**SolidQueue** is used for async job processing.

- Schema is stored in `db/queue_schema.rb`
- To start workers:

```bash
bin/jobs
```

To enqueue invoice generation manually:

```ruby
Demurrage::InvoiceGenerationJob.perform_later
```

---

## 🔌 API Endpoints

All responses are JSON.

### 📄 List Overdue Invoices

`GET /api/v1/invoices/overdue`

**Optional Params:**
- `page`
- `per_page`

**Example:**

```bash
curl -X GET http://localhost:3000/api/v1/invoices/overdue
```

---

### 🧾 Create Invoice

`POST /api/v1/invoices`

**Body:**

```json
{
  "invoice": {
    "reference": "INV-12345",
    "bill_of_lading_number": "BL123",
    "client_code": "C001",
    "client_name": "Acme Ltd.",
    "amount": 160.0,
    "original_amount": 160.0,
    "devise": "USD",
    "status": "open",
    "invoice_date": "2025-07-10",
    "id_utilisateur": 1
  }
}
```

**Example:**

```bash
curl -X POST http://localhost:3000/api/v1/invoices \
  -H "Content-Type: application/json" \
  -d @invoice.json
```

---

## 🧠 Design Decisions & Assumptions

- Used existing legacy fields and schema, with light renaming (`numero_bl` → `number`).
- `Invoice` is always created once per `BillOfLading`, only if overdue **and** has no open invoice.
- `BillOfLading#container_count` sums the six `nbre_*` fields.
- Flat rate: `$80` per container per day overdue.
- Scope `overdue_as_of(date)` lets you run invoice generation for any historical date.
- API-only — no UI, PDFs, or CSVs included.
- Did not adhere to rails strong migration in a bid to keep things simple but can discuss this during our meeting. 
- Background job system (`SolidQueue`) is fully configured and isolated in its own DB.

---
