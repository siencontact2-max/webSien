Add-Type -AssemblyName System.Drawing

$sourcePath = "C:\Users\equipo\.gemini\antigravity\brain\cad73f9e-a4bd-4e05-9026-92dae9cd8865\uploaded_media_1769956562919.jpg"
$destPath = "C:\Users\equipo\.gemini\antigravity\scratch\pagina_web\logo_real_circle.png"

# Load image
$srcImage = [System.Drawing.Image]::FromFile($sourcePath)
$width = $srcImage.Width
$height = $srcImage.Height
$minSize = [Math]::Min($width, $height)

# Create destination bitmap (transparent)
$destBitmap = New-Object System.Drawing.Bitmap($minSize, $minSize)
$graphics = [System.Drawing.Graphics]::FromImage($destBitmap)

# High quality settings
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

# clear with transparency (already default for new bitmap but good practice)
$graphics.Clear([System.Drawing.Color]::Transparent)

# Create a brush from the source image
# We need to center the crop. 
$xOffset = ($width - $minSize) / 2
$yOffset = ($height - $minSize) / 2

# Draw the image cropped to a circle
# Using a TextureBrush would tile, so we'll use a GraphicsPath to clip the draw
$path = New-Object System.Drawing.Drawing2D.GraphicsPath
$path.AddEllipse(0, 0, $minSize, $minSize)
$graphics.SetClip($path)

$destRect = New-Object System.Drawing.Rectangle(0, 0, $minSize, $minSize)
$srcRect = New-Object System.Drawing.Rectangle($xOffset, $yOffset, $minSize, $minSize)

$graphics.DrawImage($srcImage, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)

# Save
$destBitmap.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Png)

# Cleanup
$graphics.Dispose()
$destBitmap.Dispose()
$srcImage.Dispose()
$path.Dispose()

Write-Host "Success: Created $destPath"
