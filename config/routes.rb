Rails.application.routes.draw do
  root 'home#index'
  get "/search", to: "search#default_review_search"
  get "/search/wine", to: "search#reviews_by_wine"
  get "/search/winery", to: "search#reviews_by_winery"
  get "/search/taster", to: "search#reviews_by_taster"
  get "/search/variety", to: "search#reviews_by_variety"
end
