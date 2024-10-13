﻿CREATE TABLE courses
(
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(256) NOT NULL,
    description VARCHAR(2048) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE lessons
(
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(256) NOT NULL,
    payload VARCHAR(8192) NOT NULL,
    video_url VARCHAR(256) NOT NULL,
    position INT NOT NULL,
    course_id BIGINT REFERENCES courses (id) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE quizzes
(
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(256) NOT NULL,
    text VARCHAR(2048) NOT NULL,
    lesson_id BIGINT REFERENCES lessons (id) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE exercises
(
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(256) NOT NULL,
    lesson_id BIGINT REFERENCES lessons (id) NOT NULL,
    url VARCHAR(256) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE modules
(
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(256) NOT NULL,
    description VARCHAR(2048) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE module_courses
(
    course_id BIGINT REFERENCES courses (id) NOT NULL,
    module_id BIGINT REFERENCES modules (id) NOT NULL,
    PRIMARY KEY (module_id, course_id)
);

CREATE TABLE programs
(
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(256) NOT NULL,
    price DECIMAL(12, 2) NOT NULL,
    type VARCHAR(16) NOT NULL ,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE program_modules
(
    program_id BIGINT REFERENCES programs (id) NOT NULL,
    module_id BIGINT REFERENCES modules (id) NOT NULL,
    PRIMARY KEY (program_id, module_id)
);

CREATE TABLE teaching_groups
(
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slack_url VARCHAR(256) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE users
(
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    email VARCHAR(128) UNIQUE NOT NULL,
    password VARCHAR(512) NOT NULL,
    name VARCHAR(64) NOT NULL,
    role VARCHAR(32) NOT NULL,
    teaching_group_id BIGINT REFERENCES teaching_groups (id) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NULL
);

CREATE TYPE enrollment_status AS ENUM ('active', 'pending', 'cancelled', 'completed');
CREATE TABLE enrollments
(
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    program_id BIGINT REFERENCES programs (id) NOT NULL,
    user_id BIGINT REFERENCES users (id) NOT NULL,
    status enrollment_status NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NULL
);

CREATE TYPE payment_status AS ENUM ('pending', 'paid', 'failed', 'refunded');
CREATE TABLE payments
(
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enrollment_id BIGINT REFERENCES enrollments (id) NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    status payment_status NOT NULL,
    payed_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NULL
);

CREATE TYPE program_completion_status AS ENUM ('active', 'completed', 'pending', 'cancelled');
CREATE TABLE program_completions
(
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    program_id BIGINT REFERENCES programs (id) NOT NULL,
    user_id BIGINT REFERENCES users (id) NOT NULL,
    status program_completion_status NOT NULL,
    started_at TIMESTAMP NULL,
    ended_at TIMESTAMP NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE certificates
(
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    program_id BIGINT REFERENCES programs (id) NOT NULL,
    user_id BIGINT REFERENCES users (id) NOT NULL,
    url VARCHAR(256) NOT NULL,
    graduated_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NULL
);

CREATE TABLE discussions
(
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    text VARCHAR(2048) NOT NULL,
    lesson_id BIGINT REFERENCES lessons (id) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NULL
);

CREATE TYPE article_status AS ENUM ('created', 'in moderation', 'published', 'archived');
CREATE TABLE blogs
(
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users (id) NOT NULL,
    title VARCHAR(256) NOT NULL,
    text VARCHAR(8192) NOT NULL,
    status article_status NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NULL
);