# Publishing
#   :published => boolean
#   :published_at => datetime:index
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

    # @model.publish
    # Skips Validations
    def publish
      migration_warning unless check_attr
      update_attribute(:published, 1)
      update_attribute(:published_at, Time.now) if published_at.nil?
    end

    # @model.unpublish
    # Skips Validations
    def unpublish
      migration_warning unless check_attr
      update_attribute(:published, 0)
    end

    # @model.publish_toggle
    def publish_toggle
      migration_warning unless check_attr
      published ?  unpublish : publish
    end

    # @model.publish_check
    # => true: 'published'
    # => false: 'unpublished'
    def publish_check
      migration_warning unless check_attr
      published ? 'published' : 'unpublished'
    end

    # @model.publish_link
    # => true: 'unpublish'
    # => false: 'publish'
    def publish_link
      migration_warning unless check_attr
      published ? 'unpublish' : 'publish'
    end

    # @model.published_date
    # => 00/00/0000 | month/day/year
    def publish_date
      migration_warning unless check_attr
      if published
        published_at.in_time_zone(ENV['DEFAULT_TIME_ZONE']).strftime('%D')
      else
        'draft'
      end
    end

    # @model.published_time
    # 12-hour Time
    # => 00:00 AM | PM
    def publish_time
      migration_warning unless check_attr
      if published
        published_at.in_time_zone(ENV['DEFAULT_TIME_ZONE']).strftime('%I:%M %p')
      else
        'draft'
      end
    end

    # @model.publish_status
    # => 'draft'
    # => 'published'
    # => 'editing'
    def publish_status
      if !published && published_at.presence
        'editing'
      elsif published && published_at.presence
        'published'
      else !published && published_at.nil?
        'draft'
      end
    end

    private

    def check_attr
      has_attribute?(:published) && has_attribute?(:published_at)
    end

    def migration_warning
      label = "[Publishing] Warning:"
      logger.warn "#{label} #{self.class.name.capitalize} Migrations Pending"
      logger.warn "#{label} #{self.class.name.capitalize} missing column :published" unless self.has_attribute?(:published)
      logger.warn "#{label} #{self.class.name.capitalize} missing column :published_at" unless self.has_attribute?(:published_at)
    end
  end
end
