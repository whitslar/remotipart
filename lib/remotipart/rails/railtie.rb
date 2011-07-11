# Configure Rails 3.0 to use form.js and remotipart
module Remotipart
  module Rails

    class Railtie < ::Rails::Railtie
      config.before_configuration do
        # Figure out where rails.js (aka jquery_ujs.js if install by jquery-rails gem) is
        # in the :defaults array
        position = config.action_view.javascript_expansions[:defaults].index('rails') ||
          config.action_view.javascript_expansions[:defaults].index('jquery_ujs')

        # Merge form.js and then remotipart into :defaults array right after rails.js
        if position && position > 0
          config.action_view.javascript_expansions[:defaults].insert(position + 1, 'jquery.form', 'jquery.remotipart')
        # If rails.js couldn't be found, it may have a custom filename, or not be in the :defaults.
        # In that case, just try adding to the end of the :defaults array.
        else
          config.action_view.javascript_expansions[:defaults].push('jquery.form', 'jquery.remotipart')
        end
      end

      initializer "remotipart.view_helpers" do
        ActionView::Base.send :include, ViewHelpers
      end
    end

  end
end