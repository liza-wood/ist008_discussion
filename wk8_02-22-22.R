# Meeting ID: 97274804927
# Passcode: 032433

# Week 8 Discussion
# ----------------------
# Q4A. wording about shape as category? missing shapes?
# marks and channels -- what do these mean?
# Q5B. "who" is left out? intended audience?

# What is shape for graphics? Shape is a channel
# Marks: basic geometries or graphical elements that depict our data items or their linkages -- basically, the geom you use
# Channel: attributes that control how the marks (geoms) appear -- a DATA-BASED aesthetic. (Hot take from Pamela, and I generally agree: aesthetics that are not data based are *usually* pointless. I think there are some exceptions, like alpha (transparency))

# Let's play with the plot from Q4
# you only get 6 shapes by default, says the warning...
ggplot(dogs, aes(x = height, y = weight)) +
  geom_point(color = "purple", aes(shape = group))

# What can you do? Add a scale_shape_manual layer -- you can find this on Stack Overflow. Be sure to also google which numbers represent which shapes.
?scale_shape_manual

# What goes inside scale_shape_manual? The value argument calls out certain shapes by numbers (yes, this is a bit confusing) and you have to specify how many shapes you want. In our case, 7. But they don't have to be 1:7, it could be 3:10, or any other range, like c(4,7,8,20,25,3,1) (well, you might run out of shapes eventually, so you should look up the shape-numbers)

ggplot(dogs, aes(x = height, y = weight)) +
  geom_point(color = "purple", aes(shape = group)) +
  scale_shape_manual(values = 3:10)

# Why can't you put the aes inside the scale function? It is just not mobile to that layer. Scale will adjust any aesthetic (explore all the different scale_ functions with tab complete). So this still plots but it does not apply the aes

ggplot(dogs, aes(x = height, y = weight)) +
  geom_point(color = "purple") +
  scale_shape_manual(aes(shape = group), values = 3:10)

# layers of a ggplot: (required) data, geom, aes, then (not required) scale, facet, etc...

