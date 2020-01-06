module CommentsHelper
  def size_comment
    Comment.all.size
  end
end
