require "ruby-prof"
require "earhart"

result = RubyProf.profile do
  Earhart::Routes.new([Earhart::Route.new(Earhart::Pattern.new(verb: "GET", resource: "/persons/1"), Object)]).find("verb=\"GET\" resource=\"/persons/1\"")
end

if ENV["PROFILE_NOTE"]
  RubyProf::GraphPrinter.new(result).print(STDOUT, {})
else
  RubyProf::MultiPrinter.new(result).print(path: File.join("tmp"), profile: File.basename(__FILE__))
end
