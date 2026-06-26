-- Add start_date and due_date to tasks table
alter table tasks add column if not exists start_date date;
alter table tasks add column if not exists due_date date;
