require "spec_helper"
#require File.dirname(__FILE__) + '/../spec_helper'


class Foo
  include ActionView::Helpers::SanitizeHelper
  include ActionView::Helpers::RawOutputHelper
  include MicropostsHelper
end

describe MicropostsHelper do

  before(:each) do
    @helper = Foo.new
  end

  it "should wrap text" do
    @helper.wrap( "a" * 240 ).should == "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&#8203;aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&#8203;aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&#8203;aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&#8203;aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&#8203;aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&#8203;aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&#8203;aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  end

  it "should wrap wordy text" do
    total = ""
    %w[ a b c d e f].each{ |item| total += item * 20 + " " }
    @helper.wrap( total ).should == "aaaaaaaaaaaaaaaaaaaa bbbbbbbbbbbbbbbbbbbb cccccccccccccccccccc dddddddddddddddddddd eeeeeeeeeeeeeeeeeeee ffffffffffffffffffff"
  end

  it "should not wrap short text" do
    desired = "brown fox"
    @helper.wrap( desired ).should == desired
  end
end
