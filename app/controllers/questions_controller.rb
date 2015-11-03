class QuestionsController < ApplicationController
    before_filter :authenticate_user!, only: [:create, :destroy, :update, :upvote, :downvote, :clearvote]

    def index
        @questions = Question.paginate(page: params[:page])
    end

    def show
        @question = Question.find(params[:id])
        if user_signed_in?
          @user_vote = Vote.find_by_question_id_and_user_id(params[:id], current_user.id)
          @upvote_link = upvote_question_path
          @downvote_link = downvote_question_path
          @upvote_style = ""
          @downvote_style = ""
          if @user_vote
            if @user_vote.up?
              @upvote_link = clearvote_question_path
              @upvote_style = "background-color: green;"
            else
              @downvote_link = clearvote_question_path
              @downvote_style = "background-color: red;"
            end
          end
        end
    end

    def edit
        @question = Question.find(params[:id])
    end
    
    def upvote
      vote(1)
    end

    def downvote
      vote(2)
    end

    def clearvote
          @previous_vote = Vote.find_by_question_id_and_user_id(params[:id], current_user.id)
          if @previous_vote
            @previous_vote.destroy
          end
          redirect_to :back, notice: "Your vote is removed!"
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

    private
    def vote(value)
        @question = Question.find(params[:id])
        if @question.user == current_user
          redirect_to :back, alert: "You cannot vote your own question!"
        else
          @previous_vote = Vote.find_by_question_id_and_user_id(params[:id], current_user.id)
          if @previous_vote
            @previous_vote.destroy
            vote(value)
          else
              vote = Vote.new
              vote.question = @question
              vote.user = current_user
              vote.value = value
              if vote.save
                redirect_to :back, notice: "Your vote is recorded!"
              else
                redirect_to :back, alert: "Failed to record vote!"
              end
          end
        end
    end

end

