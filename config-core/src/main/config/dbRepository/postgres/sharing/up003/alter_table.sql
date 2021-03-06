ALTER TABLE sb_filesharing_ticket RENAME COLUMN fileId TO shared_object;
ALTER TABLE sb_filesharing_ticket ADD COLUMN shared_object_type VARCHAR(255);
UPDATE sb_filesharing_ticket SET shared_object_type = 'Attachment' WHERE versioning = '0';
UPDATE sb_filesharing_ticket SET shared_object_type = 'Versionned' WHERE versioning = '1';
UPDATE sb_filesharing_ticket SET nbaccess = 0 WHERE nbaccess IS NULL;
ALTER TABLE sb_filesharing_ticket ALTER COLUMN shared_object_type SET NOT NULL;
ALTER TABLE sb_filesharing_ticket ALTER COLUMN shared_object TYPE BIGINT;
ALTER TABLE sb_filesharing_ticket ALTER COLUMN keyfile TYPE VARCHAR(255);
ALTER TABLE sb_filesharing_ticket ALTER COLUMN creationDate TYPE BIGINT USING to_number(creationDate, '0000000000000000');
ALTER TABLE sb_filesharing_ticket ALTER COLUMN updateDate TYPE BIGINT USING to_number(updateDate, '0000000000000000');
ALTER TABLE sb_filesharing_ticket ALTER COLUMN endDate TYPE BIGINT USING to_number(endDate, '0000000000000000');
ALTER TABLE sb_filesharing_ticket ALTER COLUMN keyfile TYPE VARCHAR(255);
ALTER TABLE sb_filesharing_ticket DROP COLUMN versioning;
ALTER TABLE sb_filesharing_history ALTER COLUMN id TYPE BIGINT;
ALTER TABLE sb_filesharing_history ALTER COLUMN downloadDate TYPE BIGINT USING to_number(downloadDate, '0000000000000000');
ALTER TABLE sb_filesharing_history ALTER COLUMN keyfile TYPE VARCHAR(255);