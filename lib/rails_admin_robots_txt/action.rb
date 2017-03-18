require "rails_admin/config/actions/base"
module RailsAdmin
  module Config
    module Actions
      class RobotsTxt < Base
        RailsAdmin::Config::Actions.register(self)

        # Is the action acting on the root level (Example: /admin/contact)
        register_instance_option :root? do
          false
        end

        register_instance_option :collection? do
          true
        end

        # Is the action on an object scope (Example: /admin/team/1/edit)
        register_instance_option :member? do
          false
        end

        register_instance_option :route_fragment do
          'robots_txt'
        end

        register_instance_option :controller do
          Proc.new do |klass|
            if request.get?
              @text = File.read(Rails.root.join("public", "robots.txt"))
              render action: @action.template_name

            elsif request.post?
              begin
                File.write(Rails.root.join("public", "robots.txt"), params[:robots_txt][:content].strip)
                flash[:success] = "Все сохранилось"

              rescue Exception => e
                flash[:error] = "Чтото не так"
              end

              redirect_to robots_txt_path(model_name: @abstract_model)
            end

          end
        end

        register_instance_option :link_icon do
          'fa fa-file-text-o'
        end

        register_instance_option :http_methods do
          [:get, :post]
        end
      end
    end
  end
end
