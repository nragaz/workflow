module Workflow
  module WorkflowClassMethods
  
    attr_reader :workflow_spec

    def workflow_column(column_name=nil)
      if column_name
        @workflow_state_column_name = column_name.to_sym
      else
        @workflow_state_column_name ||= :workflow_state
      end
      @workflow_state_column_name
    end

    def workflow(&specification)
      @workflow_spec = Specification.new(Hash.new, &specification)
      @workflow_spec.states.values.each do |state|
        state_name = state.name
        column_name = workflow_column
        module_eval do
          define_method "#{state_name}?" do
            state_name == current_state.name
          end
          scope (state_name.to_s+"_state").to_sym, where(column_name => state_name.to_s) if self.respond_to?(:scope)
        end

        state.events.values.each do |event|
          event_name = event.name
          module_eval do
            define_method "#{event_name}!".to_sym do |*args|
              process_event!(event_name, *args)
            end
          end
        end
      end
    end
  
  end
end