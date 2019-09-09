module RequestSpecHelper
  def emulate_login(email, password)
    r = User.login(email, password)
    cookies['session_id'] = r.data.session_id
  end
end
