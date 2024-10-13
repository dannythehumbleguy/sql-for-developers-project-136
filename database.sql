CREATE TABLE courses
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
    course_url VARCHAR(256) NOT NULL,
    user_id BIGINT REFERENCES courses (id) NOT NULL,
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