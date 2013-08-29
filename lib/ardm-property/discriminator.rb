module Ardm
  class Property
    class Discriminator < Class
      default   lambda { |resource, property| resource.model }
      required  true

      # @api private
      def bind
        model.extend Model unless model < Model
      end

      module Model
        def inherited(model)
          super  # setup self.descendants
          set_discriminator_scope_for(model)
        end

        def new(*args, &block)
          if args.size == 1 && args.first.kind_of?(Hash)
            discriminator = properties.discriminator

            if discriminator_value = args.first[discriminator.name]
              model = discriminator.typecast(discriminator_value)

              if model.kind_of?(Model) && !model.equal?(self)
                return model.new(*args, &block)
              end
            end
          end

          super
        end

      private

        def set_discriminator_scope_for(model)
          discriminator = self.properties.discriminator
          default_scope = model.default_scope
          default_scope.update(discriminator.name => model.descendants.dup << model)
        end
      end
    end # class Discriminator
  end # class Property
end # module Ardm