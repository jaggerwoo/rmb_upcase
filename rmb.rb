class Rmb
  Rmb = %w{零 壹 贰 叁 肆 伍 陆 柒 捌 玖}
	Decimal_Unit = %w{角 分}
	Integer_Unit = %w{拾 佰 仟}
	High_Unit = %w{万 亿}

	class << self
		def to_upcase(money)
			result = money.split(".")

			if result.length > 1
				integer_part = result[0]
				decimal_part = result[1][0..1]
			else
				integer_part = result[0]
			end

			rmb = convert_integer(integer_part)
			if decimal_part.blank?
				rmb << "圆整"
			else
				rmb << "圆"
				rmb << convert_decimal(decimal_part)
			end
			puts rmb
			rmb
		end

		def convert_integer(integer_part)
			if integer_part.to_i == 0
				return '零'
			end

			chars = integer_part.chars.to_a
			result = ""
			zero_number = 0
			zero_flag = false
			chars.each_index do |i|
				integer_index = (chars.length - i - 1) % 4
				high_index = (chars.length - i - 1) / 4

				if chars[i] == '0'
					zero_number += 1
					zero_flag = true
				else
					zero_flag = false
				end
				
				if zero_flag
					if integer_index == 0
						result << High_Unit[high_index - 1] if high_index > 0
					end
					next
				else
					if zero_number > 0
						result << '零'
						zero_number = 0
					end

					result << Rmb[chars[i].to_i]
					if integer_index == 0
						result << High_Unit[high_index - 1] if high_index > 0
					else
						result << Integer_Unit[integer_index - 1] 
					end
				end
			end
			result
		end

		def convert_decimal(decimal_part)
			result = ""
			chars = decimal_part.chars.to_a
			result << Rmb[chars[0].to_i] << "角" << Rmb[chars[1].to_i] << "分"
		end
	end
end