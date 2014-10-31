class PaintingsController < ApplicationController
    # TO make sure not show users when user not logged in
  before_action :make_sure_logged_in
  def index
  	@paintings = Painting.all
  end
  
  private
    def make_sure_logged_in
      if !current_user 
        redirect_to new_sessions_path
      end
    end

end
