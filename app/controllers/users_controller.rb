class UsersController < ApplicationController
  def new
  end

  def test
    render json: {"name": "Minh Toan"}
  end
end
