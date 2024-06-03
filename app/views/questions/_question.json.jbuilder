json.extract! question, :id, :quiz_id, :content, :answer1, :answer2, :answer3, :correct_answer, :image, :created_at, :updated_at
json.url question_url(question, format: :json)
