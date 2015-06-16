Rails.application.routes.draw do

  root to: "board#index"
  get "/:board_id", to: "board#show", as: "board"

end
