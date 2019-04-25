class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    is_successful = @work.save

    if is_successful
      flash[:success] = "Medium added successfully"
      redirect_to work_path(@work.id)
    else
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new, status: :bad_request
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to works_path
    end
  end

  def update
    work = Work.find_by(id: params[:id])

    if work.nil?
      redirect_to works_path
    else
      is_successful = work.update(work_params)
    end

    if is_successful
      flash[:success] = "Medium updated successfully"
      redirect_to work_path(work.id)
    else
      @work = work
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :edit, status: :bad_request
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])

    if work.nil?
      flash[:error] = "the work DOES NOT EXIST"
    else
      work.destroy
      flash[:success] = "you KILLED it"
      redirect_to works_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
