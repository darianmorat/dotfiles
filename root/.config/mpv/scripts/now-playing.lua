local reset = "\27[0m"
local dim = "\27[2m"
local c_color = "\27[33m"
local t_color = "\27[34m"
local last_pos = -1

mp.register_event("file-loaded", function()
   local pos = mp.get_property_number("playlist-pos-1") or 0
   local count = mp.get_property_number("playlist-count") or "?"
   local title = mp.get_property("media-title") or "Unknown"
   local filepath = mp.get_property("path") or ""
   local artist = mp.get_property("metadata/by-key/Artist") or ""

   if pos == last_pos then
      return
   end
   last_pos = pos

   io.write("\r\27[2K")

   local out = "\n"
      .. c_color
      .. string.format("[%s/%s]", pos, count)
      .. reset
      .. " "
      .. t_color
      .. title
      .. reset
      .. "\n"

   if filepath ~= "" then
      local short = filepath:match("([^/]+/[^/]+)$") or filepath
      out = out .. dim .. "File: " .. reset .. short .. "\n"
   end

   if artist ~= "" then
      out = out .. dim .. "Artist: " .. reset .. artist .. "\n"
   end

   local tracks = mp.get_property_native("track-list") or {}

   for _, track in ipairs(tracks) do
      if track.type == "video" then
         local info = ""
         if track["demux-w"] and track["demux-h"] then
            info = string.format("%dx%d", track["demux-w"], track["demux-h"])
         end
         if info ~= "" then
            out = out .. dim .. "Image: " .. reset .. info .. "\n"
         end
         break
      end
   end

   for _, track in ipairs(tracks) do
      if track.type == "audio" then
         local info = track.codec or ""
         if track["demux-channel-count"] then
            info = info .. " " .. track["demux-channel-count"] .. "ch"
         end
         if track["demux-samplerate"] then
            info = info .. " " .. track["demux-samplerate"] .. " Hz"
         end
         if track["demux-bitrate"] then
            info = info .. " " .. math.floor(track["demux-bitrate"] / 1000) .. " kbps"
         end
         out = out .. dim .. "Audio: " .. reset .. info .. "\n"
         break
      end
   end

   io.write(out)
   io.flush()
end)
