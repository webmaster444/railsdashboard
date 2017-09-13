class RegistrationsController < Devise::RegistrationsController
	skip_before_action :require_no_authentication, only: [:new, :create]

	def new	
		super				
	end

	def create
		@user = User.new(secure_params)	
        if @user.save
            redirect_to '/users', notice: "User succesfully created!" 
        else
            render :new
        end
    end

    private
    def secure_params
    	params.require(:user).permit!
  	end
    def permit!
      each_pair do |key, value|
        convert_hashes_to_parameters(key, value)
        self[key].permit! if self[key].respond_to? :permit!
      end

      @permitted = true
      self
    end
end
