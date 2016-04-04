Rails.configuration.stripe = {
    :publishable_key => 'pk_test_DoMFtdJPz48E2H26940WhSra',
    :secret_key => 'sk_test_ovEdCzqgeM5MehihqEBCFt58'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]