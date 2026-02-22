-- PostgreSQL Schema for Khedmni

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    phone_number VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'customer', -- 'customer', 'craftsman', 'admin'
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE craftsmen_profiles (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    full_name VARCHAR(255) NOT NULL,
    job_category VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    area VARCHAR(100),
    phone_number VARCHAR(50) NOT NULL,
    whatsapp VARCHAR(50),
    description TEXT,
    profile_image TEXT,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE verification_requests (
    id SERIAL PRIMARY KEY,
    craftsman_id INTEGER REFERENCES craftsmen_profiles(id) ON DELETE CASCADE,
    real_full_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(50) NOT NULL,
    city VARCHAR(100) NOT NULL,
    id_image TEXT,
    workshop_image TEXT,
    status VARCHAR(50) DEFAULT 'pending', -- 'pending', 'approved', 'rejected'
    rejection_reason TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE admin_logs (
    id SERIAL PRIMARY KEY,
    admin_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    action VARCHAR(100) NOT NULL,
    target_id INTEGER,
    details TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE settings (
    key VARCHAR(100) PRIMARY KEY,
    value TEXT NOT NULL
);

INSERT INTO settings (key, value) VALUES ('hide_unverified', 'true'), ('registration_enabled', 'true') ON CONFLICT DO NOTHING;

CREATE TABLE reports (
    id SERIAL PRIMARY KEY,
    craftsman_id INTEGER REFERENCES craftsmen_profiles(id) ON DELETE CASCADE,
    reporter_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
    reason TEXT NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- First Admin Creation Command
-- INSERT INTO users (phone_number, password_hash, role) VALUES ('0900000000', 'YOUR_BCRYPT_HASH_HERE', 'admin');
