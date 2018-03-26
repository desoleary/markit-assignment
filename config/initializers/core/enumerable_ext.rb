module Enumerable
  # Collect the block provided and compact the resulting collection
  def collect_compact
    collect { |record| yield(record) }.compact
  end
end