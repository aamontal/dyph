module Animal
  def ==(other)
    other.class == self.class &&
    other.type == self.type
  end

  alias_method :eql?, :==

  def hash
    type.hash
  end
end

class Fish
  include Animal
  DIFF_PREPROCESSOR = -> (animal) { [animal.type] }
  DIFF_POSTPROCESSOR = -> (animal_array) { Fish.new(animal_array.first) }
  DIFF_CONFLICT_PROCESSOR = ->(differ_output) do
    [
      {
        conflict_custom: [:tuna],
        left: differ_output[0].left,
        right: differ_output[0].right,
        base: differ_output[0].right
     }
   ]
  end
  attr_accessor :type
  def initialize(type)
    @type = type
  end

  def text
    "Blub"
  end

end

class Bird
  include Animal

  attr_accessor :type
  def initialize(type)
    @type = type
  end

  def text
    "Tweet"
  end

end