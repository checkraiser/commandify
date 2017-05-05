module CommandHandler
  extend ActiveSupport::Concern

  def handle(command, params)
    cmd = command.call(params)
    if cmd.success?
      cmd.result
    else
      cmd.errors
    end
  end
end