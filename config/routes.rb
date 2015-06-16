Rails.application.routes.draw do

  root to: "board#index"
  post "/", to: "board#create"
  get "/:board_id", to: "board#show", as: "board"

end
