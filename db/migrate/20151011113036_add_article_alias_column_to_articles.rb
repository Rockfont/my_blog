class AddArticleAliasColumnToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :article_alias, :string
  end
end
