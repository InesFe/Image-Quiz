class QuizSubmissionsController < ApplicationController
  before_action :find_quiz_submission, only: %i[show]

  def show
    @quiz = @quiz_submission.quiz
  end

  def submit_quiz
    @quiz = Quiz.find(params[:id])
    answers = params[:answers]

    # Calculate the score
    score = 0
    nombre_de_questions = 0
    @quiz.questions.each do |question|
      correct_answer = question.correct_answer
      user_answer = answers[question.id.to_s].to_i
      score += 1 if user_answer == correct_answer
      nombre_de_questions += 1
    end

    # Save or display the score as needed
    @score = score
    @nombre_de_questions = nombre_de_questions

    respond_to do |format|
      format.html { redirect_to quiz_path(@quiz), notice: "Votre score est de #{@score}/#{@nombre_de_questions}" }
    end
  end

  private

  def find_quiz_submission
    @quiz_submission = QuizSubmission.find(params[:id])
  end

  def quiz_submission_params
    params.require(:quiz_submission).permit(:quiz_id, :user_id, :score, user_answers: {})
  end
end