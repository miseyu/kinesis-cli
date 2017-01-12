Bundler.setup(:default)
Bundler.require
require 'active_support/core_ext'
require_rel 'tools'

module Tools
  def self.logger
    @@logging ||= begin
      log = Logging.logger['tools_logger']
      log.add_appenders Logging.appenders.stdout,
        Logging.appenders.file('log/tools.log')
      log.level = :debug
      log
    end
  end
end
