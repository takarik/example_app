-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
ALTER TABLE posts ADD COLUMN user_id INTEGER;

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
ALTER TABLE posts DROP COLUMN user_id;
