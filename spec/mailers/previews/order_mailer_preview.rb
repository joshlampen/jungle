# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def email_receipt
    OrderMailer.email_receipt(Order.last)
  end
end