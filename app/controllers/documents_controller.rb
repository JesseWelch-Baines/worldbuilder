class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_action :set_paragraphs, only: [:show]
  before_action :set_articles, only: [:show]

  def index
    @documents = current_user.documents.includes(:article_instances).where(world_id: Current.world.id)
  end

  def show
    # @article_fields = current_user.article_fields.where(world_id: Current.world.id)
  end

  def new
    @document = current_user.documents.new
  end

  def edit; end

  def create
    @document = current_user.documents.new(document_params)

    if @document.save
      redirect_to documents_path
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @document.update(document_params)
      redirect_to documents_path
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_path, notice: "#{@document.name} deleted" }
      format.json { head :no_content }
    end
  end

  def article_instances
    article_instances = @document.article_instances

    article_instances_array = []

    article_instances.each do |article_instance|
      article_instance_object = article_instance.article.as_json
      article_instance_object["description"] = article_instance.article.description.body
      article_instances_array << article_instance_object
    end

    respond_to do |format|
      format.json { render json: article_instances_array }
    end
  end

  private

  def document_params
    params.require(:document).permit(:name, :new_paragraph_body)
  end

  def set_document
    @document = current_user.documents.find(params[:id])
  end

  def set_paragraphs
    @articles = current_user.articles.includes(:rich_text_description).where(world_id: Current.world.id)
  end

  def set_articles
    @paragraphs = current_user.paragraphs.includes(:rich_text_description).where(world_id: Current.world.id).select(&:active?)
  end
end
