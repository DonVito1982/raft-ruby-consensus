desc "Perform test"
task :test do
  load_files "test/*.rb"
end

def load_files(dir)
  Dir[dir].each { |file| load file }
end
