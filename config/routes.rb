Rails.application.routes.draw do
  root "search#index"

  post "search", to: "search#search"
  post "book", to: "book#index"

  get "*fake_url_segment", to: "book#show"
end
