Rails.application.routes.draw do
  root "welcome#index"

  get "*fake_url_segment", to: "welcome#index"
end
