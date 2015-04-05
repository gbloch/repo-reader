Rails.application.routes.draw do
  root "welcome#index"

  post "book", to: "book#index"

  get "*fake_url_segment", to: "book#show"
end
