require "logger"

REMOVE_ALL_LINEFEEDS = true

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
  

end