module UsersHelper
  def select_sex
    User.sexes.keys
  end
end
