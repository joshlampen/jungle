class OrderMailer < ApplicationMailer
  default from: "no-reply@jungle.com"

  def email_receipt(order)
    @order = order
    mail(to: @order.email, subject: "Jungle - Receipt for Order ##{@order.id}")
    # see preview at http://localhost:3000/letter_opener
  end
end
