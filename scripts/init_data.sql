-- Insert into address
INSERT INTO public.address (street, zip, state, country) VALUES
('123 Main St', 12345, 'CA', 'USA'),
('456 Oak St', 67890, 'NY', 'USA'),
('789 Pine St', 54321, 'TX', 'USA'),
('321 Elm St', 98765, 'FL', 'USA'),
('654 Maple St', 13579, 'WA', 'USA'),
('987 Cedar St', 24680, 'OR', 'USA'),
('741 Birch St', 11223, 'NV', 'USA'),
('852 Willow St', 33445, 'AZ', 'USA'),
('963 Spruce St', 55667, 'CO', 'USA'),
('159 Redwood St', 77889, 'IL', 'USA');

-- Insert into contact_info
INSERT INTO public.contact_info (phone, email, address_id) VALUES
('123-456-7890', 'person1@example.com', 1),
('234-567-8901', 'person2@example.com', 2),
('345-678-9012', 'person3@example.com', 3),
('456-789-0123', 'person4@example.com', 4),
('567-890-1234', 'person5@example.com', 5),
('678-901-2345', 'person6@example.com', 6),
('789-012-3456', 'person7@example.com', 7),
('890-123-4567', 'person8@example.com', 8),
('901-234-5678', 'person9@example.com', 9),
('012-345-6789', 'person10@example.com', 10);

-- Insert into person
INSERT INTO public.person (contact_info_id, first_name, last_name, birth_date, private, gender) VALUES
(1, 'John', 'Doe', '1990-01-01', false, 'male'),
(2, 'Jane', 'Smith', '1985-02-02', false, 'female'),
(3, 'Jim', 'Beam', '1992-03-03', true, 'male'),
(4, 'Alice', 'Johnson', '1988-04-04', false, 'female'),
(5, 'Bob', 'Brown', '1995-05-05', true, 'male'),
(6, 'Charlie', 'White', '1993-06-06', false, 'other'),
(7, 'Diana', 'Miller', '1987-07-07', false, 'female'),
(8, 'Ethan', 'Wilson', '1991-08-08', true, 'male'),
(9, 'Fiona', 'Taylor', '1994-09-09', false, 'female'),
(10, 'George', 'Anderson', '1989-10-10', true, 'male');

-- Insert into event
INSERT INTO public.event (coordinator_id, title, description, images_s3_url, event_location, camping_location, start_date, end_date, contact_info_id, price, post_status) VALUES
(1, 'Marathon 2025', 'Annual city marathon', 's3://images/marathon.jpg', 'NYC', NULL, '2025-06-01', '2025-06-02', 1, 50, 'public'),
(2, 'Triathlon Challenge', 'Swim, bike, run event', 's3://images/triathlon.jpg', 'San Diego', 'Beach Camp', '2025-07-10', '2025-07-11', 2, 100, 'public'),
(3, 'Cycling Tour', 'Road cycling event', 's3://images/cycling.jpg', 'Austin', NULL, '2025-08-15', '2025-08-16', 3, 30, 'public'),
(4, 'Hiking Adventure', 'Mountain hiking', 's3://images/hiking.jpg', 'Rocky Mountains', 'Campground', '2025-09-01', '2025-09-03', 4, 20, 'draft'),
(5, 'Obstacle Race', 'Extreme obstacle challenge', 's3://images/obstacle.jpg', 'Las Vegas', NULL, '2025-10-05', '2025-10-06', 5, 40, 'public');

-- Insert into race
INSERT INTO public.race (event_id, title, description, start_date, end_date, time, price, class, format, livestream_url, results_url) VALUES
(1, '5K Sprint', 'Short distance run', '2025-06-01', '2025-06-01', '08:00 AM', 20, 'Amateur', 'Time Trial', NULL, NULL),
(1, '10K Challenge', 'Mid-distance run', '2025-06-01', '2025-06-01', '10:00 AM', 30, 'Amateur', 'Mass Start', NULL, NULL),
(2, 'Full Triathlon', 'Long distance triathlon', '2025-07-10', '2025-07-10', '06:00 AM', 150, 'Professional', 'Endurance', NULL, NULL),
(3, 'Tour de City', 'Cycling event', '2025-08-15', '2025-08-15', '07:00 AM', 25, 'Open', 'Criterium', NULL, NULL);

-- Insert into person_event
INSERT INTO public.person_event (person_id, event_id) VALUES
(1, 1), (2, 1), (3, 1), (4, 2), (5, 2), (6, 3), (7, 3), (8, 4), (9, 4), (10, 5);

-- Insert into person_race
INSERT INTO public.person_race (person_id, race_id) VALUES
(1, 1), (2, 1), (3, 2), (4, 2), (5, 3), (6, 3), (7, 4), (8, 4), (9, 1), (10, 2);
