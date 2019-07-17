class Museum
  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits.push(exhibit)
  end

  def recommend_exhibits(patron)
    recommendations = []
    @exhibits.each do |exhibit|
      if patron.interests.include?(exhibit.name)
        recommendations << exhibit
      end
    end
    recommendations
  end

  def admit(patron)
    @patrons.push(patron)
  end

  def patrons_by_exhibit_interest
    interest_patron_hash = Hash.new {|h,k| h[k] = []}
    @exhibits.map do |exhibit|
      @patrons.map do |patron|
        if patron.interests.include?(exhibit.name)
          interest_patron_hash[exhibit] << patron
        else interest_patron_hash[exhibit]
        end
      end
    end
    interest_patron_hash
  end
end
