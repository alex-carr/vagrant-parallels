module VagrantPlugins
  module Parallels
    module Action
      class RegisterTemplate
        def initialize(app, env)
          @app = app
        end

        def call(env)
          pvm_file = env[:machine].box.directory.join('vagrant_parallels.pvm').to_s
          
          unless env[:machine].provider.driver.registered?('vagrant_parallels')
            env[:machine].provider.driver.register(pvm_file)
          end
          # Call the next if we have one (but we shouldn't, since this
          # middleware is built to run with the Call-type middlewares)
          @app.call(env)
        end
      end
    end
  end
end
