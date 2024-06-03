class QuizSubmissionsController < ApplicationController
  before_action :find_quiz, only: [:create, :show] 
  
  def create
    @quiz = Quiz.find(params[:quiz_id])
    user_answers = params[:answers] || {}
    correct_answers = 0

    Rails.logger.debug("Received params: #{params.inspect}")

    params.each do |key, value|
      if key.start_with?('question_')
        Rails.logger.debug("Param: #{key} => #{value}")
        question_id = params[:question_id].to_i
        Rails.logger.debug "Question ID: #{question_id}"
        selected_answer = value.to_i
        user_answers[question_id.to_s] = selected_answer
        question = Question.find_by(id: question_id)

        if question.nil?
          Rails.logger.error "Question with ID #{question_id} not found"

        elsif selected_answer == question.correct_answer 
          correct_answers +=1
          Rails.logger.error "Bonnes réponses = #{correct_answers}"
        end
      end
    end
    
    @score = (@quiz.questions.count.positive? ? (correct_answers.to_f / @quiz.questions.count) * 100 : 0)
    quiz_submission = QuizSubmission.create(quiz: @quiz, 
                      user: current_user, score: @score, user_answers: user_answers)
    
    
    #@quiz_submission.update(score: @score)
    redirect_to quiz_question_submission_path(@quiz, params[:question_id], quiz_submission)
  end

  def show
    @quiz_submission = QuizSubmission.find(params[:id])
    @quiz = @quiz_submission.quiz
  end

  private

  def find_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def find_quiz_submission
  @quiz_submission = QuizSubmission.find(params[:id])
  end

  def quizz_submission_params
    params.require(:quiz_submission).permit(:quiz_id, :user_id, :score, user_answers: {} )
  end
end
