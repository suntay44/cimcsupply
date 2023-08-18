class IncidentsController < ApplicationController
  def index
    counts_graph
    @incidents                = Incident.order(created_at: :desc).limit(5)
    @high_priority_incidents  = Incident.order(created_at: :desc).where(severity: "sev2", status: 'open').limit(5)
    @mid_priority_incidents   = Incident.order(created_at: :desc).where(severity: "sev1", status: 'open').limit(5)
  end

  def show
    @incident = Incident.find(params[:id])
  end

  def lists
    counts_graph
    @pagy, @incidents = pagy_countless(Incident.order(created_at: :desc), items: 10)
  end

  def open_incidents
    counts_graph
    pagy_incidents('open')
  end

  def resolved_incidents
    counts_graph
    pagy_incidents('resolved')
  end

  private

  def counts_graph
    @total_incidents          = Incident.where(status: 'open').count
    @total_solved_incidents   = Incident.where(status: 'resolved').count
  end

  def all_incidents
    @incidents = Incident.all
  end

  def pagy_incidents(status)
    @pagy, @incidents = pagy_countless(Incident.order(created_at: :desc).where(status: status), items: 10)
  end
end
