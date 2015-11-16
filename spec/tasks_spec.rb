require 'spec_helper'

describe Capistrano::Jianliao do
  before(:each) do
    Rake::Task['load:defaults'].invoke
  end

  describe "before/after hooks" do
    it "invokes jianliao:deploy:updated after deploy:finishing" do
      Rake::Task['deploy:finishing'].execute
    end
  end
end
