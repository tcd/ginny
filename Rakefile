require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task(default: :test)

require "json"
require "yaml"

# Convert a YAML file to JSON and write it out to a new file.
#
# @param path [String]
# @return [String]
def yaml2json(path, pretty: true)
  path = File.expand_path(path)
  ext = case File.extname(path).downcase
        when ".yml"  then ".yml"
        when ".yaml" then ".yaml"
        else ""
        end
  base_name = File.basename(path, ext)
  dir = File.dirname(path)
  out_file = File.join(dir, "#{base_name}.json")
  input = YAML.load_file(path)
  output = pretty ? JSON.pretty_generate(input) : input.to_json
  File.open(out_file, "a") { |f| f.write(output) }
  return out_file
end

task :yaml2json, [:path] do |_, arg|
  yaml2json(arg[:path])
end

task :schema do |t|
  [
    "schema/class.schema.yml",
    "schema/attr.schema.yml",
    "schema/func.schema.yml",
    "schema/param.schema.yml",
  ].each { |f| yaml2json(f) }
end
