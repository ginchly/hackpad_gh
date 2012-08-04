class MessagesController < ApplicationController
  def new
    @message = Message.new
  end


  def create
    @account_sid = 'ACbc47c1b666db123b39b219cadd30aee8'
    @auth_token = '716a6933314776c79a299de34e0b2d06'
    # set up a client
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)

    # shortcut to grab your account object (account_sid is inferred from the client's auth credentials)
    @account = @client.account 

    @users = User.all

    @users.each do |user|

        @phone_no = user.phone_no
        if @phone_no[0] != "+"
            @phone_no[0] = "+44"
        end

      @message = @account.sms.messages.create({:from => '+442033223736', :to => @phone_no, :body => 'test'})
    end
    flash[:success] = "Message Sent!"
    redirect_to root_path
  end

  def contacts
    @account_sid = 'ACbc47c1b666db123b39b219cadd30aee8'
    @auth_token = '716a6933314776c79a299de34e0b2d06'
    # set up a client
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)

    # shortcut to grab your account object (account_sid is inferred from the client's auth credentials)
    @account = @client.account 

    @users = User.all
    @to_number = current_user.phone_no
    if @to_number[0] != "+"
            @to_number[0] = "+44"
    end
    @body = ""

    @users.each do |user|
        @user_name = user.name
        @phone_no = user.phone_no
        if @phone_no[0] != "+"
            @phone_no[0] = "+44"
        end

        @body += @user_name + ' ' +  @phone_no + ' '

    end

    @message = @account.sms.messages.create({:from => '+442033223736', :to => @to_number, :body => @body})

    flash[:success] = "Contact List Sent!"
    redirect_to root_path
  end

end
