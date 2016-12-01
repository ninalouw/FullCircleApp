json.array! @goals do |goal|
  json.id goal.id
  json.name goal.name
  json.minutes goal.minutes
  json.count_consecutive_days_completed goal.count_consecutive_days_completed
  json.latest_date_completed goal.latest_date_completed
  json.user do
    json.first_name goal.user_first_name
    json.last_name  goal.user_last_name
  end
  json.url api_v1_goal_url(goal)
end
