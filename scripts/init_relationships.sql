ALTER TABLE public.person
ADD CONSTRAINT fk_contact_info_id FOREIGN KEY (contact_info_id)
REFERENCES public.contact_info (contact_info_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE public.contact_info
ADD CONSTRAINT fk_address_id FOREIGN KEY (address_id)
REFERENCES public.address (address_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE public.person_event
ADD CONSTRAINT fk_person_id FOREIGN KEY (person_id)
REFERENCES public.person (person_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE public.person_event
ADD CONSTRAINT fk_event_id FOREIGN KEY (event_id)
REFERENCES public.event (event_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE public.event
ADD CONSTRAINT fk_coordinator_id FOREIGN KEY (coordinator_id)
REFERENCES public.person (person_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE public.event
ADD CONSTRAINT fk_contact_info_id FOREIGN KEY (contact_info_id)
REFERENCES public.contact_info (contact_info_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE public.race
ADD CONSTRAINT fk_event_id FOREIGN KEY (event_id)
REFERENCES public.event (event_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE public.person_race
ADD CONSTRAINT fk_person_id FOREIGN KEY (person_id)
REFERENCES public.person (person_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE public.person_race
ADD CONSTRAINT fk_race_id FOREIGN KEY (race_id)
REFERENCES public.race (race_id)
ON UPDATE CASCADE
ON DELETE CASCADE;
