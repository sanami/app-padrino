class BannerSlot
  include Mongoid::Document
  include Mongoid::Timestamps

  # Relations
  has_and_belongs_to_many :banner_contents, index: true, inverse_of: nil

  # Scopes
  scope :with_content, -> { where(:banner_content_ids.not => { "$size" => 0 }) }
  scope :by_names, ->(slot_names) { where(:slot_name.in => slot_names) }
  scope :by_time, ->(time) do
    where({
            '$and' => [
              { '$or' => [{ valid_from: nil }, { valid_from: { '$lte' => time } }] },
              { '$or' => [{ valid_till: nil }, { valid_till: { '$gte' => time } }] }
            ]
          })
  end

  # Validations
  validates :slot_name, presence: true, uniqueness: true, format: /\A[a-z\d]+\Z/
  validates :valid_from, :valid_till, inclusion: 0..23, allow_nil: true

  # Find not empty slots valid for this time
  def self.valid_slots(slot_names, time)
    by_names(slot_names).by_time(time).with_content
  end

  # Get random banner content
  def self.random_banner(slot_name, time = Time.now)
    slot = valid_slots(slot_name.split(','), time.hour).first

    if slot
      slot.banner_contents.find(slot.banner_content_ids.sample)
    end
  end

  # Fields
  field :slot_name, type: String
  field :valid_from, type: Integer
  field :valid_till, type: Integer

  # Fields
  index slot_name: 1
end
