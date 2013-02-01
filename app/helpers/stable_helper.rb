module StableHelper
	
	def stable(options = {})
		@builder = STableBuilder.new(self, '/stable/stable')
		@builder.table(options) do
			yield
		end
	end

	def table(options = {})
		@builder = STableBuilder.new(self, '/stable/table')
		@builder.table(options) do
			yield
		end
	end

	def tr(html_options = {})
		@builder.tr html_options do
			yield
		end
	end

	def td(content, html_options = {})
		@builder.td content, html_options
	end

	def thead
		@builder.thead do
			yield
		end
	end

	def tbody
		@builder.tbody do
			yield
		end
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

class STableBuilder

	def initialize(context, partial_view)
		@partial_view =  partial_view
		@context = context
		@data = []
		@column_html_options = []
		@row_wrapper_html_options = []
		@row_index = -1
	end

	def table(options)
		@options = options.reverse_merge!({ fixed_rows: 1 })
		html_options = options.clone
		html_options.delete :fixed_rows

		yield

		@context.haml_concat @context.render(:partial => @partial_view, 
			:locals => { 
				:data => @data, 
				:options => @options,
				:html_options => html_options,
				:row_wrapper_html_options => @row_wrapper_html_options
			}
		)		
	end

	def tr(html_options)
		@row_index += 1
		@col_index = -1

		@row_wrapper_html_options << html_options
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

	def thead
		yield
		@options[:fixed_rows] = @row_index + 1
	end

	def tbody
		yield
	end
end
