-- Planning applications tracker
create table if not exists planning_applications (
  id               uuid primary key default gen_random_uuid(),
  project_id       uuid not null references projects(id) on delete cascade,
  application_type text not null,
  reference_number text,
  submission_date  date,
  status           text not null default 'Preparing',
  notes            text,
  created_at       timestamptz default now()
);

create index if not exists planning_applications_project_id_idx
  on planning_applications(project_id);
