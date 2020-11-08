require 'spec_helper'

RSpec.describe NA86::Squadron do
    let (:tomcat) { Aircraft.new({:name=>"Tomcat", :designation => "F-14", :range => 100}) }
    let (:squadron_tomcat) { Squadron.new({:assigned_aircraft => [:tomcat, :tomcat, :tomcat, :tomcat], :number_of_aircraft_assigned => 4})}
end