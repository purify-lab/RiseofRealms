extends Node

# 钱包地址取前后四位
func MakeAddressString(origin_string):
	var res = origin_string.substr(0, 4) + "..."
	res = res + origin_string.substr(origin_string.length() - 4, 4)
	return res
