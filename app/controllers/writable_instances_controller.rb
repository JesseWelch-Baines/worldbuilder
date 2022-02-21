class WritableInstancesController < ApplicationController

  def move_up
    writable_instance = WritableInstance.find(params[:id])
    document = Document.find(params[:document_id])
    if (swappable_writable_instance = document.writable_instances.find_by(order: writable_instance.order - 1))
      swappable_writable_instance.update(order: swappable_writable_instance.order + 1)
    end

    writable_instance.update(order: writable_instance.order - 1)

    redirect_to document_path(params[:document_id])
  end

  def move_down
    writable_instance = WritableInstance.find(params[:id])
    document = Document.find(params[:document_id])
    if (swappable_writable_instance = document.writable_instances.find_by(order: writable_instance.order + 1))
      swappable_writable_instance.update(order: swappable_writable_instance.order - 1)
    end

    writable_instance.update(order: writable_instance.order + 1)

    redirect_to document_path(params[:document_id])
  end

  def save_writable
    writable_instance = WritableInstance.find(params[:id])

    writable_instance.writable.active!

    redirect_to document_path(params[:document_id])
  end

  def destroy
    writable_instance = WritableInstance.find(params[:id])
    writable_instance.destroy

    if writable_instance.writable.instance_of?(Paragraph) && writable_instance.writable.archived?
      writable_instance.writable.destroy
    end

    redirect_to document_path(params[:document_id])
  end

end
