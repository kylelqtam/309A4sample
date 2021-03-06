-- INSERT INTO Login(uID, passHash) VALUES 
-- ($1, $2);


-- Trigger to insert same uID into Login as the one auto generated with the serial type in Users


-- Define trigger procedure that logs all actions on: INSERT
CREATE OR REPLACE FUNCTION insert_user() 
RETURNS TRIGGER AS $insert_user_trigger$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO Login 
        VALUES (new.uid, $3);  -- new.uid is the autogenerated value.
        RETURN NEW;  -- allows insert of new row in original table Users.
    END IF;
    RETURN NULL; -- result is ignored since this is an AFTER trigger
END;
$insert_user_trigger$ LANGUAGE plpgsql;


-- Register our trigger procedure on Users table.
-- Note: have to register trigger separately for insert/delete [not shown].
DROP TRIGGER IF EXISTS insert_user_trigger ON Users;
CREATE TRIGGER insert_user_trigger
-- ***Audits are done 'AFTER' (unlike checks which are done 'BEFORE').
AFTER INSERT ON Users
FOR EACH ROW
EXECUTE PROCEDURE insert_user();

INSERT INTO Users VALUES 
(DEFAULT, $2, $1, null, null, null);
















