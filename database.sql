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

CREATE TABLE teaching_group (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug VARCHAR(255),
    create_at DATE,
    update_at DATE
);

CREATE TYPE user_role AS ENUM ('student', 'teacher', 'admin');
CREATE TABLE users (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    username VARCHAR(255),
    email VARCHAR(255),
    password_hash VARCHAR(255),
    teaching_group_link VARCHAR(255),
    role user_role,
    teaching_group_id BIGINT REFERENCES teaching_group (id) ON DELETE SET NULL,
    create_at DATE,
    update_at DATE
);

CREATE TYPE subscription_st AS ENUM ('active', 'pending', 'cancelled', 'completed');
CREATE TABLE enrollments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users (id) ON DELETE SET NULL,
    program_id BIGINT REFERENCES programs (id) ON DELETE SET NULL,
    subscription_status subscription_st,
    create_at DATE,
    update_at DATE
);

CREATE TYPE payment_st AS ENUM ('pending', 'paid', 'failed', 'refunded');
CREATE TABLE payments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    subscription_id BIGINT REFERENCES enrollments (id) ON DELETE SET NULL,
    payment_amount INTEGER,
    payment_status payment_st,
    payment_date DATE,
    create_at DATE,
    update_at DATE
);


CREATE TYPE program_completion_st AS ENUM ('active', 'pending', 'cancelled', 'completed');
CREATE TABLE program_completions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users (id) ON DELETE SET NULL,
    program_id BIGINT REFERENCES programs (id) ON DELETE SET NULL,
    program_completion_status program_completion_st,
    program_start DATE,
    program_end DATE,
    create_at DATE,
    update_at DATE
);

CREATE TABLE certificates (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users (id) ON DELETE SET NULL,
    program_id BIGINT REFERENCES programs (id) ON DELETE SET NULL,
    certificate_url VARCHAR(255),
    release_date DATE,
    create_at DATE,
    update_at DATE
);

CREATE TABLE quizzes (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES lessons (id) ON DELETE SET NULL,
    quizz_name VARCHAR(255),
    content JSON,
    create_at DATE,
    update_at DATE
);

CREATE TABLE exercises (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES lessons (id) ON DELETE SET NULL,
    exercise_name VARCHAR(255),
    exercise_url VARCHAR(255),
    create_at DATE,
    update_at DATE
);

CREATE TABLE discussions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES lessons (id) ON DELETE SET NULL,
    content JSON,
    create_at DATE,
    update_at DATE
);

CREATE TYPE blog_st AS ENUM ('created', 'in moderation', 'published', 'archived');
CREATE TABLE blog (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    student_id BIGINT REFERENCES users (id) ON DELETE SET NULL,
    blog_name VARCHAR(255),
    content TEXT,
    blog_status blog_st,
    create_at DATE,
    update_at DATE
);