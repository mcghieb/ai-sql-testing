CREATE TABLE IF NOT EXISTS public.person (
  person_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  contact_info_id INT,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  birth_date DATE NOT NULL,
  private BOOLEAN DEFAULT false,
  gender GENDER_T NOT NULL
);

CREATE TABLE IF NOT EXISTS public.contact_info (
  contact_info_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  phone TEXT NOT NULL UNIQUE,
  email TEXT NOT NULL UNIQUE,
  address_id INT
);

CREATE TABLE IF NOT EXISTS public.address (
  address_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  street TEXT,
  zip INT,
  state TEXT,
  country TEXT
);

CREATE TABLE IF NOT EXISTS public.event (
  event_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  coordinator_id INT,
  title VARCHAR(30) NOT NULL,
  description TEXT NOT NULL,
  images_s3_url TEXT NOT NULL,
  event_location TEXT NOT NULL,
  camping_location TEXT,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  contact_info_id INT NOT NULL,
  price SMALLINT NOT NULL,
  post_status POST_STATUS_T NOT NULL,
  CHECK (start_date <= end_date)
);

CREATE TABLE IF NOT EXISTS public.race (
  race_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  event_id INT,
  title VARCHAR(30) NOT NULL,
  description TEXT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  time TEXT NOT NULL,
  price INT,
  class TEXT NOT NULL,
  format TEXT,
  livestream_url TEXT,
  results_url text,
  CHECK (start_date <= end_date)
);

CREATE TABLE IF NOT EXISTS public.person_event (
  person_id INT NOT NULL,
  event_id INT NOT NULL,
  PRIMARY KEY (person_id, event_id)
);

CREATE TABLE IF NOT EXISTS public.person_race (
  person_id INT NOT NULL,
  race_id INT NOT NULL,
  PRIMARY KEY (person_id, race_id)
);

CREATE INDEX IF NOT EXISTS idx_p_contact_info_id ON public.person (contact_info_id);
CREATE INDEX IF NOT EXISTS idx_pe_person_id ON public.person_event (person_id);
CREATE INDEX IF NOT EXISTS idx_pe_event_id ON public.person_event (event_id);
CREATE INDEX IF NOT EXISTS idx_e_coordinator_id ON public.event (coordinator_id);
CREATE INDEX IF NOT EXISTS idx_e_contact_info_id ON public.event (contact_info_id);
CREATE INDEX IF NOT EXISTS idx_r_event_id ON public.race (event_id);
CREATE INDEX IF NOT EXISTS idx_pr_person_id ON public.person_race (person_id);
CREATE INDEX IF NOT EXISTS idx_pr_race_id ON public.person_race (race_id);
