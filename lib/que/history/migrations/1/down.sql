DROP TABLE que_history;
DROP TRIGGER IF EXISTS que_history_save_job ON que_jobs;
DROP FUNCTION IF EXISTS que_history_save_job();
