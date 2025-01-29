DO $$ 
DECLARE 
    r RECORD;
BEGIN
    -- Drop all foreign key constraints
    FOR r IN (SELECT conname, conrelid::regclass AS tablename FROM pg_constraint WHERE contype = 'f' AND connamespace = 'public'::regnamespace) LOOP
        EXECUTE 'ALTER TABLE ' || r.tablename || ' DROP CONSTRAINT ' || quote_ident(r.conname);
    END LOOP;

    -- Drop all tables
    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') LOOP
        EXECUTE 'DROP TABLE IF EXISTS public.' || quote_ident(r.tablename) || ' CASCADE';
    END LOOP;
END $$;
