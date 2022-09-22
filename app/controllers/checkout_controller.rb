class CheckoutController < ApplicationController
    
    def create
        product = Product.find(params[:id])
        @session = Stripe::Checkout::Session.create({
            customer: current_user.stripe_customer_id,
            payment_method_types: ['card'],
            line_items: [
                price_data: {
                    unit_amount: product.price,
                    currency: "usd",
                    product_data: {
                        name: product.name,
                        description: 'test description',
                    }
                },
                quantity: 1
            ],
            mode: 'payment',
            success_url: root_url,
            cancel_url: root_url,
        })

        respond_to do |format|
            format.js
        end
    end
    
end