module Excel
  def to_csv options = {}
    column_name = options[:column_names]
    CSV.generate() do |csv|
      csv << column_name
      all.find_each do |record|
        csv << record.attributes.values_at(*column_name.map(&:to_s))
      end
    end
  end
end
