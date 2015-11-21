module RepositoryCardHelper
  def repository_description(repository)
    if repository["description"]
      truncated_description(repository["description"])
    end
  end

  def truncated_description(description)
    truncate(emojified_description(description), length: 200)
  end

  def emojified_description(description)
    EmojiParser.detokenize(description)
  end
end
