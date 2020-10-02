# spec/enumerable_spec.rb
require_relative '../enumerable_methods'

describe Enumerable do
  describe '#my_each' do
    let(:arr) { [2, 3, 5] }
    let(:hash) { { name: 'John', last: 'Doe' } }
    it 'Returns the Enumerator if no block given' do
      expect(arr.my_each).to be_an Enumerator
    end

    it 'When print the elements of the iteration' do
      expect do
        arr.each { |el| p el }
      end.to output("2\n3\n5\n").to_stdout
    end

    it 'When modify the elements of the iteration' do
      expect do
        arr.each { |el| p el + el }
      end.to output("4\n6\n10\n").to_stdout
    end

    it 'When modify the elements of the iteration' do
      expect do
        arr.each { |el| p el + el }
      end.to output("4\n6\n10\n").to_stdout
    end

    it 'When a hash is passed' do
      expect do
        hash.each { |el| p el }
      end.to output("[:name, \"John\"]\n[:last, \"Doe\"]\n").to_stdout
    end
  end

  describe '#my_each_with_index' do
    let(:arr) { [2, 3, 5] }
    let(:hash) { { name: 'John', last: 'Doe' } }
    it 'Returns each element and index of a given array or range' do
      expect do
        arr.my_each_with_index { |x, i| print x, i }
      end.to output('203152').to_stdout
    end

    it 'Returns the Enumerator if no block given' do
      expect(arr.my_each_with_index).to be_an Enumerator
    end

    it 'Returns an array of arrays containing each element of a hash and their indexes' do
      expect do
        hash.my_each_with_index { |el, i| puts el, i }
      end.to output("name\nJohn\n0\nlast\nDoe\n1\n").to_stdout
    end
  end

  describe 'my_select' do
    let(:my_arr) { [3, 6, 9, 5, 2] }
    it 'Iterate the array and apply the instruction in the block' do
      result = my_arr.my_select(&:even?)
      expect(result).to eql([6, 2])
    end

    it 'Returns the Enumerator if no block given' do
      expect(my_arr.my_select).to be_an Enumerator
    end

    it 'Return numbers divisible by 3' do
      result = my_arr.my_select { |el| (el % 3).zero? }
      expect(result).to eql([3, 6, 9])
    end
  end

  describe '#my_all?' do
    let(:my_arr) { [11, 2, 3, 56] }
    let(:str_arr) { %w[ant bear cat] }
    it 'Returns true if all the numbers are higher than 1' do
      result = my_arr.my_all? { |el| el > 1 }
      expect(result).to eql(true)
    end

    it 'Returns false if all the numbers are lower than 20' do
      result = my_arr.my_all? { |el| el < 20 }
      expect(result).to eql(false)
    end

    it 'Returns false if all the numbers are lower than 20' do
      result = [1, 2, 3, 2i].my_all?(Numeric)
      expect(result).to eql(true)
    end

    it 'Returns false if all the elements have a letter d' do
      result = str_arr.my_all?(/d/)
      expect(result).to eql(false)
    end
  end

  describe '#my_any?' do
    let(:my_arr) { [11, 2, 3, 56] }
    let(:str_arr) { %w[ant bear cat] }
    it 'returns true if any element is higher than 11' do
      expect(my_arr.my_any? { |el| el > 11 }).to eql(true)
    end

    it 'Return false if any of them are String' do
      expect(my_arr.my_any?(String)).to eql(false)
    end

    it 'Return true if any element has a letter r' do
      expect(str_arr.any?(/r/)).to eql(true)
    end
  end

  describe '#my_none?' do
    let(:my_arr) { [11, 2, 3, 56] }
    let(:str_arr) { %w[ant bear cat] }

    it 'returns true if no elements are higher than 11' do
      expect(my_arr.my_none? { |el| el > 11 }).to eql(false)
    end

    it 'returns true if no elements in the array are string' do
      expect(my_arr.my_none?(String)).to eql(true)
    end

    it 'returns true if no elements in the array contain said letter' do
      expect(str_arr.my_none?(/q/)).to eql(true)
    end
  end

  describe '#my_count' do
    let(:my_arr) { [11, 2, 3, 56] }

    it 'returns the amount of elements that are bigger than 11' do
      expect(my_arr.my_count { |el| el > 11 }).to eql(1)
    end

    it 'returns true if there are even elements in the array' do
      expect(my_arr.count(&:even?)).to eql(2)
    end

    it 'returns true if there are odd elements in the array' do
      expect(my_arr.count(&:odd?)).to eql(2)
    end
  end

  describe '#my_inject' do
    it 'multiplies the elements of the range by the next one in the range' do
      expect((5..10).my_inject(:*)).to eql(151_200)
    end

    it 'sums the elements of the range plus the next one in the range' do
      expect((5..10).my_inject { |sum, el| sum + el }).to eql(45)
    end

    it 'multiplies the elements of the range by the next one in the range and it multiplies the result by two' do
      expect((5..10).my_inject(2, :*)).to eql(302_400)
    end

    it 'multiplies the elements of the range by the next one in the range and it multiplies the result by three' do
      expect((5..10).my_inject(3) { |sum, el| sum * el }).to eql(453_600)
    end
  end
end
