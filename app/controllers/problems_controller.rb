class ProblemsController < ApplicationController
  def index
    @problems = Problem.all
  end

  def new
    @problem = Problem.new
  end

  def create
    @problem = Problem.new(problem_params)
    if @problem.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @problem = Problem.find_by(id: params[:id])
    @submit = Submit.new(problem_id: @problem.id)
  end

  private

  def problem_params
    params.require(:problem).permit(:title, :description)
  end
end
