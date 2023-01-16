class Court < ApplicationRecord
	has_many :bookings

	validates :name, :type_id, presence: true
	validate :type_id_availability, if: Proc.new{ |court| court.type_id.presence }

	TYPES = {
						1 => 'tennis', 
						2	=> 'basketball', 
						3	=> 'football', 
						4 => 'volleyball'
					}


	private

	def valid_type?
		TYPES.has_key?(type_id)
	end

	def type_id_availability
		unless valid_type?
			errors.add(:type_id, "not a supported type")
		end
	end
end
