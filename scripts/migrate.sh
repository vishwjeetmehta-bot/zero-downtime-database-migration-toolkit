#!/usr/bin/env bash
# ==============================================================================
# Zero-Downtime Flyway Migration Orchestrator
# Author: Vishwjeet Kumar Mehta
# ==============================================================================
set -eo pipefail

FLYWAY_URL="${DB_JDBC_URL:-jdbc:postgresql://localhost:5432/production_db}"
FLYWAY_USER="${DB_USER:-postgres}"
FLYWAY_PASSWORD="${DB_PASSWORD:-postgres}"

echo "==> Running Flyway baseline check and validation..."
flyway -url="$FLYWAY_URL" -user="$FLYWAY_USER" -password="$FLYWAY_PASSWORD" -locations=filesystem:sql/migrations validate

echo "==> Executing Flyway migration in transaction..."
flyway -url="$FLYWAY_URL" -user="$FLYWAY_USER" -password="$FLYWAY_PASSWORD" -locations=filesystem:sql/migrations migrate

echo "==> Validating post-migration health..."
python3 scripts/validate_backward_compatibility.py
