class Api::V1::BookingsController < ApplicationController

	# Search for Available Bookings
	#
	# GET /api/v1/bookings/search
	# Params: [type_id, booking_date, from(hour), to(hour)]
	#
	def search
		# booking_date validation
		booking_date = Date.parse(params[:booking_date]) rescue nil

		if booking_date.blank?
			render json: { status: 'error', message: 'Missing booking_date or invalid format. Please use: YYYY-MM-DD' } and return
		elsif booking_date < Date.current
			render json: { status: 'error', message: 'Invalid booking_date'} and return
		end

		# court_type validation
		type_id = params[:type_id]

		if type_id.blank?
			render json: { status: 'error', message: 'Missing court type_id'} and return
		elsif Court::TYPES.has_key?(type_id.to_i)==false
			render json: { status: 'error', message: 'Invalid court type_id'} and return
		else
			type_id = type_id.to_i
		end
		
		from_hour = (booking_date > Date.current) ? (params[:from] || 0) : (params[:from] || (Time.current.hour+1))
		to_hour = params[:to] || 23

		query = <<-SQL
			SELECT 	A.id court_id, A.name, B.slot_no 
			FROM 		(SELECT id, name FROM courts WHERE type_id = :type_id) A, 
							(SELECT * FROM generate_series(#{from_hour},#{to_hour}) slots(slot_no)) B;
		SQL

		all_slots = ActiveRecord::Base.connection.exec_query(ApplicationRecord.sanitize_sql([query, { type_id: type_id }])).rows.sort

		allocated_slots = Booking.allocated.joins(:court)
															.select("bookings.id, bookings.booking_date, bookings.court_id, courts.name, bookings.slot_no, bookings.customer_id")
															.where("bookings.booking_date = ? AND type_id = ?", booking_date.strftime('%Y-%m-%d'), type_id)
															.order("bookings.booking_date, bookings.court_id, courts.name, bookings.slot_no").map{|b| [b.court_id, b.name, b.slot_no]}

		available_slots = all_slots - allocated_slots


		render json: { staus: 'ok', results: { 
																	booking_date: booking_date,
																	from: from_hour,
																	to: to_hour,
																	type: Court::TYPES[type_id],
																	slots_count: available_slots.size,
																	slots: available_slots.map{|x,y,z| {:court_id => x, :court_name => y, :hour => z}}
																} 
								 }
	end

	# Create New Booking
	#
	# POST /api/v1/bookings/new
	# Params: [customer_id, booking_date, court_id, hour]
	#
	def create
		booking = Booking.new
		booking.customer_id = params[:customer_id]
		booking.booking_date = params[:booking_date]
		booking.court_id = params[:court_id]
		booking.slot_no = params[:hour]

		if booking.save
			render json: { status: 'ok', message: 'booking successful', court: {id: booking.court_id, name: booking.court.name, hour: booking.slot_no } }
		else
			render json: { status: 'error', messages: booking.errors.messages }
		end
	end

	# Update Booking
	#
	# PATCH /api/v1/bookings/:booking_id/update
	# Params: [booking_id, notes]
	#
	def update
		booking = Booking.find_by(id: params[:booking_id])

		if booking.present?
			booking.notes = params[:notes]

			if booking.save
				render json: { status: 'ok', message: 'booking update successful' }
			else 
				render json: { status: 'error', messages: booking.errors.messages }
			end
		else
			render json: { status: 'error', messages: 'couldn\'t find booking with booking_id' }	
		end
	end

	# Cancel Booking
	#
	# PATCH  /api/v1/bookings/:booking_id/cancel
	# Params: [booking_id, cancelled_reason]
	#
	def cancel
		booking = Booking.find_by(id: params[:booking_id])

		if booking.present?
			booking.cancelled_at = Time.current
			booking.cancelled_reason = params[:cancelled_reason]

			if booking.save
				render json: { status: 'ok', message: 'booking cancelled successfully' }
			else 
				render json: { status: 'error', messages: booking.errors.messages }
			end
		else
			render json: { status: 'error', messages: 'couldn\'t find booking with booking_id' }	
		end
	end
end