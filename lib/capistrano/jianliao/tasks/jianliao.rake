require 'json'
require 'net/http'

namespace :jianliao do
  namespace :deploy do
    task :updated do
      if fetch(:jianliao_url)
        run_locally do
          elapsed = 1
          announcement = "#{announced_application_name} successfully deployed."

          post_jianliao_message(announcement)
        end
      end
    end

    def short_revision
      deployed_revision = fetch(:deployed_revision)
      deployed_revision[0..7] if deployed_revision
    end

    def announced_application_name
      jianliao_application = fetch(:jianliao_application)
      "".tap do |output|
        output << jianliao_application if jianliao_application
        output << " (#{short_revision})" if short_revision
      end
    end

    def post_jianliao_message(message)
      uri = URI(fetch(:jianliao_url))

      payload = {
        "authorName" => fetch(:jianliao_authorname),
        "text" => message
      }

      res = Net::HTTP.post_form(uri, payload)
    end
  end
end

after  'deploy:finishing',  'jianliao:deploy:updated'

namespace :load do
  task :defaults do
    set :jianliao_url,            -> { ENV['JIANLIAO_URL'] } # Incoming WebHook URL.
    set :jianliao_application,    -> { ENV['JIANLIAO_APPLICATION'] || 'application' }
    set :jianliao_authorname,     -> { ENV['JIANLIAO_AUTHORNAME'] || 'deploybot' }

    set :deployer,          -> { ENV['GIT_AUTHOR_NAME'] || %x[git config user.name].chomp }
    set :deployed_revision, -> { ENV['GIT_COMMIT'] || %x[git rev-parse #{fetch :branch}].strip }
  end
end
