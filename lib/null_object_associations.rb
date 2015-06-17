module NullObjectAssociations
  def self.included base
    base.send :extend, SingletonMethods
  end

  module SingletonMethods
    Object.const_set("NullObjectForArgument", Class.new do
      def method_missing(to_be_called, *args)
        if args.empty?
          []
        else
          nil
        end
      end

      def empty?; true; end
    end)

    def has_many(name, actions = {})
      if actions[:respond_to] == :any
        associations = [] 
        associations.extend ArrayMethodMissing
      else
        actions = coerce_actions(actions)
        associations = build_associations(actions)
      end


      define_method(name) do
        associations
      end
    end
    alias_method :has_and_belongs_to_many, :has_many

    def has_one(name)
      define_method(name) { nil }
    end
    alias_method :belongs_to, :has_one

    private

    def coerce_actions(actions)
      case actions[:respond_to]
      when Array, nil
        actions = Array(actions[:respond_to])
      else
        actions = *actions[:respond_to]
      end

      actions
    end

    def build_associations(actions)
      empty_array = []
      noa = NullObjectForArgument.new
      methods_with_arguments = [:pluck, :limit, :order]

      empty_array.tap do |empty_arr|
        actions.each do |action|
          empty_arr.define_singleton_method(action) do |*args|
            if methods_with_arguments.include?(action) && !args.empty?
              return noa
            end

            []
          end
        end
      end
    end

    module ArrayMethodMissing
      def method_missing(*args, &block)
        []
      end
    end
  end
end
