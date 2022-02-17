class AppData < ActiveInteraction::Base
  object :app, class: App

  validates :app,  presence: true

  def execute
    App.transaction do
      pages = Pages.where(pages: { app_id: app.id })
    end
  end
end
