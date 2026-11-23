-- 阿风脚本 | 固定入口 loader（这个文件永远不用改，更新只改 hub.lua）
-- 仓库: https://github.com/ZG2022Q0/-txt

local PATH = "ZG2022Q0/-txt/main/hub.lua"
local Q = "?v=" .. os.time()

local MIRRORS = {
      "https://raw.githubusercontent.com/" .. PATH .. Q,
      "https://gh-proxy.com/https://raw.githubusercontent.com/" .. PATH .. Q,
      "https://ghfast.top/https://raw.githubusercontent.com/" .. PATH .. Q,
}

local src, lastErr
for _, url in ipairs(MIRRORS) do
      local ok, body = pcall(function()
              return game:HttpGet(url, true)
    end)
      if ok and type(body) == "string" and #body > 200 and not body:find("404: Not Found", 1, true) then
            src = body
            break
  end
      lastErr = body
end

if not src then
      warn("[阿风脚本] 拉取失败，请检查网络: " .. tostring(lastErr))
      return
end

local f = loadstring or load
if not f then
      warn("[阿风脚本] 当前执行器不支持 loadstring")
      return
end

local ok, err = pcall(function()
        f(src)()
  end)

if not ok then
      warn("[阿风脚本] 运行出错: " .. tostring(err))
end
