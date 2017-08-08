CREATE TABLE que_history
(
  priority    smallint    NOT NULL DEFAULT 100,
  run_at      timestamptz NOT NULL DEFAULT now(),
  job_id      bigint      NOT NULL,
  job_class   text        NOT NULL,
  args        json        NOT NULL DEFAULT '[]'::json,
  error_count int         NOT NULL DEFAULT 0,
  last_error  text,
  queue       text,
  data        jsonb       NOT NULL DEFAULT '{}'::jsonb,

  CONSTRAINT que_history_pkey PRIMARY KEY (job_id)
);

CREATE FUNCTION que_history_save_job()
RETURNS trigger
LANGUAGE plpgsql
AS $$
  BEGIN
    INSERT INTO que_history SELECT (OLD).*;
    RETURN OLD;
  END;
$$;

CREATE TRIGGER que_history_save_job BEFORE DELETE ON que_jobs FOR EACH ROW EXECUTE PROCEDURE que_history_save_job();