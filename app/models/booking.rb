class Booking < ApplicationRecord
	belongs_to :court

	validates :customer_id, :court_id, :booking_date, :slot_no, presence: true
	validates_uniqueness_of :court_id, scope: [:booking_date, :slot_no], message: "the court is already booked"

	validate :valid_customer, if: Proc.new{ |booking| booking.customer_id.presence }
	validate :valid_booking_date, if: Proc.new{ |booking| booking.booking_date.presence }
	validate :valid_slot_no, if: Proc.new{ |booking| booking.slot_no.presence }

	before_create :set_booked_at
	before_update :set_updated_at

	scope :allocated, -> { where("booking_date >= ? AND cancelled_at IS NULL", Date.current) }

	# to represent starting number of hours in a day
	SLOTS = (0..23).to_a

	private

	def valid_customer
		# not in the scope to handle
		true
	end

	def valid_booking_date
		unless booking_date >= Date.current
			errors.add(:booking_date, "must be in the future")
		end
	end
	
	def valid_slot_no
		unless SLOTS.include?(slot_no)
			errors.add(:slot_no, "is not valid")
		end
	end

	def set_booked_at
		self.booked_at = Time.current
	end

	def set_updated_at
		self.updated_at = Time.current
	end
end
