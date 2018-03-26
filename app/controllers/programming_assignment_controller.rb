class ProgrammingAssignmentController < ApplicationController

  def index
    @assignment = assignment
  end

  def ajax_redraw_canvas
    error_message = nil

    begin
      @assignment = assignment
    rescue => ex
      error_message = {}
      error_message[:input] = ex.message  # sets element with name matching 'input' validation notifier
    end

    respond_to do |format|
      format.json { render :json => error_message.to_json } if error_message
      format.js                                      unless error_message
    end
  end

  def assignment
    decorate(ProgrammingAssignment.new(params[:input] || 20))
  end
end
