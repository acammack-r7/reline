require 'reline'
require 'reline/key_actor'

class Reline::LineEditor
  attr_reader :line

  def initialize(key_actor, prompt)
    @prompt = prompt
    @cursor = @prompt.size
    @line = String.new
    @key_actor = key_actor
    @finished = false

    print prompt
  end

  def input_key(key)
    method_symbol = @key_actor.get_method(key)
    send(method_symbol, key) if method_symbol
  end

  def finished?
    @finished
  end

  private def ed_insert(key)
    print key.chr
    @cursor += 1
    @line += key.chr
  end

  private def ed_newline(key)
    print "\r\n"
    @finished = true
    @line += "\n"
  end
end
