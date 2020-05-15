class SubscribeToNewsletterService
  def initialize(user)
    @user = user
    @gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
    @audience_id = ENV['MAILCHIMP_AUDIENCE_ID']
    @member_id = Digest::MD5.hexdigest(user.email)
  end

  def call
    response = @gibbon.lists(@audience_id).members.retrieve(params: {"fields": "members.email_address"})
    if response
    else
      @gibbon.lists(@audience_id).members.create(
        body: {
          email_address: @user.email,
          status: "subscribed",
          merge_fields: {
            FNAME: @user.first_name,
            LNAME: @user.last_name
          }
        }
      )
    end
  end
end

