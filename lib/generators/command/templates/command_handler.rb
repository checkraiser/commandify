module CommandHandler
  extend ActiveSupport::Concern

  def handle(command, params)
    cmd = command.call(params)
    if cmd.success?
      { result: cmd.result }
    else
      { errors: cmd.errors }
    end
  end
end