-- Migration 001: Create deployments table
CREATE TABLE deployments (
    id SERIAL PRIMARY KEY,
    status VARCHAR(50) NOT NULL,
    error_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
); 