class AddFormatForWsMethodOutput < ActiveRecord::Migration
  def change
    execute "CREATE TYPE format_type AS ENUM ('text', 'latex');"
    add_column :ws_methods, :format_output, "format_type", :default => 'text'
  end
end
