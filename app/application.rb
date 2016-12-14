class Application

  @@items = ["Apples","Carrots","Pears"]

  @@cart = []

  def cart_contents
    if @@cart.empty?
      "Your cart is empty"
    else
      @@cart.join("\n")
    end
  end

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
    elsif req.path.match(/add?\S/)
      item = req.params.values.first
      if @@items.include?(item)
        @@cart << item
        resp.write "added Figs"
      else
        resp.write "We don't have that item"
      end
    else
      resp.write cart_contents
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
