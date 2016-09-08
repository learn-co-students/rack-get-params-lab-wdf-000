class Application
  @@cart = []
  @@items = ["Apples","Carrots","Pears"]

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
      if @@cart.empty? == false
        @@cart.each do |items|
          resp.write "#{items}\n"
        end
      else
        resp.write "Your cart is empty"
      end
    elsif req.path.match(/add/)
      search_term = req.params["item"]
      if @@items.include?(search_term)
        resp.write "#{search_term} is one of our items\n"
        resp.write "added #{search_term}"
        @@cart << search_term
      else
        resp.write "Couldn't find #{search_term}\n"
        resp.write "We don't have that item"
      end
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
end
