class API::TicketsController < API::BaseController
  attr_reader :current_user
  before_action :authenticate_user
  before_action :set_project

  def show
    @ticket = Ticket.find(params[:id])
    authorize @ticket, :show?
    render json: @ticket
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    authorize @ticket, :create?
    if @ticket.save
      render json: @ticket, status: 201
    else
      render json: { errors: @ticket.errors.full_messages }, status: 422
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description)
  end

end
