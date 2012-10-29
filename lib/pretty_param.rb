module PrettyParam
	class << self
		# This method does the actual permalink escaping.
		def escape(string)
			result = string
			result.gsub!(/[^\x00-\x7F]+/, '') # Remove anything non-ASCII entirely (e.g. diacritics).
			result.gsub!(/[^\w_ \-]+/i, '') # Remove unwanted chars.
			result.gsub!(/[ \-]+/i, '-') # No more than one of the separator in a row.
			result.gsub!(/^\-|\-$/i, '') # Remove leading/trailing separator.
			result.downcase
		end
	end
		
	module ClassMethods
		# Takes 1 or more symbols and stores them in class.pretty_params,
		# and then overrides to_param
		def has_pretty_param(*fields)			
      if RUBY_VERSION < "1.9.3"
        singleton = class << self; self; end
        singleton.send :define_method, :pretty_params, lambda { fields }
      else
        define_singleton_method :pretty_params, -> { fields }
      end

			define_method :to_param do
				PrettyParam.escape("#{self.id}-#{self.class.pretty_params.map{|a| self.send(a.to_sym) }.join('-')}")
			end
		end
	end
end

ActiveRecord::Base.extend PrettyParam::ClassMethods
