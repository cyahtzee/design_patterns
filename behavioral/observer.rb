class Observer
  def update
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class Message
  attr_reader :title, :content
  attr_accessor :observers

  def initialize(title, content)
    @title = title
    @content = content
    @observers = []
  end

  def add_observer(observer)
    observers << observer
  end

  def remove_observer(observer)
    observers.delete(observer)
  end

  def update(new_content)
    @content = new_content
    notify_observers
  end

  private

  def notify_observers
    observers.each { |observer| observer.update(self) }
  end
end

class DisplayObserver < Observer
  def update(blog_post)
    { title: blog_post.title, content: blog_post.content}
  end
end

class EmailObserver < Observer
  def update(blog_post)
    puts "send an email that the object was changed #{blog_post.title}"
  end
end

message = Message.new('Tile', 'Content')
display_observer = DisplayObserver.new
email_observer = EmailObserver.new

message.add_observer(display_observer)
message.add_observer(email_observer)
message.update('Notify observers that message was updated')
