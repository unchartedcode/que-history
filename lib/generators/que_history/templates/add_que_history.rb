# frozen_string_literal: true

class AddQueHistory < ActiveRecord::Migration[4.2]
  def self.up
    # The current version as of this migration's creation.
    Que::History.migrate! :version => 1
  end

  def self.down
    # Completely removes Que's job queue.
    Que::History.migrate! :version => 0
  end
end
