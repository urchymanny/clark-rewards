Rails.application.routes.draw do
  post "rewards", to: "rewards#calculate"
  post "rewards/from/file", to: "rewards#file_calculate"
end
