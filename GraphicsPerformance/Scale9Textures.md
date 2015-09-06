# Sprite Sheet
Create one square block for every color. Each has a thin white border line.

Create one white and one highlighted texture for the border image with the rounded corners (inner + outer).

# Scale9Texture
Depending on the size of the grid arrays/int-vectors (sizes 3x3=9 to 7x7=49) are created and passed to the GridPattern component. The GridPattern will draw the patterns by their array definition line by line by adding a colored (1) or not colored (0) box from the sprite sheet. The thin lines will overlap. 

Finally the border texture is added on top making the corner boxes rounded. It is implemented as a regular Scale9Texture.

# Reasons
The number textures loaded from the sprite sheet is very low. All can be reused for multiple game tiles.

The Textures are very small and required less memory than drawing ready to use game tiles on the sprite sheet.