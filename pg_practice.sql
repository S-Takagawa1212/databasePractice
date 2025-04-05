-- 問題1. postgresqlでpracticeデータベースを生成するSQL文を記述してください。
CREATE DATABASE practice;

-- 問題2. postgresqlでpracticeデータベースのusersテーブルを生成するSQL文を記述してください。
CREATE TYPE gender AS ENUM('Man','Woman','Other');

CREATE TABLE user (
  id int SERIAL NOT NULL,
  name CHAR(255) NOT NULL DEFAULT '',
  age int NOT NULL DEFAULT 0,
  gender gender DEFAULT 'Other',
  PRIMARY KEY (id),
);

COMMENT ON COLUMN user.name IS '氏名';
COMMENT ON COLUMN user.age IS '年齢';
COMMENT ON COLUMN user.gender IS '性別';

-- 問題3. postgresqlでpracticeデータベースのjobsテーブルを生成するSQL文を記述してください。
