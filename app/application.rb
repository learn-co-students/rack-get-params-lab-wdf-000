require 'pry'

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
      resp.write handle_cart_search

    elsif req.path.match(/add/)
      item = req.params["item"]
      resp.write add_to_cart(item)
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

  def handle_cart_search
    if @@cart.length != 0
      @@cart.collect do |item|
        item
      end.join("\n")
    else
      return "Your cart is empty."
    end
  end

  def add_to_cart(item)
    if !@@items.include?(item)
      return "We don't have that item"
    else
      @@cart << item
      return "added #{item} to your cart!"
    end
  end

end
