DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'gender_t') THEN
    CREATE TYPE GENDER_T AS ENUM ('male', 'female', 'other');
  END IF;
END $$;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'post_status_t') THEN
    CREATE TYPE POST_STATUS_T AS ENUM ('draft', 'public', 'private');
  END IF;
END $$;
