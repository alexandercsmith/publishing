module Publishing
  extend ActiveSupport::Concern
  included do
    # Model.is_published
    scope :is_published,   -> { where(published: 1) }
    # Model.is_unpublished
    scope :is_unpublished, -> { where(published: 0) }

    # Model.all.published_asc
    scope :published_asc,  -> { order(published_at: :asc) }
    # Model.all.published_desc
    scope :published_desc, -> { order(published_at: :desc) }

    def publish
      update_attribute(:published, 1)
      update_attribute(:published_at, Time.now) if published_at.nil?
    end

    def unpublish
      update_attribute(:published, 0)
    end

    # @model.publish_toggle
    def publish_toggle
      if published
        unpublish
      else
        publish
      end
    end

    # @model.published_check
    def published_check
      published ? 'published' : 'unpublished'
    end

    # @model.published_date
    # => Month 00, 0000
    def published_date
      published ? published_at.strftime('%B %e, %Y') : 'DRAFT'
    end

    # @model.published_time
    # => 0:00 AM | PM
    def published_time
      published ? published_at.strftime('%I:%M %p') : 'DRAFT'
    end
  end
  class_methods do
  end
end
