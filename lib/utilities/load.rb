class Load
  def initialize(file_path, loader_method)
    @file_path = file_path
    @loader_method = loader_method
  end

  def execute
    return [] unless File.exist?(@file_path)

    json_data = JSON.parse(File.read(@file_path))
    json_data.map { |data| send(@loader_method, data) }
  end

  private

  def load_games_from_json(data)
    Game.new(data['publish_date'], multiplayer: data['multiplayer'], last_played_at: data['last_played_at'],
                                   id: data['id'])
  end

  def load_authors_from_json(data)
    Author.new(
      data['first_name'],
      data['last_name'],
      Item.new(data['items']['publish_date'], archived: data['items']['archived'], id: data['items']['id']),
      id: data['id']
    )
  end

  def load_books_from_json(data)
    Book.new(
      data['publish_date'],
      data['archived'],
      data['publisher'],
      data['cover_state'],
      id: data['id']
    )
  end

  def load_labels_from_json(data)
    Label.new(
      data['title'],
      data['color'],
      Item.new(data['items']['publish_date'], archived: data['items']['archived'], id: data['items']['id']),
      id: data['id']
    )
  end
end
