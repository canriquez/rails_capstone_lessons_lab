class TransactionsController < ApplicationController
    def index
    end

    def new
        @transaction = Transaction.new
    end
    
end