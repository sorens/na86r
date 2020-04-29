require "logger"

REMOVE_ALL_LINEFEEDS ||= true
DEFAULT_LOG_LOCATION ||= "~/Library/Logs"

class SimpleLogger < Logger
  def format_message(severity, timestamp, progname, msg)
    begin
      if REMOVE_ALL_LINEFEEDS
        "#{timestamp.to_formatted_s(:db)} rails[#{$PID}]  #{severity}: #{msg2str(msg).gsub(/\n/, '').lstrip}\n"
      else
        "#{timestamp.to_formatted_s(:db)} rails[#{$PID}]  #{severity}: #{msg2str(msg).lstrip}\n"
      end
    rescue
      "#{timestamp.to_formatted_s(:db)} rails[#{$PID}]  #{severity}: #{msg}\n" 
    end
  end
  
  private

  def hostname
    @parsed_hostname ||= Socket.gethostname.split('.').first
  end

  def msg2str(msg)
    case msg
    when ::String
      msg
    when ::Exception
      if REMOVE_ALL_LINEFEEDS
        "#{ msg.message } (#{ msg.class }): " << (msg.backtrace || []).join(" | ")
      else
        "#{ msg.message } (#{ msg.class }): " << (msg.backtrace || []).join( "\n" )
      end
    else
      msg.inspect
    end
  end
  
  def self.load
    require File.expand_path( __FILE__ )
    # use our simple logger class so we can see a date time stamp for each entry
    log_dir = File.join( File.expand_path( DEFAULT_LOG_LOCATION ), Rails.application.class.parent_name )
    FileUtils.mkdir_p( log_dir )
    path = File.join( log_dir, "#{Rails.env}.log" )
    logfile = File.open( path, 'a' )
    logfile.sync = true
    Rails.logger = SimpleLogger.new( logfile )
    Rails.logger.info "configured to use simple_logger"
  end

end