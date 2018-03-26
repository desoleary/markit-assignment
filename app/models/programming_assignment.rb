class ProgrammingAssignment

  def initialize(size)
    # Rescuing is considered slow so consider another method if method causes significant slowdown
    raise "Unsupported type found {#{size.class}}" unless ((@size = Integer(size)) rescue false)
    raise 'Size needs to be >= 20'                 if @size < 20
    raise 'Size must be an even number'            if @size.odd?
    raise "Size {#{@size}} is not divisible by 20" unless @size % 20 == 0
  end

  def bins
    @bins ||= separate_into_bins()
  end

  # @return [Integer[]] randomized list of N
  def randomize_list
    # Size a 'holder' list for randomization
    @randomize_list ||= (1..@size).to_a.shuffle
  end

  # @return [Integer[]] first half of (N/2+) section
  def first_half
    @first_half ||= randomize_list.first(size_div_two)
  end

  def bin_size
    size_div_two / 10
  end

  private

  # Increments each bin where randomized number falls in range ((N/2) / 10)
  def separate_into_bins
    @bins     = [0,0,0,0,0,0,0,0,0,0]

    first_half.each { |random_number|
      # Only populate numbers less than or equal the mid input number i.e. input => 200 only populate items with a an amount less than or equal to 100
      if random_number <= size_div_two
        # Find the bin-index for the number
        bin_index = (random_number / bin_size) - 1

        # Increment matching bin by one
        @bins[bin_index] = @bins[bin_index] + 1
      end
    }
    @bins
  end

  # Divides N by 2
  def size_div_two
    @size_div_two ||= (@size / 2)
  end
end