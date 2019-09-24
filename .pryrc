# Pry.config.commands = Pry::CommandSet.new do
# end

Pry.config.history.file = '~/.pry_history'

Pry.config.prompt = %i[> *].map do |sep|
  proc do |context, nesting, pry|
    format(
      '[v%<version>s] %<name>s(%<context>s)' \
      'l:%<in_count>s/n:%<nesting>s%<separator>s ',
      version: RUBY_VERSION,
      in_count: pry.input_ring.count,
      name: pry.config.prompt_name,
      context: Pry.view_clip(context),
      nesting: nesting,
      separator: sep
    )
  end
end
