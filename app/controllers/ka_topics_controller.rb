class KaTopicsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :check_admin

  layout "ka_application"

  def show
    respond_to do |format|
      format.html
      format.json { render json: KaTopic.find(params[:id]).get_tree }
    end
  end

  def new
    topic = KaTopic.new
    topic.text = params[:text]
    if params[:parent_id]
      topic.parent_id = params[:parent_id]
    end
    topic.save
    redirect_to :back
  end

  def create
  end

  def index
  end

  def edit
    @topic = KaTopic.find(params[:id])
    @competences = Competence.all
    @constructs = Construct.all
  end

  def edit_text
    topic = KaTopic.find(params[:id])
    if topic and params[:text]
      topic.text = params[:text]
      topic.save
    end
    redirect_to :back
  end

  def destroy
    topic = KaTopic.find(params[:id])
    topic.destroy
    redirect_to :back
  end

  def show_topics_with_questions
    @root = KaTopic.find(params[:root_id])
    @topics = @root.get_tree
    @questions = @root.get_active_questions
  end

  def show_all_competences
    @root = KaTopic.find(params[:root_id])
    @topics = @root.get_tree
  end

  def show_all_constructs
    @root = KaTopic.find(params[:root_id])
    @topics = @root.get_tree
  end
end
