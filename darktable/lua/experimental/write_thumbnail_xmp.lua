-- Based on https://github.com/michmill1970/dt-dk-thumbnail (commit 9fdfdc2),
-- modified to also write the thumbnail automatically when leaving an edited
-- image in darkroom.
--
-- Darktable Lua script to write a thumbnail to the related XMP metadata file
-- so digiKam can display the thumbnail in the digiKam Light Table view.
-- 
-- Copyright (C) 2025  Michael Miller <michael underscore miller at msn dot com>
--
-- MIT License
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
-- documentation files (the “Software”), to deal in the Software without restriction, including without limitation
-- the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
-- to permit persons to whom the Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all copies or substantial portions
-- of the Software.
--   
-- THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
-- TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


-- Uncomment the following 2 lines and replace with your values if the Lua library environment variables are not set
-- package.path = package.path .. ";/opt/homebrew/Cellar/luarocks/3.11.1/share/lua/5.4/?.lua"
-- package.cpath = package.cpath .. ";/opt/homebrew/lib/lua/5.4/?.so;/opt/homebrew/lib/lua/5.4/mime/?.so"

local dt = require "darktable"
local mime = require "mime"
local gettext = dt.gettext.gettext

local function _(msgid)
  return gettext(msgid)
end

-- Modified: split per-image work out of create_thumbnail() so it can also run
-- automatically when leaving an edited image in darkroom (see bottom).

-- Write a thumbnail of one image's current edit into its .xmp sidecar
local function write_thumbnail(image)
  do
    -- Create the thumbnail image
    local temp_path = dt.configuration.tmp_dir .. "/thumbnail.jpg"  -- Use Darktable cache directory for the temporary path
    local exporter = dt.new_format("jpeg")
    exporter.quality = 85
    exporter.max_height = 200
    exporter.max_width = 200
    exporter:write_image(image, temp_path, false)
  
    -- Read the thumbnail and encode it in base64
    local file_content = nil
    local base64_content = nil
    local file = io.open(temp_path, "rb")
    if file then
      file_content = file:read("*all")
      file:close()
      base64_content = mime.b64(file_content)
    else
      dt.print("Failed to open thumbnail file: " .. temp_path)
      return
    end

    -- Delete the temporary thumbnail
    os.remove(temp_path)

    -- Check if the base64 encoding was successful
    if base64_content then
      local xmp_path = image.path .. "/" .. image.filename .. ".xmp"
      local xmp_file = io.open(xmp_path, "r")
      local xmp_temp_file = io.open(xmp_path .. ".tmp", "w")

      -- Copy the XMP file by reading it line by line and writing it to a new file
      if xmp_file and xmp_temp_file then
        local preview_written = false
        local previewsource_written = false
        for line in xmp_file:lines() do

          -- Skip the existing digiKam:PreviewSource property
          if not string.find(line, 'digiKam:PreviewSource=') then

            -- Write the new base64 encoded thumbnail to the digiKam:Preview property of the XMP file
            if string.find(line, 'digiKam:Preview=') and not preview_written then
              xmp_temp_file:write('   digiKam:Preview="' .. base64_content .. '"\n')
              preview_written = true
              if not previewsource_written then
                xmp_temp_file:write('   digiKam:PreviewSource="dkdtLuaThumbnail"\n')
                previewsource_written = true
              end
            else
              -- Write the line as is
              xmp_temp_file:write(line .. "\n")
              -- If the digiKam:Preview property is not present, add it after the xmp:Rating property
              if string.find(line, 'xmp:Rating=') and not preview_written then
                xmp_temp_file:write('   digiKam:Preview="' .. base64_content .. '"\n')
                preview_written = true
                if not previewsource_written then
                  xmp_temp_file:write('   digiKam:PreviewSource="dkdtLuaThumbnail"\n')
                  previewsource_written = true
                end
              end
            end
          end
        end
        xmp_file:close()
        xmp_temp_file:close()
        os.remove(xmp_path)
        os.rename(xmp_path .. ".tmp", xmp_path)
      else
        dt.print("Failed to open XMP file: " .. xmp_path)
      end        
    end

    -- Print a confirmation message
    dt.print("Thumbnail written to XMP metadata")
  
  end
end

-- Function to create thumbnails for the selected images
local function create_thumbnail()
  for _, image in ipairs(dt.gui.selection()) do
    write_thumbnail(image)
  end
end

-- Register the create_thumbnail function to be called when a shortcut is pressed
dt.register_event("Create XMP Thumbnail", "shortcut", 
    function(event, shortcut)
      create_thumbnail()
    end, _("Create XMP Thumbnail")
  )

-- Automatic mode: when leaving an image that was edited in darkroom (switching
-- to another image, or going back to lighttable), write its thumbnail without
-- needing the shortcut. Quitting straight from darkroom doesn't: the exit event
-- fires before darktable saves the final history, so go to lighttable first.
local current = nil  -- image shown in darkroom
local edited = {}    -- images whose history changed, keyed by id

local function flush(image)
  if image and edited[image.id] then
    edited[image.id] = nil
    local ok, err = pcall(write_thumbnail, image)
    if not ok then dt.print_error("auto thumbnail: " .. tostring(err)) end
  end
end

dt.register_event("dk_thumb_history", "darkroom-image-history-changed",
  function(event, image) edited[image.id] = true end)

dt.register_event("dk_thumb_loaded", "darkroom-image-loaded",
  function(event, clean, image)
    if not clean then return end
    if current and current.id ~= image.id then flush(current) end
    current = image
  end)

dt.register_event("dk_thumb_view", "view-changed",
  function(event, old_view, new_view)
    if old_view and old_view.id == "darkroom" then
      flush(current)
      current = nil
    end
  end)
