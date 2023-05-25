# frozen_string_literal: true

Rails.application.routes.draw do
  get '/web_form' => 'web_forms#show'
end
