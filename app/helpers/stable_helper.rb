module StableHelper
	
	def stable
		@builder = STableBuilder.new(self)
		@builder.table do
			yield
		end
	end

	def table
		@builder = TableBuilder.new(self)
		@builder.table do
			yield
		end
	end

	def tr
		@builder.tr do
			yield
		end
	end

	def td(content)
		@builder.td content
	end

end

class TableBuilder

	def initialize(context)
		@context = context
	end

	def table
		@context.haml_tag :table do
			yield
		end
	end

	def tr
		@context.haml_tag :tr do
			yield
		end
	end

	def td(content)
		@context.haml_tag :td do
			@context.haml_concat content
		end
	end
end

class STableBuilder

	def initialize(context)
		@context = context
		@data = []
	end

	def table
		yield

		@context.haml_concat @context.render(:partial => '/stable/stable', :locals => { :data => @data })		
	end

	def tr
		@data << []
		yield
	end

	def td(content)
		@data.last << content
	end
end
