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
    counter = 0
    while counter < coupons.length do
        cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
        couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
        cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
        if cart_item && cart_item[:count] >= coupons[counter][:num]
            if cart_item_with_coupon
                cart_item_with_coupon[:count] += coupons[counter][:num]
                cart_item[:count] -= coupons[counter][:num]
            else 
                cart_item_with_coupon = {
                    :item => couponed_item_name,
                    :price => coupons[counter][:cost] / coupons[counter][:num],
                    :count => coupons[counter][:num],
                    :clearance => cart_item[:clearance]
                }
                cart << cart_item_with_coupon
                cart_item[:count] -= coupons[counter][:num]
            end
        end
        counter += 1
    end 
    cart 
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
  