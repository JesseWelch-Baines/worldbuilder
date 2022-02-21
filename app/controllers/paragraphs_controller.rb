class ParagraphsController < ApplicationController

  def index
    @paragraphs = current_user.paragraphs.active.where(world_id: Current.world.id)
  end

  def new
    @paragraph = Paragraph.new
  end

  def create
    @paragraph = current_user.paragraphs.new(paragraph_params)

    if @paragraph.save
      redirect_to paragraphs_path
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity}
      end
    end
  end

  def create_from_document
    @document = Document.find(params[:document_id])

    if params["new_paragraph_#{params[:order]}"][:description].present?
      paragraph = current_user.paragraphs.create(name: '', description: params["new_paragraph_#{params[:order]}"][:description], status: :archived, world_id: Current.world.id)
      paragraph.create_instance(current_user.id, @document.id, params[:order])
      @document.sort_instances
    end
    redirect_to document_path(@document)
  end

  def edit
    @paragraph = Paragraph.find(params[:id])
  end

  def update
    @paragraph = Paragraph.find(params[:id])

    if paragraph_params[:description].empty? && params[:paragraph][:document_id].present?
      @paragraph.writable_instances.destroy_all
      @paragraph.destroy
      redirect_to document_path(params[:paragraph][:document_id]) and return
    end

    if @paragraph.update(paragraph_params)
      if params[:paragraph][:document_id].present?
        redirect_to document_path(params[:paragraph][:document_id])
      else
        redirect_to paragraphs_path
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity}
      end
    end
  end

  def show
    @paragraph = Paragraph.includes(writable_instances: :document).find(params[:id])
  end

  def destroy
    @paragraph = Paragraph.find(params[:id])

    @paragraph.writable_instances.destroy_all
    @paragraph.destroy

    redirect_to paragraphs_path
  end

  def create_instance
    Paragraph.find(params[:id]).create_instance(current_user.id, params[:document_id], params[:order])

    redirect_to document_path(params[:document_id])
  end

  private

  def paragraph_params
    params.require(:paragraph).permit(:name, :description)
  end

end
