require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require './lib/toy_robot'

describe ToyRobot do
  let(:x_dimension_limit) { 4 }
  let(:y_dimension_limit) { 4 }
  let(:position_x)        { 2 }
  let(:position_y)        { 2 }
  let(:facing)            { 'NORTH' }

  subject { described_class.new(x_dimension_limit, y_dimension_limit) }

  it 'is not activated by default' do
    expect(subject.activated?).to be_falsey
  end

  describe '#activate!' do
    it 'should activate robot' do
      subject.activate!

      expect(subject.activated?).to be_truthy
    end
  end

  describe '#set_positions' do
    context 'when positions are wrong' do
      let(:position_x) { -1 }
      let(:position_y) { 10 }
      it 'should raise an erorr' do
        expect { subject.set_positions(position_x, position_y) }.to raise_error(ArgumentError)
      end
    end

    context 'when positions are correct' do
      let(:position_x) { 2 }
      let(:position_y) { 2 }

      it 'assigns them' do
        subject.set_positions(position_x, position_y)

        expect(subject.position_x).to eq(2)
        expect(subject.position_y).to eq(2)
      end
    end
  end

  describe '#get_printable' do
    before do
      subject.set_positions(position_x, position_y)
      subject.set_facing(facing)
    end
    
    it 'should return object parameters' do
      expect(subject.get_printable).to eq('2,2,NORTH')
    end
  end

  describe '#move' do
    before do
      subject.set_positions(position_x, position_y)
      subject.set_facing(facing)
      subject.move
    end

    context 'when facing is NORTH' do
      let(:facing) { 'NORTH' }

      context 'and final position is in the permitted range' do
        it 'increase the position_y by 1' do
          expect(subject.position_y).to eq(3)
        end
      end

      context 'and final position is noot in the permitted range' do
        let(:position_y) { 3 }

        it 'does nothing' do
          expect(subject.position_y).to eq(3)
        end
      end
    end

    context 'when facing is EAST' do
      let(:facing) { 'EAST' }

      context 'and final position is in the permitted range' do
        it 'increase the position_x by 1' do
          expect(subject.position_x).to eq(3)
        end
      end

      context 'and final position is not in the permitted range' do
        let(:position_x) { 3 }

        it 'does nothing' do
          expect(subject.position_x).to eq(3)
        end
      end
    end

    context 'when facing is SOUTH' do
      let(:facing) { 'SOUTH' }

      context 'and final position is in the permitted range' do
        it 'decreases the position_y by 1' do
          expect(subject.position_y).to eq(1)
        end
      end

      context 'and final position is not in the permitted range' do
        let(:position_y) { 0 }

        it 'does nothing' do
          expect(subject.position_y).to eq(0)
        end
      end
    end

    context 'when facing is WEST' do
      let(:facing) { 'WEST' }

      context 'and final position is in the permitted range' do
        it 'decreases the position_x by 1' do
          expect(subject.position_x).to eq(1)
        end
      end

      context 'and final position is not in the permitted range' do
        let(:position_x) { 0 }

        it 'does nothing' do
          expect(subject.position_x).to eq(0)
        end
      end
    end
  end

  describe '#rotate_right' do
    let(:facing) { 'WEST' }

    before do
      subject.set_positions(position_x, position_y)
      subject.set_facing(facing)
      subject.rotate_right
    end

    it 'changes facing' do
      expect(subject.facing).to eq('NORTH')
    end
  end

  describe '#rotate_left' do
    let(:facing) { 'NORTH' }

    before do
      subject.set_positions(position_x, position_y)
      subject.set_facing(facing)
      subject.rotate_left
    end

    it 'changes facing' do
      expect(subject.facing).to eq('WEST')
    end
  end
end
