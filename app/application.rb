class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart == []
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
        resp.write "#{item}\n"
        end
      end
    elsif req.path.match(/add/)
      item_to_be_added = req.params["item"]
      resp.write handle_add(item_to_be_added)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def handle_add(item_to_be_added)
    if @@items.include?(item_to_be_added)
      @@cart << item_to_be_added
      return "added #{item_to_be_added}"
    else
      return "We don't have that item"
    end
  end
end
