module RepositoryCardHelper
  def repository_description(repository)
    auto_link truncate(emojified_description(repository), length: 60)
  end

  def emojified_description(repository)
    EmojiParser.detokenize(repository["description"])
  end
end
