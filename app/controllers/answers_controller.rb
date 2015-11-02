class AnswersController < ApplicationController
    before_filter :authenticate_user!
    def create
        @answer = Answer.new(params[:answer])
        @answer.question = Question.find(params[:question_id])
        puts "####################################", params
        @answer.user = current_user
        if @answer.save
            redirect_to @answer.question, notice: "Answer added successfully"
        else
            redirect_to @answer.question, notice: "Failed to add answer"
        end
    end

    def destroy
        @answer = Answer.find(params[:id])
        @question = @answer.question
        if current_user == @answer.user
            @answer.destroy
            redirect_to @question, notice: "Answer deleted successfully"
        else
            redirect_to @question, alert: "You are not authorized to delete!"
        end
    end
end
