class SubmitsController < ApplicationController
  def index
    @submits = Submit.last(100)
  end

  def show
    @submit = Submit.find_by(id: params[:id])
  end

  def create
    submit = Submit.new(submit_params)
    if submit.save
      CompileWorker.perform_async(submit.id)
      redirect_to submits_url
    else
      redirect_to problem_url(submit.problem)
    end
  end

  private

  def submit_params
    params.require(:submit).permit(:problem_id, :code)
  end
end
