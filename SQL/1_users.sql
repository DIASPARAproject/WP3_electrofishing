-- Should be created only once
-- each role groups will appear and all databases
-- note the roless might already have been created on the server.... so check ...




createDB -U postgres migdb


--- extension management
CREATE EXTENSION "uuid-ossp" SCHEMA "public";
CREATE EXTENSION postgis SCHEMA "public";
-- here we create an admin password, you probably want to use one local admin there to change this
-- everywhere
CREATE USER diaspara_admin ;
CREATE USER diaspara_read;

GRANT CONNECT ON DATABASE "diaspara" TO diaspara_read;
ALTER DATABASE "diaspara" OWNER TO diaspara_admin;
ALTER ROLE diaspara_read  WITH LOGIN;




GRANT ALL PRIVILEGES ON SCHEMA public TO diaspara_admin ;


-- Should be done each time the database is created
--- role management
GRANT CONNECT ON DATABASE damdb TO diaspara_read;
ALTER DATABASE damdb OWNER TO diaspara_admin;

-- grant roles for diaspara_read
GRANT USAGE 
    ON SCHEMA dam
    TO diaspara_read;

GRANT EXECUTE 
    ON ALL FUNCTIONS
    IN SCHEMA dam
    TO diaspara_read;

GRANT SELECT
    ON ALL TABLES
    IN SCHEMA dam
    TO diaspara_read;
    

GRANT USAGE 
    ON SCHEMA nomenclature
    TO diaspara_read;

GRANT EXECUTE 
    ON ALL FUNCTIONS
    IN SCHEMA nomenclature
    TO diaspara_read;

GRANT SELECT
    ON ALL TABLES
    IN SCHEMA nomenclature
    TO diaspara_read;

   
GRANT USAGE 
    ON SCHEMA dam_france
    TO diaspara_read;

GRANT EXECUTE 
    ON ALL FUNCTIONS
    IN SCHEMA dam_france
    TO diaspara_read;

GRANT SELECT
    ON ALL TABLES
    IN SCHEMA dam_france
    TO diaspara_read;

