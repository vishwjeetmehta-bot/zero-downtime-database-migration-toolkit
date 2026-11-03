-- Phase 2: Expand phase (Add new column as nullable, avoid table lock)
ALTER TABLE accounts ADD COLUMN IF NOT EXISTS email_hash VARCHAR(64);

-- Asynchronous non-blocking index creation in PostgreSQL
-- Concurrently prevents table read/write starvation
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_accounts_email_hash ON accounts(email_hash);

-- Trigger for dual-writing during application transition
CREATE OR REPLACE FUNCTION sync_email_hash()
RETURNS TRIGGER AS $$
BEGIN
    NEW.email_hash := encode(digest(NEW.email, 'sha256'), 'hex');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_sync_email_hash ON accounts;
CREATE TRIGGER trg_sync_email_hash
BEFORE INSERT OR UPDATE OF email ON accounts
FOR EACH ROW EXECUTE FUNCTION sync_email_hash();
