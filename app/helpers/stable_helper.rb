module StableHelper
	
	def stable(html_options = {})
		@builder = STableBuilder.new(self)
		@builder.table(html_options) do
			yield
		end
	end

	def table(html_options = {})
		@builder = TableBuilder.new(self)
		@builder.table(html_options) do
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

class TableBuilder

	def initialize(context)
		@context = context
		@row_index = -1
		@column_html_options = []
	end

	def table(html_options)
		@context.haml_tag :table, html_options do
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
	end

	def table(html_options)
		yield

		@context.haml_concat @context.render(:partial => '/stable/stable', 
			:locals => { 
				:data => @data, 
				:html_options => html_options, 
				:column_html_options => @column_html_options 
			}
		)		
	end

	def tr
		@data << []
		yield
	end

	def td(content, options)
		@column_html_options << (options[:column] || {})
		@data.last << content
	end
end
