class User < ApplicationRecord
  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  PASSWORD_FORMAT = /\A[a-zA-Z0-9_-]{9,}\Z/
  has_many :rooms, through: :user_rooms
  has_many :msgs
  has_many :unread_msgs

  attr_accessor :session_id

  validates :name, presence: true

  validates :email,
    presence: true,
    format: EMAIL_FORMAT,
    uniqueness: true


  def self.register(name, email, password)
    password_errs = validate_password(password)
    if !password_errs.empty?
      return Result.new(password_errs)
    end

    user = User.new(name: name, email: email, hashed_password: hash(password))
    if user.save
      return Result.new([], user)
    else
      return Result.new(user.errors.full_messages)
    end
  end

  def self.login(email, password)
    user = User.find_by(
      email: email,
      hashed_password: hash(password)
    )
    if user
      session_id = SecureRandom.uuid
      user.session_id = session_id
      r = SessionStorage.set(session_id, user.id)
      if !r.success?
        return Result.new(["セッション情報の保存に失敗しました"])
      end
      return Result.new([], user)
    end

    return Result.new(["emailかパスワードが間違っています"])
  end

  private

  def self.validate_password(password)
    errs = []

    if password.nil? || password == ""
      errs << "パスワードは必須です"
      return errs
    end

    has_char = !password.index(/[a-zA-z]/).nil?
    has_num = !password.index(/[0-9]/).nil?
    has_sym = !password.index(/[_-]/).nil?
    if !PASSWORD_FORMAT.match?(password) || !has_char || !has_num || !has_sym
      errs <<
        "パスワードは9文字以上で、英字, 数字、記号(-か_)をそれぞれ１つ以上含む必要があります"
    end

    return errs
  end

  def self.hash(password)
    return Digest::SHA256.hexdigest(password)
  end
end
