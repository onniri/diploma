class AddFtIndexToUsers < ActiveRecord::Migration
  def change
    execute "create index users_ft_first_name_en on users using gin(to_tsvector('english',first_name))"
    execute "create index users_ft_last_name_en on users using gin(to_tsvector('english',last_name))"
    execute "create index users_ft_first_name_ru on users using gin(to_tsvector('russian',first_name))"
    execute "create index users_ft_last_name_ru on users using gin(to_tsvector('russian',last_name))"
  end
end
