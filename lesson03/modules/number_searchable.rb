module NumberSearchable
    def self.included(base)
        base.extend ClassMethods
        base.include InstancesMethods
    end

    module ClassMethods
        
        def find(number)
            items.detect { |item| item.number == number }
        end

        protected

        @items

        def items
            @items ||=[]
            @items
        end
        
        def register_item! item
            items << item
        end
    end

    module InstancesMethods
        
        attr_reader :number

        protected

        attr_writer :number

        def register_item!
            self.class.send :register_item!, self
        end
    end
end