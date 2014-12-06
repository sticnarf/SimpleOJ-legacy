class TestFilesController < ApplicationController
  def new
    @test_file = TestFile.new
  end

  def create
    @test_file = TestFile.new
    problem = Problem.find_by(id: params[:test_file][:problem_id])
    @test_file.problem = problem
    @test_file.data = params[:test_file][:data]
    if @test_file.save
      outdated = TestFile.where(["problem_id = ? AND id != ?", problem.id, @test_file.id]).first
      outdated.destroy if outdated
      redirect_to @test_file.problem
    else
      render 'new'
    end
  end
end
