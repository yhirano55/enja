run "rm Gemfile"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

generate :'enja:install'

run "rm -r spec"

rake "db:migrate"
