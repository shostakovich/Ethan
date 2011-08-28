def run_specs
  system('clear')
  system("./jasmine-node --coffee ./spec")
end

watch('^lib/(.*\.coffee)') { |m| run_specs }
watch('^(spec/(.*)\.coffee)') { |m| run_specs }

run_specs