class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :search]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  def search_results
    @projects = Project.all
  end

  def search
      @projects = Project.search do
          fulltext params[:query]
      end.results

      respond_to do |format|
      format.html { render :action => "search_results" }
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find_by_id(params[:id])
    @comments = @project.comments.paginate(page: params[:page], per_page: 5)
  end

  # GET /projects/index_by_date

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to "/static_pages/landing_page", notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to "/static_pages/landing_page", notice: 'Project was successfully updated.' }
        format.json { render :edit, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :author, :collaborators, :description, :analysis, :website, :image_url, :year_made, :date_began, :date_ended, :img2_url, :img3_url, :img4_url, :bio, :questions, :ongoing)
    end
end
