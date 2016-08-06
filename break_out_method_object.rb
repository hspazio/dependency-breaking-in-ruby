# Break Out Method Object is used when breaking a long method
# and moving it under test. 
# The procedure is to start movig the method under a separate
# class where we can isolate the behavior and facilitate future
# refactorings.

class Brush
  def draw(rendering_roots, colors, selection)
  	rendering_roots.each do |p|
      # long method...
      draw_point(p.x, p.y, colors[n])
    end
    # more code...
  end

  private

  def draw_point(x, y, color)
    # ...
  end
end

# ---------------
# step 1
class Renderer
  def initialize(brush, rendering_roots, colors, selection)
    @brush = brush
    @rendering_roots = @rendering_roots
    @colors = colors
    @selection = selection
  end

  def draw
    @rendering_roots.each do |p|
      # long method...
      @brush.draw_point(p.x, p.y, colors[n])
    end
    # more code...
  end
end

# Then we change Brush#draw to delegate to the new Renderer 
# object and change Brush#draw_point to public in order to
# allow it to be called from Renderer#draw.
class Brush
  def draw(rendering_roots, colors, selection)
  	renderer = Renderer.new(self, 
  		                    rendering_roots,
  		                    colors,
  		                    selection)
  	renderer.draw
  end

  def draw_point(x, y, color)
    # ...
  end
end

# ---------------
# step 2
# If it's hard to initialize a brush in a test harness we can
# proceed creating a fake that implements #draw_point interface.
class BrushFake
  def draw_point(x, y, color)
    # pretend to be a brush drawing point
  end
end

# At this point many other refactoring techniques could be applied
# in order to improve the design of the code...
