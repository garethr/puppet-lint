require 'puppet-lint'
require 'rake'
require 'rake/tasklib'

class PuppetLint
  class RakeTask < ::Rake::TaskLib
    def initialize(*args)
      desc 'Run puppet-lint'

      task :lint do
        RakeFileUtils.send(:verbose, true) do
          linter =  PuppetLint.new
          Dir.glob('**/*.pp').each do |puppet_file|
            puts "Evaluating #{puppet_file}"
            linter.file = puppet_file
            linter.disable_summary
            linter.run
          end

          if PuppetLint.configuration.summary
            linter.summarize
          end

          fail if linter.errors?
        end
      end
    end
  end
end

PuppetLint::RakeTask.new
