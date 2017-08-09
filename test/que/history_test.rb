require "test_helper"

describe Que::History, '.run' do
  before do
    DB[:que_jobs].delete
    DB[:que_history].delete
  end

  it "has a version" do
    ::Que::History::VERSION.wont_be_nil
  end

  it "it should process the job and store history" do
    # Starting out
    DB[:que_jobs].count.must_equal 0
    DB[:que_history].count.must_equal 0

    # Enqueue and Run
    result = TestJob.enqueue
    DB[:que_jobs].count.must_equal 1
    result = Que::Job.work
    result[:event].must_equal :job_worked, result[:error]

    # Where we are after
    DB[:que_jobs].count.must_equal 0
    DB[:que_history].count.must_equal 1
  end
end
