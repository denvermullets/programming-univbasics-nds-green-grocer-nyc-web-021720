def find_item_by_name_in_collection(name, collection)
  
  # searches for #{name} in array of hashes and immediately returns hash
  # once found, only returns 1st found option 
  
  search_index = 0 
    while search_index < collection.count do 
      search_key = collection[search_index]
      if search_key[:item] == name
        result = search_key
        return result   # // doing hard return to break loop and avoid result == nil 
      else 
        result = nil 
      end
      search_index += 1 
    end 
end

def consolidate_cart(cart)
  
  # :item => AVACADO, :price=>32, :clearance=>true, :count=>2
  # !! method updates quantity of cart to remove duplicates
  
  updated_cart = []
  cart_index = 0 
    while cart_index < cart.count do 
      item = find_item_by_name_in_collection(cart[cart_index][:item], updated_cart)
      if item 
        item[:count] += 1 
      else 
        #item not found in array, so add to new array w/key // value of 1 
        hash_mod = cart[cart_index]
        hash_mod[:count] = 1 
        updated_cart << hash_mod
        puts "This is the new hash #{updated_cart}"
      end
      cart_index += 1 
    end
  updated_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  updated_cart = []
  cart_index = 0 
    while cart_index < cart.count do 
      item = cart[cart_index][:item]
      if has_coupon = does_coupon_exist(item, coupons)
        # came back true w/index # - which means there's a coupon 
        
        #update hash before adding to new array 
        old_hash = cart[cart_index]
        coupon_hash = coupons[has_coupon]
        old_hash[:count] -= coupon_hash[:num]
        
        updated_cart << old_hash # test required cart be filled with 0 item hashes 
        updated_cart << new_item_hash( item, (coupons[has_coupon][:cost] / coupons[has_coupon][:num]), cart[cart_index][:clearance], coupons[has_coupon][:num] )
      else 
        # came back false which means no coupon 
        updated_cart << cart[cart_index]
      end 
      cart_index += 1 
    end
  updated_cart
end

def new_item_hash (item, price, clearance, count)
  new_item = {
    :item => "#{item} W/COUPON",
    :price => price,
    :clearance => clearance,
    :count => count
  }
end

def does_coupon_exist (item, coupons)
  #check array of hashes #{coupons} to see if the cart item has a coupon
  #return index of element in coupon array in apply_coupons
  
  coupon_index = 0 
    while coupon_index < coupons.count do 
      if has_coupon = coupons.index { |h| h[:item] == item }
        return has_coupon
      end
    coupon_index += 1   
    end
end 

def apply_clearance(cart)
  #applying 20% clearance to items marked #clearance 
  updated_cart = []
  cart_index = 0 
    while cart_index < cart.count do 
      if cart[cart_index][:clearance] 
        disc_price = (cart[cart_index][:price] - (cart[cart_index][:price] * 0.2))
        cart[cart_index][:price] = disc_price.round(2)
        updated_cart << cart[cart_index]
      else 
        updated_cart << cart[cart_index]
      end
      cart_index += 1
    end 
  updated_cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  consolidated_cart = consolidate_cart(cart)
  
  puts "This is #{consolidated_cart}"
  applied_coupons = applied_coupons(console_me, coupons)
  applied_clearance = apply_clearance(applied_coupons)
  
  cart_index = 0 
  price_total = 0 
    while cart_index < applied_clearance.length 
      total += applied_clearance[cart_index][:price] * applied_clearance[cart_index][:count]
      cart_index += 1 
    end 
  
    if total > 100 
      total -= (total * 0.10)
    end 
    
    total 
  
end
