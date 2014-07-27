require 'spec_helper'

describe User do

  before do
    membertype = MembershipType.create(name: "Basic", monthlycost: 20 )
    @user = User.new(name: "Example User", email: "user@example.com",
      street: "123 Example Way", city: "Exampleville",
      state: "EX", zip: "00000",
      membership_type: membertype, membership_date: Date.today(),
                     password: "foobar", password_confirmation: "foobar" )
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }

  it { should respond_to(:street) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:zip) }

  it { should respond_to(:membership_type)}

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it {should be_admin }
  end
  
  describe "when name is not present" do
    before {@user.name = " "}
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " "}
    it { should_not be_valid }
  end

  describe "when street is not present" do
    before { @user.street = " "}
    it { should_not be_valid }
  end
  describe "when city is not present" do
    before { @user.city = " "}
    it { should_not be_valid }
  end

  describe "when state is not present" do
    before { @user.state = " "}
    it { should_not be_valid }
  end

  describe "when zip is not present" do
    before { @user.zip = " "}
    it { should_not be_valid }
  end


  describe "when name is too long" do
    before {@user.name = "a" * 51 }
    it {should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz_com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.slt@foo.jp a_b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it {should_not be_valid}
  end

  describe "when passwork is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it {should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = 'mismatch' }
    it { should_not be_valid }
  end

  describe "return valie of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it {should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it {should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end

    describe "with a password that's too short" do
      before { @user.password = @user.password_confirmation = "a" * 5 }
      it { should be_invalid }
    end
  end

  describe "remember token" do
    before {@user.save}
    its(:remember_token) { should_not be_blank }
  end
end
