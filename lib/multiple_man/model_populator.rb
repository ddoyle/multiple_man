module MultipleMan
  class ModelPopulator

    def initialize(record, fields)
      self.record = record
      self.fields = fields
    end

    def populate(data)
      fields_for(data).each do |field|
        populate_field(field, data[field])
      end
      record
    end

  private 
    attr_accessor :record, :fields

    # Raise an exception if explicit fields were provided.
    def should_raise?
      fields.present?
    end

    def populate_field(field, value)
      setter = "#{field}="
      if record.respond_to?(setter)
        record.send(setter, value)
      elsif should_raise?
        raise "Record #{record} does not respond to #{setter}"
      end
    end

    def fields_for(data)
      fields || data.keys
    end
  end
end