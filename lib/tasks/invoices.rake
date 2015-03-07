namespace :invoices do
  task :compile => :environment do
    User.all.each do |u|
      tr = u.transactions.where('created_at <  ?',Time.now)
      sum = tr.sum(:value)
      i = Invoice.new
      i.value = sum
      i.currency = "usd"
      i.user_id = u.id
      i.invoice_status = "unpaid"
      i.start_date = Time.now - 7.days
      i.end_date = Time.now
      puts i
      i.save
    end
  end
end
