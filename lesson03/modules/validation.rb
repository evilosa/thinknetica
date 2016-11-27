require_relative '../exceptions/train_management_exception'

module Validation
    def self.included(base)
        base.extend ClassMethods
        base.include InstanceMethods
    end

    module ClassMethods # Методы класса
        @validation_rules # Переменная класса хранящая правила проверки изолированно для каждого класса

        # Геттер для доступа к правилам проверки извне, при первом обращении инициализируется
        def validation_rules
          @validation_rules ||= {}
        end

        # Метод для добавления правила проверки на nil, задается по имени свойства
        def add_value_availability_validation_rule(attribute_name)
          validate_attribute_name_parameter(attribute_name)

          validation_key = "value_availability_check_#{attribute_name}".to_sym
          validation_rules[validation_key] = {:name => attribute_name, :validation_rule => :value_availability_check, :option => nil }
        end

        # Метод для добавления правила проверки заполнения по типу, задается по имени свойства и ожидаемому типу
        def add_value_type_validation_rule(attribute_name, type)
          validate_attribute_name_parameter(attribute_name)
          validate_type_parameter(type)

          validation_key = "value_type_check_#{attribute_name}".to_sym
          validation_rules[validation_key] = {:name => attribute_name, :validation_rule => :value_type_check, :option => type }
        end

        # Метод для добавления правила проверки значения по формату, задается по имени свойства и форматной строке
        def add_value_format_validation_rule(attribute_name, format_string)
          validate_attribute_name_parameter(attribute_name)
          validate_format_string_parameter(format_string)

          validation_key = "value_format_check_#{attribute_name}".to_sym
          validation_rules[validation_key] = {:name => attribute_name, :validation_rule => :value_format_check, :option => format_string }
        end

      private

        # Закрытые проверки параметров функций
      def validate_attribute_name_parameter(attribute_name)
        raise TrainManagementException::AttributeNameValidationRuleError,
              'Validation rule: Incorrect attribute_name' if attribute_name.nil? || attribute_name == ''
      end

      def validate_type_parameter(type)
        raise TrainManagementException::AttributeTypeValidationRuleError,
              'Validation rule: Incorrect type' if type.nil?
      end

      def validate_format_string_parameter(format_string)
        raise TrainManagementException::FormatStringValidationRuleError,
              'Validation rule: Incorrect format string' if format_string.nil? || format_string == ''
      end
    end
    
    module InstanceMethods

        # Метод для проверки заполенения объекта
        def valid?
            validate!
            true
        rescue
            false
        end

        private

        # Метод уровня экземпляра класса
        # Выполняет проверку свойств объекта в соответствии с правилами
        # проверки заданными для класса
        def validate!
          self.class.validation_rules.each_value do |value|
            attribute_name = value[:name].to_s
            property = instance_variable_get("@#{attribute_name}")

            case value[:validation_rule]
              when :value_availability_check
                validate_availability(attribute_name, property)
              when :value_type_check
                validate_value_type(attribute_name, property, value[:option])
              when :value_format_check
                validate_value_format(attribute_name, property, value[:option])
            end
          end
        end

        def validate_availability(attribute_name, property)
          raise TrainManagementException::AvailabilityValidationError.new(attribute_name: attribute_name) if property.nil? || property == ''
        end

        def validate_value_type(attribute_name, property, type)
          raise TrainManagementException::TypeValidationError.new(attribute_name: attribute_name) unless property.is_a? type
        end

        def validate_value_format(attribute_name, property, format_string)
          raise TrainManagementException::ValueValidationError.new(attribute_name: attribute_name) if property !~ format_string
        end
    end    
end