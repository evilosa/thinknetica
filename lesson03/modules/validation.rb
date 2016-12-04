require_relative '../exceptions/train_management_exception'

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods # Методы класса
    @validation_rules # Переменная экземпляра уровня класса хранящая правила проверки изолированно для каждого класса

    # Геттер для доступа к правилам проверки извне, при первом обращении инициализируется
    def validation_rules
      @validation_rules ||= {}
    end

    # # Метод для добавления правила проверки на nil, задается по имени свойства
    # def add_value_availability_validation_rule(attribute_name)
    #   add_validation_rule attribute_name, :value_availability_check, nil
    #   # validation_key = "value_availability_check_#{attribute_name}".to_sym
    #   # validation_rules[validation_key] = { name: attribute_name, validation_rule: :value_availability_check, option: nil }
    # end

    # # Метод для добавления правила проверки заполнения по типу, задается по имени свойства и ожидаемому типу
    # def add_value_type_validation_rule(attribute_name, type)
    #   add_validation_rule attribute_name, :value_type_check, type
    #   # validation_key = "value_type_check_#{attribute_name}".to_sym
    #   # validation_rules[validation_key] = { name: attribute_name, validation_rule: :value_type_check, option: type }
    # end

    # # Метод для добавления правила проверки значения по формату, задается по имени свойства и форматной строке
    # def add_value_format_validation_rule(attribute_name, format_string)
    #   add_validation_rule attribute_name, :value_format_check, format_string
    # end

    private

    def validate(name, rule, option = nil)
      rule_correct = [:availability, :type, :format].include? rule
      raise TypeError, 'Unknown validation rule' unless rule_correct

      key = "value_format_check_#{name}".to_sym
      validation_rules[key] = { name: name, rule: rule, option: option }
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

        send("validate_#{value[:rule]}", attribute_name, property, value[:option])
      end
    end

    def validate_availability(attribute_name, property, _option)
      raise TrainManagementException::AvailabilityValidationError, attribute_name: attribute_name if property.nil? || property == ''
    end

    def validate_type(attribute_name, property, type)
      raise TrainManagementException::TypeValidationError, attribute_name: attribute_name unless property.is_a? type
    end

    def validate_format(attribute_name, property, format_string)
      raise TrainManagementException::ValueValidationError, attribute_name: attribute_name if property !~ format_string
    end
  end
end
