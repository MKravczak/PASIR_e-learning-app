-- Utworzenie schematów
CREATE SCHEMA IF NOT EXISTS users;
CREATE SCHEMA IF NOT EXISTS flashcards;
CREATE SCHEMA IF NOT EXISTS quizzes;
CREATE SCHEMA IF NOT EXISTS groups;

-- Utworzenie tabel w schemacie users
CREATE TABLE IF NOT EXISTS users.users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS users.roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS users.user_roles (
    user_id INTEGER REFERENCES users.users(id),
    role_id INTEGER REFERENCES users.roles(id),
    PRIMARY KEY (user_id, role_id)
);

-- Utworzenie tabel w schemacie flashcards
CREATE TABLE IF NOT EXISTS flashcards.flashcard_sets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    owner_id INTEGER REFERENCES users.users(id),
    is_public BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS flashcards.flashcards (
    id SERIAL PRIMARY KEY,
    set_id INTEGER REFERENCES flashcards.flashcard_sets(id),
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Utworzenie tabel w schemacie quizzes
CREATE TABLE IF NOT EXISTS quizzes.quiz_sets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    owner_id INTEGER REFERENCES users.users(id),
    is_public BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS quizzes.questions (
    id SERIAL PRIMARY KEY,
    quiz_id INTEGER REFERENCES quizzes.quiz_sets(id),
    question TEXT NOT NULL,
    question_type VARCHAR(50) NOT NULL, -- multiple_choice, open, drag_drop, etc.
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS quizzes.answers (
    id SERIAL PRIMARY KEY,
    question_id INTEGER REFERENCES quizzes.questions(id),
    content TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT false,
    points INTEGER DEFAULT 1
);

CREATE TABLE IF NOT EXISTS quizzes.results (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users.users(id),
    quiz_id INTEGER REFERENCES quizzes.quiz_sets(id),
    score INTEGER NOT NULL,
    max_score INTEGER NOT NULL,
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Utworzenie tabel w schemacie groups
CREATE TABLE IF NOT EXISTS groups.groups (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    owner_id INTEGER REFERENCES users.users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS groups.group_members (
    group_id INTEGER REFERENCES groups.groups(id),
    user_id INTEGER REFERENCES users.users(id),
    role VARCHAR(50) DEFAULT 'MEMBER',
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (group_id, user_id)
);

CREATE TABLE IF NOT EXISTS groups.group_content (
    id SERIAL PRIMARY KEY,
    group_id INTEGER REFERENCES groups.groups(id),
    content_type VARCHAR(50) NOT NULL, -- flashcard_set, quiz, etc.
    content_id INTEGER NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Dodanie podstawowych ról
INSERT INTO users.roles (name) VALUES ('ROLE_USER'), ('ROLE_ADMIN') ON CONFLICT DO NOTHING; 