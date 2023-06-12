class UserSerializer
  def initialize(user_object)
    @user = user_object
  end

  def serialize
    {
      data:
      {
        type: "users",
        id: @user.id,
        attributes:
        {
          email: @user.email,
          api_key: @user.api_key
        }
      }
    }
  end

end