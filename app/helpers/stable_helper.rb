module StableHelper
	
	def stable(options = {})
		@builder = STableBuilder.new(self)
		@builder.table(options) do
			yield
		end
	end

	def table(options = {})
		@builder = TableBuilder.new(self)
		@builder.table(options) do
			yield
		end
	end

	def tr
		@builder.tr do
			yield
		end
	end

	def td(content, options = {})
		@builder.td content, options
	end

end

module Enumerable
	def enum_drop_with_index(count)
		self.each_with_index do |e, index|
			next if index < count
			yield e, index
		end
	end

	def enum_drop(count)
		self.enum_drop_with_index(count) do |e, index|
			yield e
		end
	end
end

class TableBuilder

	def initialize(context)
		@context = context
		@row_index = -1
		@column_html_options = []
	end

	def table(options)
		@context.haml_tag :table, options[:html] do
			yield
		end
	end

	def tr
		@row_index += 1
		@col_index = -1

		@context.haml_tag :tr do
			yield
		end
	end

	def td(content, options)
		@col_index += 1

		if @row_index == 0
			@column_html_options << (options.delete(:column) || {})
		end

		@context.haml_tag :td, options.merge(@column_html_options[@col_index]) do
			@context.haml_concat content
		end
	end
end

class STableBuilder

	def initialize(context)
		@context = context
		@data = []
		@column_html_options = []
		@row_index = -1
	end

	def table(options)
		options.reverse_merge!({ fixed_rows: 1, html: {} })

		yield

		@context.haml_concat @context.render(:partial => '/stable/stable', 
			:locals => { 
				:data => @data, 
				:options => options
			}
		)		
	end

	def tr
		@row_index += 1
		@col_index = -1

		@data << []
		yield
	end

	def td(content, html_options)
		@col_index += 1

		# ensure slot for @column_html_options[@col_index]
		if @col_index >= @column_html_options.size
			@column_html_options << {}
		end
		
		# if html_options define style for column, override it
		if c = html_options.delete(:column)
			@column_html_options[@col_index] = c
		end

		# merge html_options with column html_options
		html_options.merge!(@column_html_options[@col_index])

		@data.last << { value: content, html_options: html_options }
	end
end
