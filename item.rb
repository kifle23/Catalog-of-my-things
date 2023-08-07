class Item
  attr_accessor :publish_date, :archived, :authors
  attr_reader :id

  def initialize(publish_date, archived: false)
    @id = Random.rand(1..1000) # Guys, I have modified id because we need to have an id value generated randomly for each item created
    @publish_date = publish_date
    @archived = archived
    @authors = []
  end

  def can_be_archived?
    return true if @publish_date > 10
  end

  def move_to_archive
    @archived = true if can_be_archived? == true
  end

  def add_author(author)
    @authors << author
    author.items << self unless author.items.include?(self)
  end
end
