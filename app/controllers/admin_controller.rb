class AdminController < Super::ApplicationController
  before_action :reset_database_every_five_minutes

  def reset_database_every_five_minutes
    ActiveRecord::Base.transaction do
      recent_reset = Reset.last
      if recent_reset && recent_reset.created_at > 5.minutes.ago
        break
      end

      Reset.create!

      if recent_reset
        Reset.where("id < ?", recent_reset.id - 8).delete_all
      end

      ActiveRecord::Base.connection.truncate_tables("favorite_things", "members", "ships")
      ActiveRecord::Base.connection.execute("ALTER SEQUENCE favorite_things_id_seq RESTART WITH 1;")
      ActiveRecord::Base.connection.execute("ALTER SEQUENCE members_id_seq RESTART WITH 1;")
      ActiveRecord::Base.connection.execute("ALTER SEQUENCE ships_id_seq RESTART WITH 1;")

      StarfleetSeeder.seed(verbose: false)
    end
  end
end
