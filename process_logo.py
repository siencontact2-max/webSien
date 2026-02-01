import cv2
import numpy as np

# Load the image
image_path = "C:/Users/equipo/.gemini/antigravity/brain/cad73f9e-a4bd-4e05-9026-92dae9cd8865/uploaded_media_1769956216434.jpg"
img = cv2.imread(image_path)

if img is None:
    print(f"Error: Could not load image from {image_path}")
    exit(1)

# Convert to RGBA
img = cv2.cvtColor(img, cv2.COLOR_BGR2BGRA)

# Get dimensions
h, w = img.shape[:2]
center = (w // 2, h // 2)
radius = min(h, w) // 2

# Create a circular mask
mask = np.zeros((h, w), dtype=np.uint8)
cv2.circle(mask, center, radius, (255), -1)

# Apply mask to alpha channel
img[:, :, 3] = mask

# Crop the image to the bounding box of the circle
x, y, w, h = cv2.boundingRect(mask)
cropped_img = img[y:y+h, x:x+w]

# Save the result
output_path = "C:/Users/equipo/.gemini/antigravity/scratch/pagina_web/logo_final.png"
cv2.imwrite(output_path, cropped_img)
print(f"Saved processed image to {output_path}")
