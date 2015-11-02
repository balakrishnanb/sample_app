class QuestionsController < ApplicationController
    before_filter :authenticate_user!, only: [:create, :destroy, :update]

    def index
        @questions = Question.paginate(page: params[:page])
    end

    def show
        @question = Question.find(params[:id])
    end

    def edit
        @question = Question.find(params[:id])
    end

    def new
        @question = Question.new
    end

    def create
        @question = Question.new(params[:question])
        @question.user = current_user
        if @question.save
            redirect_to @question, notice: "Asked question successfully!"
        else
            render :new
        end
    end

    def update
        @question = Question.find(params[:id])
        if params[:question][:user_id] #Trying to update other's id
            redirect_to @question, alert: "You are not authorized to edit!"
        end
        if @question.update_attributes(params[:question])
            redirect_to @question, notice: "Question updated successfully!"
        else
            render :edit
        end
    end

    def destroy
        @question = Question.find(params[:id])
        if current_user == @question.user
            @question.destroy
            redirect_to root_path, notice: "Question deleted successfully"
        else
            redirect_to @question, alert: "You are not authorized to delete!"
        end
    end
end

