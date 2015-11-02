require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "signup page" do

    before { visit new_user_registration_path }

    it { should have_selector('h2', text: 'Sign up') }
    #it { should have_selector('title', text: 'Sign up') }
  end
end
