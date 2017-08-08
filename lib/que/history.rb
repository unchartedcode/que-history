module Que
  module History
    autoload :Migrations, 'que/history/migrations'
    autoload :Version, 'que/history/version'

    class << self
      def migrate!(version = {:version => Migrations::CURRENT_VERSION})
        Migrations.migrate!(version)
      end
    end
  end
end
