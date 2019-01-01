# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string
#  session_token   :string           not null
#

class User < ApplicationRecord
    validates_presence_of :username, :session_token
    validates :password_digest, presence: { message: 'Password cannot be blank' }
    validates :username, uniqueness: true
    validates :password, length: { minimum: 6, allow_nil: true }
    after_initialize :ensure_session_token

    attr_reader :password

    #FGRIPE

    has_many :subs,
        class_name: :Sub,
        primary_key: :id,
        foreign_key: :mod_id

    has_many :posts,
        class_name: :Post,
        primary_key: :id,
        foreign_key: :author_id

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && user.is_password?(password)
            return user
        else
            return nil 
        end
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save! 
        self.session_token
    end

    def is_password?(value)
        bcrypted_pw = BCrypt::Password.new(self.password_digest)
        bcrypted_pw.is_password?(value)
    end

    def password=(value)
        @password = value
        self.password_digest = BCrypt::Password.create(@password)
    end

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end
end
