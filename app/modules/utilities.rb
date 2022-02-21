# data manipulation methods for global use
module Utilities
  def random_except(array, exception)
    if array.include?(exception)
      array.reject { |v| v == exception }.sample
    else
      array.sample
    end
  end
end
