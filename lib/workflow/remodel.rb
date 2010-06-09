module Workflow
  module RemodelInstanceMethods
    def load_workflow_state
      send(self.class.workflow_column)
    end

    def persist_workflow_state(new_value)
      update(self.class.workflow_column => new_value)
    end
  end
end