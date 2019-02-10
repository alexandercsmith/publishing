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

    # @model.publish_check
    # => true: 'published'
    # => false: 'unpublished'
    def publish_check
      published ? 'published' : 'unpublished'
    end

    # @model.publish_link
    # => true: 'unpublish'
    # => false: 'publish'
    def publish_link
      published ? 'unpublish' : 'publish'
    end

    # @model.published_date
    # => Month 00, 0000
    # => i.e. January 1, 2000
    def publish_date
      published ? published_at.strftime('%B %e, %Y') : 'DRAFT'
    end

    # @model.published_time
    # => 00:00 AM | PM
    # => i.e. 4:00 AM
    def publish_time
      published ? published_at.strftime('%I:%M %p') : 'DRAFT'
    end
  end
  class_methods do
  end
end
