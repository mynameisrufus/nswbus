# encoding: UTF-8

module TruncateTable
  module Base
    def truncate
      connection.execute "TRUNCATE TABLE #{table_name};"
      nil
    end
  end
end

ActiveRecord::Base.send :extend, TruncateTable::Base
