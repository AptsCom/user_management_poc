require 'spec_helper'

describe UserSearch do

	describe '.results_for' do
		before(:each) do
		  @user_1 = User.create!(:first_name => 'Dmitriy', :last_name => 'Moroz', :email => 'dmitriymoroz@yahoo.com')
		  @user_2 = User.create!(:first_name => 'Dmitriy', :last_name => 'Moroz', :email => 'dmoroz@apartments.com')
		  @user_3 = User.create!(:first_name => 'Jane', :last_name => 'Smith', :email => 'jsmith@yahoo.com')
		  @user_4 = User.create!(:first_name => 'John', :last_name => 'Wayne', :email => 'jwayne@yahoo.com')
		end

		it 'searches another way' do
			#criteria = double("criteria")
			#@criteria.should_receive(:where).with('dmitriymoroz')
			@search = UserSearch.new('dmitriymoroz')
			@search.results_for().first.should == @user_1
		end

		it 'should search users by email' do
			@search = UserSearch.new('dmitriymoroz')
			@search.results_for().first.should == @user_1
			@search.results_for().first.email.should == 'dmitriymoroz@yahoo.com'
			@search.results_for().should have(1).items
		end
        
        it 'should search users by last name' do
			@search = UserSearch.new('moroz')
			@search.results_for().last.should == @user_2
			@search.results_for().last.email.should == 'dmoroz@apartments.com'
			@search.results_for().should have(2).items
		end

        it 'should search users by multiple fields' do
			@search = UserSearch.new('e')
			@search.results_for().first.should == @user_2
			@search.results_for().last.should == @user_4
			@search.results_for().count.should == 3
		end

	end
end	