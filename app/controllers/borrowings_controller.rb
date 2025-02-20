class BorrowingsController < ApplicationController
  before_action :set_book, only: %i[new create return]
  
  def new
    @borrowing = @book.borrowings.new
  end

  def create
    if @book.available?
      @borrowing = @book.borrowings.create(borrowing_params.merge(borrowed_at: Time.current))

      if @borrowing.persisted?
        @book.update(status: 'borrowed')
        redirect_to @book, notice: 'Book was successfully borrowed.'
      else
        render :new, alert: 'Failed to borrow the book.'
      end
    else
      redirect_to @book, alert: 'Book is already borrowed.'
    end
  end

  def return
    @borrowing = @book.borrowings.last

    if @borrowing&.active?
      @borrowing.update(returned_at: Time.current)
      @book.update(status: 'available')
      redirect_to @book, notice: 'Book was successfully returned.'
    else
      redirect_to @book, alert: 'No active borrowing found for this book.'
    end
  end

  def history
    @borrowings = Borrowing.where(borrower_name: params[:name])
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to books_path, alert: 'Book not found.'
  end

  def borrowing_params
    params.require(:borrowing).permit(:borrower_name)
  end
end
