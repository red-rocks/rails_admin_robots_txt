require "rails_admin/config/actions/base"
module RailsAdmin
  module Config
    module Actions
      class RobotsTxt < Base
        RailsAdmin::Config::Actions.register(self)

        # Is the action acting on the root level (Example: /admin/contact)
        register_instance_option :root? do
          true
        end

        register_instance_option :collection? do
          false
        end

        # Is the action on an object scope (Example: /admin/team/1/edit)
        register_instance_option :member? do
          false
        end

        register_instance_option :route_fragment do
          'robots_txt_editor'
        end

        register_instance_option :template_name do
          'robots_txt'
        end

        register_instance_option :controller do
          Proc.new do |klass|
            if request.get?
              text = File.read(Rails.root.join("public", "robots.txt"))

              # https://github.com/javierjulio/textarea-autosize/blob/master/src/jquery.textarea_autosize.js
              onkeyup = [
                "diff = ",
                "parseInt($(this).css('paddingBottom')) + ",
                "parseInt($(this).css('paddingTop')) + ",
                "parseInt($(this).css('borderTopWidth')) + ",
                "parseInt($(this).css('borderBottomWidth')) || 0; ",
                "$(this).height(0).height(this.scrollHeight - diff);"
              ]

              # {value: text, cols: 80..150, cols: 5..20}
              @textarea_opts = {value: text}
              @textarea_opts[:cols] = text.lines.map(&:size).max || 80
              @textarea_opts[:cols] = 80  if @textarea_opts[:cols] < 80
              @textarea_opts[:cols] = 150 if @textarea_opts[:cols] > 150
              @textarea_opts[:rows] = text.lines.count + 1
              @textarea_opts[:rows] = 5   if @textarea_opts[:rows] < 5
              @textarea_opts[:rows] = 20  if @textarea_opts[:rows] > 20
              @textarea_opts[:onkeyup] = onkeyup.join
              @textarea_opts[:oninput] = onkeyup.join

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


module RailsAdmin
  module Config
    module Actions
      class RobotsTxtForModel < RobotsTxt
        RailsAdmin::Config::Actions.register(self)

        # Is the action acting on the root level (Example: /admin/contact)
        register_instance_option :root? do
          false
        end

        register_instance_option :collection? do
          true
        end

        register_instance_option :route_fragment do
          'robots_txt_editor'
        end

        register_instance_option :template_name do
          'robots_txt'
        end

      end
    end
  end
end
