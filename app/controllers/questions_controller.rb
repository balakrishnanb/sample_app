class QuestionsController < ApplicationController
    before_filter :authenticate_user!, only: [:create, :destroy]

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
            redirect_to @question
        else
            render :new
        end
    end

    def destroy
        @question = Question.find(params[:id])
        @question.destroy
    end
end

