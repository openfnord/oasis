io.write[[
/* AUTOMATICALLY GENERATED by fourcc.lua. You should modify
   that script instead of adding here entries manually! */
static const struct drmFormatModifierInfo drm_format_modifier_table[] = {
    { DRM_MODIFIER_INVALID(NONE, INVALID) },
    { DRM_MODIFIER_LINEAR(NONE, LINEAR) },
]]

local vendors = {
	ARM=true,
	SAMSUNG=true,
	QCOM=true,
	VIVANTE=true,
	NVIDIA=true,
	BROADCOM=true,
	ALLWINNER=true,
}
for line in io.lines() do
	local mod = line:match('^#define I915_FORMAT_MOD_([%w_]+)')
	if mod then
		io.write(string.format('    { DRM_MODIFIER_INTEL(%s, %s) },\n', mod, mod))
	end
	local vendor, mod = line:match('^#define DRM_FORMAT_MOD_(%w+)_([%w_]+)%s')
	if vendors[vendor] then
		if vendor ~= 'ARM' or not mod:match('^TYPE_') then
			io.write(string.format('    { DRM_MODIFIER(%s, %s, %s) },\n', vendor, mod, mod))
		end
	end
	local vendor = line:match('^#define DRM_FORMAT_MOD_VENDOR_([%w_]+)')
	if vendor then
		table.insert(vendors, vendor)
	end
end

io.write[[
};
static const struct drmFormatModifierVendorInfo drm_format_modifier_vendor_table[] = {
]]
for _, vendor in ipairs(vendors) do
	io.write(string.format('    { DRM_FORMAT_MOD_VENDOR_%s, "%s" },\n', vendor, vendor))
end
io.write[[
};
]]