require 'spec_helper'

describe User, :type => :model do

#  before(:all) do
#    MembershipType.create(name: "Basic", monthlycost: 20 )
#    MembershipType.create(name: "Extra", monthlycost: 75 )
#    Discount.create(name: "Student", percent: 25 )
#    Discount.create(name: "Family1", percent: 50 )
#  end
#  after(:all) do
#    MembershipType.delete_all()
#    Discount.delete_all()
#  end
  
  
  
  before do
 #   pp(MembershipType.all)
    membertype =     MembershipType.create(name: "Basic", monthlycost: 20 )
    @user = User.new(name: "Example User", email: "user@example.com",
      street: "123 Example Way", city: "Exampleville",
      state: "EX", zip: "00000",
      membership_type: membertype, membership_date: Date.today(),
                     password: "foobar", password_confirmation: "foobar" )
  end

  subject { @user }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:password_digest) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:password_confirmation) }
  it { is_expected.to respond_to(:remember_token) }
  it { is_expected.to respond_to(:authenticate) }
  it { is_expected.to respond_to(:admin) }

  it { is_expected.to respond_to(:street) }
  it { is_expected.to respond_to(:city) }
  it { is_expected.to respond_to(:state) }
  it { is_expected.to respond_to(:zip) }

  it { is_expected.to respond_to(:membership_type)}
  it { is_expected.to respond_to(:membership_date)}
  it { is_expected.to respond_to(:discounts)}

  it { is_expected.to respond_to(:gnucash_id)}

  it { is_expected.to be_valid }
  it { is_expected.not_to be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it {is_expected.to be_admin }
  end
  
  describe "when name is not present" do
    before {@user.name = " "}
    it { is_expected.not_to be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " "}
    it { is_expected.not_to be_valid }
  end

  describe "when street is not present" do
    before { @user.street = " "}
    it { is_expected.not_to be_valid }
  end
  describe "when city is not present" do
    before { @user.city = " "}
    it { is_expected.not_to be_valid }
  end

  describe "when state is not present" do
    before { @user.state = " "}
    it { is_expected.not_to be_valid }
  end

  describe "when zip is not present" do
    before { @user.zip = " "}
    it { is_expected.not_to be_valid }
  end


  describe "when name is too long" do
    before {@user.name = "a" * 51 }
    it {is_expected.not_to be_valid }
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

    it {is_expected.not_to be_valid}
  end

  describe "when passwork is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it {is_expected.not_to be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = 'mismatch' }
    it { is_expected.not_to be_valid }
  end

  describe "return valie of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it {is_expected.to eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it {is_expected.not_to eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_falsey }
    end

    describe "with a password that's too short" do
      before { @user.password = @user.password_confirmation = "a" * 5 }
      it { is_expected.to be_invalid }
    end
  end

  describe "remember token" do
    before {@user.save}

    describe '#remember_token' do
      subject { super().remember_token }
      it { is_expected.not_to be_blank }
    end
  end

  describe "can compute cost" do
    describe '#cost' do
      subject { super().cost }
      it { is_expected.to eq(20) }
    end

    describe "with a discount" do
      before
    end
  end
end
