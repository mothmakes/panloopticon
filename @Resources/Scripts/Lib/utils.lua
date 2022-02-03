function split_with_comma(str)
    local fields = {}
    for field in str:gmatch('([^,]+)') do
      fields[#fields+1] = field
    end
    return fields
end