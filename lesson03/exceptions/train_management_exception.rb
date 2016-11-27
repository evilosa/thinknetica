class TrainManagementException
  # Я знаю, что можно так детально не объявлять, но я всеже объявлю детально для более полного управления исключениями

  # >> Три нижеследущих используются для проверки параметров функций правил валидации
  # Для проверки заполнения имени атрибута в правилах проверки
  class AttributeNameValidationRuleError < StandardError
  end

  # Для проверки заполнения типа атрибута в правилах проверки
  class AttributeTypeValidationRuleError < StandardError
  end

  # Для проверки заполнения формата атрибута в правилах проверки
  class FormatStringValidationRuleError < StandardError
  end

  # >> Эти для вызова исключений в самих проверках

  # Для проверки на nil
  class AvailabilityValidationError < StandardError
    attr_accessor :attribute_name

    def initialize(attribute_name: '')
      super
      @attribute_name = attribute_name
    end

    def to_s
      "Availability validation error: attribute #{attribute_name} is nil"
    end
  end

  # Для проверки правильности переданного типа
  class TypeValidationError < StandardError
    attr_accessor :attribute_name

    def initialize(attribute_name: '')
      super
      @attribute_name = attribute_name
    end

    def to_s
      "Type validation error: attribute #{attribute_name} has wrong type"
    end
  end

  # Для проверки заполения значения в соответствии с форматной строкой
  class ValueValidationError < StandardError
    attr_accessor :attribute_name

    def initialize(attribute_name: '')
      super
      @attribute_name = attribute_name
    end

    def to_s
      "Value validation error: attribute #{attribute_name} has wrong format"
    end
  end

  # >> Эти для обработки ввода в меню
  # Пользователь ввел пункт меню, который недоступен для данного раздела
  class MenuIndexOutOfRange < StandardError
    def to_s
      'Menu index is out of range'
    end
  end

  # Пользователь ввел верблюжатину вместо индекса меню
  class MenuIndexIncorrectInput < StandardError
    def to_s
      'Menu index has wrong format'
    end
  end
end