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
    expensive_exhibit = recommend_exhibits(patron).max_by {|e| e.cost}
    amt = expensive_exhibit.cost
    if patron.spending_money >= amt
      patron.charge(amt)
      @patrons.push(patron)
    end
  end

  def patrons_by_exhibit_interest
    interest_patron_hash = Hash.new {|h,k| h[k] = []}
    @exhibits.map do |exhibit|
      @patrons.map do |patron|
        if patron.interests.include?(exhibit.name) && patron.spending_money >= exhibit.cost
          interest_patron_hash[exhibit] << patron
        else interest_patron_hash[exhibit]
        end
      end
    end
    interest_patron_hash
  end
end
