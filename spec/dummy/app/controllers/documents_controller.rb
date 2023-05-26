# frozen_string_literal: true

class DocumentsController < ApplicationController
  def show
    document = Document.find(params[:id])

    render :show, locals: { document: document }
  end
end
