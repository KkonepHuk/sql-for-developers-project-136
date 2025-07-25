CREATE TABLE courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    content VARCHAR(255),
    create_at DATE,
    update_at DATE
);

CREATE TABLE lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    content VARCHAR(255),
    body VARCHAR(255),
    video_link VARCHAR(255),
    position INTEGER,
    create_at DATE,
    update_at DATE,
    course_link VARCHAR(255),
    course_id BIGINT REFERENCES courses (id) ON DELETE SET NULL
);

CREATE TABLE modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    content VARCHAR(255),
    create_at DATE,
    update_at DATE,
    course_id BIGINT REFERENCES courses (id) ON DELETE SET NULL
);

CREATE TABLE programs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    price VARCHAR(255),
    type VARCHAR(255),
    create_at DATE,
    update_at DATE,
    module_id BIGINT REFERENCES modules (id) ON DELETE SET NULL
);