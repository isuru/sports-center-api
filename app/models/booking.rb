class Booking < ApplicationRecord
	belongs_to :court

	validates :customer_id, :court_id, :booking_date, :slot_no, presence: true

	validate :valid_customer, if: Proc.new{ |booking| booking.customer_id.presence }
	validate :valid_booking_date, if: Proc.new{ |booking| booking.booking_date.presence }
	validate :valid_slot_no, if: Proc.new{ |booking| booking.slot_no.presence }

	before_create :set_booked_at
	before_update :set_updated_at

	# to represent starting number of hours in a day
	SLOTS = (0..23).to_a

	private

	def valid_customer
		# not in the scope to handle
		true
	end

	def valid_booking_date
		unless booking_date >= Date.today
			errors.add(:booking_date, "must be in the future")
		end
	end
	
	def valid_slot_no
		unless SLOTS.includes?(slot_no)
			errors.add(:slot_no, "is not valid")
		end
	end

	def set_booked_at
		booked_at = Time.current
	end

	def set_updated_at
		updated_at = Time.current
	end
end
