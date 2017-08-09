require 'test_helper'

describe Que::History::Migrations do
  before do
    DB.drop_table? :que_jobs
    DB.drop_table? :que_history
    DB.drop_function :que_history_save_job, if_exists: true
    Que.migrate!
  end

  after do
    DB.drop_table? :que_jobs
    DB.drop_table? :que_history
    DB.drop_function :que_history_save_job, if_exists: true
    Que.migrate!
    Que::History.migrate!
  end

  it "it starts out at 0" do
    Que::History::Migrations.db_version.must_equal 0
  end

  describe 'version 1' do
    it "can migrate up" do
      Que::History.migrate! version: 1
      Que::History::Migrations.db_version.must_equal 1
    end

    it "can migrate down" do
      Que::History.migrate! version: 1
      Que::History.migrate! version: 0
      Que::History::Migrations.db_version.must_equal 0
    end
  end

  describe 'version 2' do
    it "can migrate up" do
      Que::History.migrate! version: 2
      Que::History::Migrations.db_version.must_equal 2
    end

    it "can migrate back down to 0" do
      Que::History.migrate! version: 2
      Que::History.migrate! version: 1
      Que::History::Migrations.db_version.must_equal 1
    end
  end
end
