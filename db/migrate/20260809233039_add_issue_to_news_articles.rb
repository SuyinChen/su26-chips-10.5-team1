# frozen_string_literal: true

class AddIssueToNewsArticles < ActiveRecord::Migration[7.2]
  def change
    add_column :news_items, :issue, :string
  end
end
