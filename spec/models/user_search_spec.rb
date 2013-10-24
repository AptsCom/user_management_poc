require 'spec_helper'

describe UserSearch do

	describe '.results_for' do
		before(:each) do
		  @user_1 = User.create!(:first_name => 'Dmitriy', :last_name => 'Moroz', :email => 'dmitriymoroz@yahoo.com')
		  @user_2 = User.create!(:first_name => 'Dmitriy', :last_name => 'Moroz', :email => 'dmoroz@apartments.com')
		  @user_3 = User.create!(:first_name => 'Jane', :last_name => 'Smith', :email => 'jsmith@yahoo.com')
		  @user_4 = User.create!(:first_name => 'John', :last_name => 'Wayne', :email => 'jwayne@yahoo.com')
		end

		it 'should search users by email' do
			@search = UserSearch.new({"email" => "dmitriymoroz"})
			@search.results_for().first.should == @user_1
			@search.results_for().first.email.should == 'dmitriymoroz@yahoo.com'
			@search.results_for().should have(1).items
		end
        
        it 'should search users by last name' do
			@search = UserSearch.new({"last_name" => "Moroz"})
			@search.results_for().last.should == @user_2
			@search.results_for().last.email.should == 'dmoroz@apartments.com'
			@search.results_for().should have(2).items
		end

        it 'should search users by multiple fields' do
			@search = UserSearch.new({"first_name" => "Dm", "last_name" => "Moroz"})
			@search.results_for().first.should == @user_1
			@search.results_for().last.should == @user_2
			@search.results_for().count.should == 2
		end

	end
end	