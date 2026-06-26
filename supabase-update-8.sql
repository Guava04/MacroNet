-- Deliverables per stage
create table stage_deliverables (
  id uuid primary key default gen_random_uuid(),
  stage_id uuid references stages(id) on delete cascade not null,
  title text not null,
  completed boolean default false not null,
  position int default 0 not null,
  created_at timestamptz default now() not null
);

-- Named deliverable templates (e.g. "Private Residential")
create table deliverable_templates (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  riba_stage text not null,
  created_at timestamptz default now() not null
);

-- Items within a template
create table deliverable_template_items (
  id uuid primary key default gen_random_uuid(),
  template_id uuid references deliverable_templates(id) on delete cascade not null,
  title text not null,
  position int default 0 not null,
  created_at timestamptz default now() not null
);

-- Seed: Private Residential — Stage 1 template
do $$
declare
  t_id uuid;
begin
  insert into deliverable_templates (name, riba_stage)
  values ('Private Residential', 'Stage 1 — Preparation & Brief')
  returning id into t_id;

  insert into deliverable_template_items (template_id, title, position)
  values
    (t_id, 'Site appraisal', 0),
    (t_id, 'Site report', 1),
    (t_id, 'Programme costs', 2),
    (t_id, 'Project brief', 3),
    (t_id, 'Procurement / consultant engagements', 4),
    (t_id, 'Sustainability', 5),
    (t_id, 'Bid document', 6);
end $$;
