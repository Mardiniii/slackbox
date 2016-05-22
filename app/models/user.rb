# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  slack_id               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  username               :string
#  image                  :string
#  team_id                :integer
#

class User < ActiveRecord::Base
  belongs_to :team

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         omniauth_providers: [:slack]

  def self.from_omniauth(auth)
    where(uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.image = auth.info.image # assuming the user model has an image
      user.username = auth.info.user # assuming the user model has a username
      user.provider = auth.provider
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.slack_data"] && session["devise.slack_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.associate_or_create_team(auth, user)
    team = Team.find_by(slack_id: auth.info.team_id)
    if team
      user.team_id = team.id
      team.update(name: auth.info.team) if team.name.nil?
    else
      team = Team.create(name: auth.info.team, domain: auth.info.team_domain, slack_id: auth.info.team_id)
      user.team_id = team.id
    end
  end

end
