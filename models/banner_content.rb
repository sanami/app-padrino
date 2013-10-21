class BannerContent
  include Mongoid::Document
  include Mongoid::Timestamps

  # Validations
  validates :html_content, presence: true

  # Used in form select
  def banner_label
    html_content[0..100]
  end

  # Fields
  field :html_content, type: String
end
