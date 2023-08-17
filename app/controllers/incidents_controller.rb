class IncidentsController < ApplicationController
  def index
    @incidents = Incident.order(created_at: :desc).limit(5) # Fetch the top 5 latest incidents
    @welcome_message = "Welcome to the Incident Tracker!"
  end

  def show
    @incident = Incident.find(params[:id])
  end

  def lists
    @incidents = Incident.all
  end

  def open_incidents
    @incidents = Incident.all
  end

  def resolved_incidents
    @incidents = Incident.all
  end
end
