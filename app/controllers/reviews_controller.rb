class ReviewsController < ApplicationController
    def create
        @product = Product.find(params[:product_id]) #query the product id (looking for the id of the product)        
        @review = Review.new review_params
        # this is creating a new review and review_params is a private method 
        # that's requiring the review and permits the body and rating of the review
        @review.product = @product # setting the id of the review to the product
        
        # so the ifelse statement is saying the if the review has been save, 
        # redirect to the product_path (which is the show.html.erb file)
        # else render the product_path (which is the show.html.erb file)
        if @review.save #saving the review 
            redirect_to product_path(@product) #this is the showpage for product show.html.erb
        else
            @reviews = @product.reviews.order(created_at: :desc)
            render 'products/show'
        end
    end 
    
    def destroy
        @review = Review.find(params[:id])
        @review.destroy
        redirect_to product_path(@review.product)
    end
    
    private 
    
    def review_params
        params.require(:review).permit(:body, :rating)
    end
    
end
