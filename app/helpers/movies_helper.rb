module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  def helper(inp)
    if(inp==params[:sort_by].to_s())
      return 'hilite'
    else
      return nil
    end
  end
  #new helper function to check all the check boxes in the beginning. It'll be called with check_box_tag
  def is_ratings_selected?(rating)
    session[:ratings].include?(rating)
  end
end
