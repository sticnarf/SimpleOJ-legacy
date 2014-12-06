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
      redirect_to @problem
    else
      render 'new'
    end
  end

  def show
    @problem = Problem.find_by(id: params[:id])
    @submit = Submit.new(problem_id: @problem.id)
  end

  def edit
    @problem = Problem.find_by(id: params[:id])
  end

  def update
    @problem = Problem.find_by(id: params[:id])
    if @problem.update_attributes(problem_params)
      redirect_to @problem
    else
      render 'edit'
    end
  end

  private

  def problem_params
    params.require(:problem).permit(:title, :description, :abbr)
  end
end
