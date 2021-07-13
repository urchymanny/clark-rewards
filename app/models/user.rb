class User < ApplicationRecord
    has_secure_password

    validates :password,
              :password_confirmation, presence: true, on: :update, allow_blank: true

    validates :email, uniqueness: true

    after
    before_validation :generate_recommendation_id

    def generate_refferal_id
			begin
        self.ref_id = SecureRandom.uuid.gsub("-", "").hex.to_s[1...6]
      end while self.class.exists?(ref_id: ref_id)
			# generate random recommendation reference ID, confirm if it already exists
    end
end
