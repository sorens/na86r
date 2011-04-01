require 'string'

module NavalGameOne
  class ActionReport
    attr_accessor :target_key, :action_key, :source_key, :target_origin_key,
    :source_origin_key, :actor_key, :actor_origin_key, :method_key,
    :method_type_key

    def to_s
      #"CVN NIMITZ HAS BEEN SUNK BY AS-6 MISSILES LAUNCHED FROM RAID #123."
      "#{target}#{action}#{method_type}#{method}FROM#{source}."
    end

    private
    def target
      case @target_key
      when "cvn68"
        "cvn-nimitz ".upcase
      else
        ""
      end
    end

    def action
      case @action_key
      when "sunk"
        "has been sunk by ".upcase
      else
        ""
      end
    end

    def method_type
      case @method_type_key
      when "as6"
        "as-6 ".upcase
      else
        ""
      end
    end

    def method
      case @method_key
      when "missile"
        "missiles launched ".upcase
      when "torpedo"
        "torpedos launched ".upcase
      else
        ""
      end
    end

    def source
      unless @source_key.nil?
        if @source_key.starts_with?( "raid" )
          " " + @source_key.gsub( /_/, " #" ).upcase
        else
          case @source_key
          when "ssn126"
            " ssn-swiftsure".upcase
          else
            ""
          end
        end
      end
    end

  end
end
