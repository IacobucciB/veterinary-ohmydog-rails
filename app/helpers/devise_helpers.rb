# app/helpers/devise_helper.rb

module DeviseHelper
    def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
    end
  end
  