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
    work = Work.new(work_params)

    is_successful = work.save

    if is_successful
      redirect_to work_path(work.id)
    else
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
      is_successful = Work.update(work_params)
    end

    if is_successful
      redirect_to work_path(work.id)
    else
      @work = work
      render :edit, status: :bad_request
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])

    if work.nil?
      head :not_found
    else
      work.trips.each do |trip|
        trip.destroy
      end
      work.destroy
      redirect_to works_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
