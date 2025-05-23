  -- 問1
  -- 国名を全て抽出してください。

  SELECT name
  FROM countries;

  -- 問2
  -- ヨーロッパに属する国をすべて抽出してください。

  SELECT code, name, continent, region, surface_area
  FROM countries
  WHERE continent = 'Europe';

  -- 問3
  -- ヨーロッパ以外に属する国をすべて抽出してください。

  SELECT code, name, continent, region, surface_area
  FROM countries
  WHERE continent != 'Europe';

  -- 問4
  -- 人口が10万人以上の国をすべて抽出してください。

  SELECT code, name, continent, region, surface_area, indep_year, population
  FROM countries
  WHERE population >= 100000;

  -- 問5
  -- 平均寿命が56歳から76歳の国をすべて抽出してください。

  SELECT code, name, continent, region, surface_area
  FROM countries
  WHERE life_expectancy BETWEEN 56 AND 76;

  -- 問6
  -- 国コードがNLB,ALB,DZAのもの市区町村をすべて抽出してください。

  SELECT cities.id, cities.name, countries.code, cities.district, countries.population
  FROM cities
    LEFT OUTER JOIN countries
      ON cities._code = countries.code
  WHERE cities.country_code = 'NLB'
    OR  cities.country_code = 'ALB'
    OR  cities.country_code = 'DZA';

  -- 問7
  -- 独立独立記念日がない国をすべて抽出してください。

  SELECT code, name, continent, region, surface_area, indep_year
  FROM countries
  WHERE indep_year IS NULL;

  -- 問8
  -- 独立独立記念日がある国をすべて抽出してください。

  SELECT code, name, continent, region, surface_area, indep_year
  FROM countries
  WHERE indep_year IS NOT NULL;

  -- 問9
  -- 名前の末尾が「ia」で終わる国を抽出してください。

  SELECT code, name, continent, region, surface_area
  FROM countries
  WHERE name LIKE '%ia';

  -- 問10
  -- 名前の中に「st」が含まれる国を抽出してください。
  -- ILIKEはpostgreSQL限定で大文字小文字区別なしで比較可能

  SELECT code, name, continent, region, surface_area
  FROM countries
  WHERE name ILIKE '%st%';

  -- 問11
  -- 名前が「an」で始まる国を抽出してください。

  SELECT code, name, continent, region, surface_area, indep_year
  FROM countries
  WHERE name ILIKE 'an%';

  -- 問12
  -- 全国の中から独立記念日が1990年より前または人口が10万人より多い国を全て抽出してください。
  SELECT code, name, continent, region, surface_area, indep_year,population
  FROM countries
  WHERE indep_year < 1990
    OR population > 100000;

  -- 問13
  -- コードがDZAもしくはALBかつ独立記念日が1990年より前の国を全て抽出してください。

  SELECT code, name, continent, region, surface_area, indep_year,population
  FROM countries
  WHERE code IN ('DZA', 'ALB')
    AND indep_year < 1990;

  -- 問14
  -- 全ての地方をグループ化せずに表示してください。

  SELECT DISTINCT region
  FROM countries
  ORDER BY region;


  -- 問15
  -- 国名と人口を以下のように表示させてください。シングルクォートに注意してください。
  -- 「Arubaの人口は103000人です」

  SELECT name || 'の人口は' || population || '人です。'
  FROM countries ;


  -- 問16
  -- 平均寿命が短い順に国名を表示させてください。ただしNULLは表示させないでください。
  SELECT name, life_expectancy
  FROM countries
  WHERE life_expectancy IS  NOT NULL
  ORDER BY life_expectancy ;


  -- 問17
  -- 平均寿命が長い順に国名を表示させてください。ただしNULLは表示させないでください。
  SELECT name, life_expectancy
  FROM countries
  WHERE life_expectancy IS  NOT NULL
  ORDER BY life_expectancy desc;

  -- 問18
  -- 平均寿命が長い順、独立記念日が新しい順に国を表示させてください。

  SELECT name, life_expectancy, indep_year
  FROM countries
  WHERE life_expectancy IS NOT NULL
    OR indep_year IS NOT NULL
  ORDER BY life_expectancy desc, indep_year desc;

  -- 問19
  -- 全ての国の国コードの一文字目と国名を表示させてください。

  SELECT left(code, 1) AS first_char, name
  FROM countries ;


  -- 問20
  -- 国名が長いものから順に国名と国名の長さを出力してください。

  SELECT name, LENGTH(name) AS name_length
  FROM countries
  ORDER BY name_length desc;

  -- 問21
  -- 全ての地方の平均寿命、平均人口を表示してください。(NULLも表示)

  SELECT region, AVG(life_expectancy) AS "平均寿命", AVG(population) AS "平均人口"
  FROM countries
  GROUP BY region
  ORDER BY region ;

  -- 問22
  -- 全ての地方の最長寿命、最大人口を表示してください。(NULLも表示)

  SELECT region, MAX(life_expectancy) AS "最長寿命", MAX(population) AS "最大人口"
  FROM countries
  GROUP BY region
  ORDER BY region ;

