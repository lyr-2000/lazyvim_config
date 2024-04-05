

local  function run(f,...) 
  local arg = {...}
  local ok,res = pcall(f,unpack(arg))
  if not ok then 
    print("error occur "..tostring(res))
  end

end

return {
  run = run
}
