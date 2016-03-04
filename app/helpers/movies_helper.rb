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
end
