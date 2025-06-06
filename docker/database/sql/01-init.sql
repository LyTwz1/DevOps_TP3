CREATE TABLE IF NOT EXISTS public.student (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE
);

-- Insérer quelques données d'exemple
INSERT INTO public.student (name, email) 
VALUES ('John Doe', 'john.doe@example.com'), 
       ('Jane Smith', 'jane.smith@example.com')
ON CONFLICT DO NOTHING;