-- 問23
-- アジア大陸の中で最小の表面積を表示してください

  SELECT MIN(surface_area) AS "アジアの最小表面積"
  FROM countries
  WHERE continent = 'Asia'
  GROUP BY continent ;

-- 問24
-- アジア大陸の表面積の合計を表示してください。


  SELECT SUM(surface_area) AS "アジアの最小表面積"
  FROM countries
  WHERE continent = 'Asia'
  GROUP BY continent ;

-- 問25
-- 全ての国と言語を表示してください。一つの国に複数言語があると思いますので同じ国名を言語数だけ出力してください。

SELECT c.name, cl.language
FROM countries AS c
  JOIN country_languages AS cl
  ON c.code = cl.country_code ;

-- 問26
-- 全ての国と言語と市区町村を表示してください。

SELECT countries.name, cities.name AS "市区町村名", country_languages.language
FROM countries
  JOIN cities
  ON countries.code = cities.country_code
  JOIN country_languages
  ON countries.code = country_languages.country_code ;

-- 問27
-- 全ての有名人を出力してください。左側外部結合を使用して国名なし（country_codeがNULL）も表示してください。

SELECT celebrities.name AS celebritiesName, countries.name AS countryName
FROM celebrities
  LEFT OUTER JOIN countries
  ON celebrities.country_code = countries.code ;

-- 問28
-- 全ての有名人の名前,国名、第一言語を出力してください。

SELECT cel.name AS celebrity, c.name AS country, lang.language, lang.percentage
FROM countries AS c
  JOIN celebrities AS cel ON c.code = cel.country_code
  JOIN country_languages AS lang ON c.code = lang.country_code
  JOIN (
    SELECT country_code, MAX(percentage) AS max_percentage
    FROM country_languages
    GROUP BY country_code
  ) AS max_lang
  ON lang.country_code = max_lang.country_code
     AND lang.percentage = max_lang.max_percentage;


-- 問29
-- 全ての有名人の名前と国名をに出力してください。 ただしテーブル結合せずサブクエリを使用してください。

SELECT celebrities.name,
  (
    SELECT countries.name
    FROM countries
    WHERE celebrities.country_code = countries.code
  )
FROM celebrities;

-- 問30
-- 最年長が50歳以上かつ最年少が30歳以下の国を表示させてください。
WITH ages AS (
  SELECT country_code, max(celeb.age) AS max_age, min(celeb.age) AS min_age
  FROM celebrities AS celeb
  WHERE country_code != ''
  GROUP BY country_code
)

SELECT ages.country_code, ages.max_age, ages.min_age
FROM ages
WHERE max_age >= 50
  AND min_age <= 30;

-- 問31
-- 1991年生まれと、1981年生まれの有名人が何人いるか調べてください。ただし、日付関数は使用せず、UNION句を使用してください。

SELECT TO_CHAR(birth, 'YYYY') AS birth_year , COUNT(*)
FROM celebrities
WHERE TO_CHAR(birth, 'YYYY') = '1991'
GROUP BY birth_year
UNION
SELECT TO_CHAR(birth, 'YYYY') AS birth_year , COUNT(*)
FROM celebrities
WHERE TO_CHAR(birth, 'YYYY') = '1981'
GROUP BY birth_year;


-- 問32
-- 有名人の出身国の平均年齢を高い方から順に表示してください。ただし、FROM句はcountriesテーブルとしてください。

SELECT c.name AS 国名, AVG(age) AS 平均年齢
FROM countries AS c
  JOIN celebrities AS celeb
  ON c.code = celeb.country_code
GROUP BY c.name
ORDER BY 平均年齢 desc
