module Workflow
  class Specification

    attr_accessor :states, :initial_state, :meta, :on_transition_proc

    def initialize(meta = {}, &specification)
      @states = Hash.new
      @meta = meta
      instance_eval(&specification)
    end

    def state_names
      states.keys
    end

    private

    def state(name, meta = {}, &events_and_etc)
      # meta[:meta] to keep the API consistent..., gah
      new_state = State.new(name, meta)
      @initial_state = new_state if @states.empty?
      @states[name.to_sym] = new_state
      @scoped_state = new_state
      instance_eval(&events_and_etc) if events_and_etc
    end

    def event(name, args = {}, &action)
      target = args[:transitions_to] || args[:transition_to]
      raise WorkflowDefinitionError.new(
        "missing ':transitions_to' in workflow event definition for '#{name}'") \
        if target.nil?
      @scoped_state.events[name.to_sym] =
        Event.new(name, target, (args[:meta] or {}), &action)
    end

    def on_entry(&proc)
      @scoped_state.on_entry = proc
    end

    def on_exit(&proc)
      @scoped_state.on_exit = proc
    end

    def on_transition(&proc)
      @on_transition_proc = proc
    end
  end
end