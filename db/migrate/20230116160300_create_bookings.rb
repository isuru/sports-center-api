class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.integer     :customer_id
      t.integer     :court_id
      t.date        :booking_date
      t.integer     :slot_no
      t.text        :notes
      t.datetime    :booked_at
      t.datetime    :updated_at
      t.datetime    :cancelled_at
      t.string      :cancelled_reason
    end
  end
end
