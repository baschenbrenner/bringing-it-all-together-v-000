class Dog
attr_accessor  :name, :breed, :id


    def initialize(input_hash)
      @id=input_hash[:id]
      @name=input_hash[:name]
      @breed=input_hash[:breed]
    end

    def self.create_table
      sql = <<-SQL
        CREATE TABLE IF NOT EXISTS dogs (id INTEGER PRIMARY KEY, name TEXT, breed TEXT)
        SQL

        DB[:conn].execute(sql)
    end

    def self.drop_table
      sql = <<-SQL
        DROP TABLE dogs
        SQL

        DB[:conn].execute(sql)
    end

    def save
      DB[:conn].execute("INSERT INTO dogs (name, breed) VALUES (?,?)", self.name, self.breed)
      self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
      self
    end

    def self.create(input)
      new_dog=Dog.new(input)
      new_dog.save
    end

end
