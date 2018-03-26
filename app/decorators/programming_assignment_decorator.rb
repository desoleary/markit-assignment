class ProgrammingAssignmentDecorator < Draper::Base
  def labels
    @labels ||= (1..model.bins.length).collect { |index|
      upper_range = model.bin_size*index
      lower_range = upper_range - model.bin_size + 1
      "#{lower_range} to #{upper_range}"
    }.to_json.html_safe
  end

  def randomize_list_str
    model.randomize_list.join(',')
  end

  def first_half_str
    model.first_half.join(',')
  end

  def input
    randomize_list.length
  end
end