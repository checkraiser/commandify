module CommandHandler
  extend ActiveSupport::Concern

  def handle(command, params)
    cmd = command.call(params)
    if cmd.success?
      render json: cmd.result
    else
      render json: cmd.errors
    end
  end
end