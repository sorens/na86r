FactoryGirl.define do
	sequence( :password )					{ |n| "abc123" }
	sequence( :email )						{ |n| "email@example.com" }

	factory :beta_key do
		sequence( :key )					{ |n| "abcdef_#{n}" }
		active								1

		trait :disabled do
			active							0
		end

		trait :assigned do
			active							3
			activated_at					{ Time.now }
			assigned_to						email
		end

		trait :assigned_disabled do
			active							2
			activated_at					{ Time.now }
			assigned_to						email
		end
	end

end