class Payment

  Stripe.api_key = "sk_test_UADoCBWZKVi7r5QDrEmZ2ac6"

  def pay

    begin
      #customer = create
      customer = Stripe::Customer.retrieve("cus_4l05k2L9VGkPYk")
      subscription = customer.subscriptions.create(:plan => "TestS1")
      debugger
      customer
      # Use Stripe's bindings...
    rescue Stripe::CardError => e
      # Since it's a decline, Stripe::CardError will be caught
      body = e.json_body
      err  = body[:error]

      puts "Status is: #{e.http_status}"
      puts "Type is: #{err[:type]}"
      puts "Code is: #{err[:code]}"
      # param is '' in this case
      puts "Param is: #{err[:param]}"
      puts "Message is: #{err[:message]}"
    rescue Stripe::InvalidRequestError => e
      # Invalid parameters were supplied to Stripe's API
    rescue Stripe::AuthenticationError => e
      # Authentication with Stripe's API failed
      # (maybe you changed API keys recently)
    rescue Stripe::APIConnectionError => e
      # Network communication with Stripe failed
    rescue Stripe::StripeError => e
      # Display a very generic error to the user, and maybe send
      # yourself an email
    rescue => e
      # Something else happened, completely unrelated to Stripe
    end
  end

  def create
    Stripe::Customer.create(
      description: "Jack Jackson",
      email: 'a.karimzadeh@gmail.com',
      card: { 
        number: 4242424242424242,
        exp_month: 12,
        exp_year: 2015,
        cvc: 123
      }
    )
  end

end
