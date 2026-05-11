BEGIN;

TRUNCATE TABLE dtc_pattern_links RESTART IDENTITY CASCADE;
TRUNCATE TABLE dtc_patterns RESTART IDENTITY CASCADE;
TRUNCATE TABLE dtc_codes_meaning RESTART IDENTITY CASCADE;

\copy dtc_codes_meaning(id, dtc_code, dtc_description) FROM '/tmp/dtc_codes_meaning.csv' WITH (FORMAT csv, HEADER true);
\copy dtc_patterns(id, name, primary_cause, source_url) FROM '/tmp/dtc_patterns.csv' WITH (FORMAT csv, HEADER true);
\copy dtc_pattern_links(id, pattern_id, dtc_code) FROM '/tmp/dtc_pattern_links.csv' WITH (FORMAT csv, HEADER true);

SELECT setval(pg_get_serial_sequence('dtc_codes_meaning', 'id'), COALESCE((SELECT MAX(id) FROM dtc_codes_meaning), 1), true);
SELECT setval(pg_get_serial_sequence('dtc_patterns', 'id'), COALESCE((SELECT MAX(id) FROM dtc_patterns), 1), true);
SELECT setval(pg_get_serial_sequence('dtc_pattern_links', 'id'), COALESCE((SELECT MAX(id) FROM dtc_pattern_links), 1), true);

COMMIT;

SELECT 'dtc_codes_meaning' AS table_name, COUNT(*) FROM dtc_codes_meaning
UNION ALL
SELECT 'dtc_patterns', COUNT(*) FROM dtc_patterns
UNION ALL
SELECT 'dtc_pattern_links', COUNT(*) FROM dtc_pattern_links;
