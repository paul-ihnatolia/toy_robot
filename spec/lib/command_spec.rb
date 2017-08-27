require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require './lib/command'

describe Command do
  subject { described_class.new(command_string) }

  describe '#valid?' do
    context 'when command starts with one of available types' do
      let(:command_string) { 'PLACE 0,0,NORTH' }

      it { expect(subject.valid?).to be_truthy }
    end

    context 'when command starts with something else than one of available types' do
      let(:command_string) { 'ELSE' }
      
      it { expect(subject.valid?).to be_falsey }
    end
  end

  describe '#place?' do
    context 'when command starts with PLACE word' do
      let(:command_string) { 'PLACE 0,0,NORTH' }

      it { expect(subject.place?).to be_truthy }
    end

    context 'when command starts with something other' do
      let(:command_string) { 'REPORT' }

      it { expect(subject.place?).to be_falsey }
    end
  end

  describe '#get_position_x' do
    context 'when it has place type' do
      let(:command_string) { 'PLACE 1,2,NORTH' }
      
      it 'should return first number' do
        expect(subject.get_position_x).to eq(1)
      end
    end

    context 'when it has other type' do
      let(:command_string) { 'REPORT' }

      it 'should raise error' do
        expect { subject.get_position_x }.to raise_error(RuntimeError)
      end
    end
  end

  describe '#get_position_y' do
    context 'when it has place type' do
      let(:command_string) { 'PLACE 1,2,NORTH' }
      
      it 'should return last number' do
        expect(subject.get_position_y).to eq(2)
      end
    end

    context 'when it has other type' do
      let(:command_string) { 'REPORT' }

      it 'should raise error' do
        expect { subject.get_position_y }.to raise_error(RuntimeError)
      end
    end
  end

  describe '#get_facing' do
    context 'when it has place type' do
      let(:command_string) { 'PLACE 1,2,NORTH' }
      
      it 'should return word after last comma' do
        expect(subject.get_facing).to eq('NORTH')
      end
    end

    context 'when it has other type' do
      let(:command_string) { 'REPORT' }

      it 'should raise error' do
        expect { subject.get_facing }.to raise_error(RuntimeError)
      end
    end
  end

  describe '#move?' do
    context 'when command starts with MOVE word' do
      let(:command_string) { 'MOVE' }

      it { expect(subject.move?).to be_truthy }
    end

    context 'when command starts with something other' do
      let(:command_string) { 'REPORT' }

      it  { expect(subject.move?).to be_falsey }
    end
  end

  describe '#left?' do
    context 'when command starts with LEFT word' do
      let(:command_string) { 'LEFT' }

      it { expect(subject.left?).to be_truthy }
    end

    context 'when command starts with something other' do
      let(:command_string) { 'REPORT' }

      it { expect(subject.left?).to be_falsey }
    end
  end

  describe '#right?' do
    context 'when command starts with RIGHT word' do
      let(:command_string) { 'RIGHT' }

      it { expect(subject.right?).to be_truthy }
    end

    context 'when command starts with something other' do
      let(:command_string) { 'REPORT' }

      it { expect(subject.right?).to be_falsey }
    end
  end

  describe '#report?' do
    context 'when command starts with REPORT word' do
      let(:command_string) { 'REPORT' }

      it { expect(subject.report?).to be_truthy }
    end

    context 'when command starts with something other' do
      let(:command_string) { 'ELSE' }

      it { expect(subject.report?).to be_falsey }
    end    
  end
end
