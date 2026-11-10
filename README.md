<div align="center">

# 🗄️ Zero-Downtime Database Migration Toolkit

[![Flyway](https://img.shields.io/badge/Flyway-v10-CC0000?style=for-the-badge&logo=flyway&logoColor=white)](https://flywaydb.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-v16-336791?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Database DevOps](https://img.shields.io/badge/Architecture-Expand_Contract_Pattern-success?style=for-the-badge&logo=database&logoColor=white)](https://martinfowler.com/bliki/ParallelChange.html)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](./LICENSE)

<p align="center">
  <b>Production Database DevOps pipeline enforcing Martin Fowler's Expand-Contract (Parallel Run) migration pattern to eliminate locks, table outages, and downtime during relational schema updates.</b>
</p>

</div>

---

## 🔄 Expand-Contract (Parallel Change) Pattern

```
Phase 1: BASELINE          Phase 2: EXPAND (Dual-Write)       Phase 3: CONTRACT
┌──────────────┐          ┌───────────────────────────┐      ┌───────────────────────────┐
│ accounts     │          │ accounts                  │      │ accounts                  │
│  - id        │  ───>    │  - id                     │ ───> │  - id                     │
│  - username  │          │  - username               │      │  - username               │
│  - email     │          │  - email (Legacy)         │      │  - email_hash (New)       │
└──────────────┘          │  - email_hash (New col)   │      └───────────────────────────┘
                          │  - Trigger syncs changes  │      Old column dropped safely
                          └───────────────────────────┘      Zero downtime achieved
```

---

## 📁 Repository Layout

```
zero-downtime-database-migration-toolkit/
├── .github/workflows/
│   └── db-ci.yml                           # Syntax and migration validation
├── sql/migrations/
│   ├── V1__init_schema.sql                 # Baseline schema creation
│   └── V2__add_email_hash_nonblocking.sql  # Non-blocking alter table + trigger
├── scripts/
│   ├── migrate.sh                          # Flyway pipeline runner
│   └── validate_backward_compatibility.py  # Zero-downtime regression tester
└── README.md
```

---

## 👤 Author

**Vishwjeet Kumar Mehta**  
Senior DevOps & DevSecOps Consultant | Cloud & Infrastructure Architect  
- **LinkedIn**: [linkedin.com/in/vishwjeet-mehta](https://www.linkedin.com/in/vishwjeet-mehta/)  
- **GitHub**: [@vishwjeetmehta-bot](https://github.com/vishwjeetmehta-bot)

