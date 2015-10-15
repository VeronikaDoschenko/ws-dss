class AddFormatGraph < ActiveRecord::Migration
  disable_ddl_transaction!
  def change
    execute "ALTER TYPE format_type ADD VALUE 'graph';"
  end
end
