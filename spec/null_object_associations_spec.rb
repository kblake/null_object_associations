require_relative 'spec_helper'
require 'null_object_associations'

describe NullObjectAssociations do
  class MyNullObject
    include NullObjectAssociations

    has_many                :foos
    has_many                :bars, respond_to: [:pluck, :limit, :order, :completed]
    has_many                :blahs, respond_to: :any
    has_and_belongs_to_many :zibs, respond_to: [:pluck, :completed]
    has_one                 :baz
    belongs_to              :wut
  end

  describe MyNullObject do
    let(:null_object) { MyNullObject.new }

    describe "has_many" do
      it "#foos" do
        null_object.foos.must_be_empty
      end

      describe "#bars" do
        it "[]" do
          null_object.bars.must_be_empty
        end

        it "#pluck with argument" do
          null_object.bars.pluck(:plan).must_be_empty
        end

        it "#limit with argument" do
          null_object.bars.limit(10).must_be_empty
        end

        it "#order with argument" do
          null_object.bars.order('desc').must_be_empty
        end

        it "#completed" do
          null_object.bars.completed.must_be_empty
        end
      end

      describe "#blahs" do
        it "[]" do
          null_object.blahs.must_be_empty
        end

        describe "respond to anything" do
          ['any', 'thing', 'will', 'work'].each do |option|
            it "##{option}" do
              null_object.blahs.send(option).must_be_empty
            end
          end
        end
      end
    end

    describe "has_and_belongs_to_many" do
      describe "#zibs" do
        it "[]" do
          null_object.zibs.must_be_empty
        end

        it "#pluck" do
          null_object.zibs.pluck.must_be_empty
        end

        it "#completed" do
          null_object.zibs.completed.must_be_empty
        end
      end
    end

    describe "has_one" do
      it "nil for baz" do
        null_object.baz.must_be_nil
      end
    end

    describe "belongs_to" do
      it "nil for wut" do
        null_object.wut.must_be_nil
      end
    end
  end
end
