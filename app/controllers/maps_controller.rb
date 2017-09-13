class MapsController < ApplicationController
	def new		
	end
  def show
  	$selectedmap = Map.find(params[:id])
	@map = Map.find(params[:id])					
	unless @map.sourcefile.nil?
		open_file_name = Rails.root.join('public', 'uploads', @map.sourcefile)
		@csv_table = CSV.open(open_file_name, :headers => true).read	
	end
  end
  def index
  	@maps = Map.all
  end

  def edit
  	@map = Map.find(params[:id])
  end
  
  def update
		@map = Map.find(params[:id])

		if @map.update(map_params)
		  redirect_to @map
		else
		  render 'edit'
		end
	end
	
	def create
	  @map = Map.new(map_params)
	 
	  if @map.save
	    redirect_to @map
	  else
	    render 'new'
	  end
	end
	
	def vsd
		@map = Map.find(params[:id])					
		unless @map.sourcefile.nil?
			open_file_name = Rails.root.join('public', 'uploads', @map.sourcefile)
			@csv_table = CSV.open(open_file_name, :headers => true).read	
		end
	end

	def vcm
		@map = Map.find(params[:id])	

		@trait = Trait.find(@map.trait_id)
		group_ids = @map.traitgroups_id.split(',')
		@traitgroups = Traitgroup.find(group_ids)		
		@group_array = Array.new
		@traitgroups.each do |group|
			@group_array.push(group.trait_group_name)
		end

		unless @map.sourcefile.nil?
			open_file_name = Rails.root.join('public', 'uploads', @map.sourcefile)
			@csv_table = CSV.open(open_file_name, :headers => true).read	
			
			@vgs_header = CSV.read(Rails.root.join('public', 'uploads', open_file_name), headers: true).headers			
			@vgs_header.shift(4)	
			@vgs_body = Array.new
			tmp_row   = Array.new
			vgs_row   = Array.new

			#Statistics Array			
			count80_row = Array.new
			count20_row = Array.new
			count40_row = Array.new
			count60_row = Array.new
			count100_row = Array.new
		
			count20_row.push('Count 0-20')
			count40_row.push('Count 21-40')
			count60_row.push('Count 41-60')
			count80_row.push('Count 61-80')
			count100_row.push('Count 81-100')
			@vgs_header.each_with_index do |row, i| 
				vgs_row = []
				tmp_row = []
				@csv_table.each do |row1|
					tmp_row.push(row1[i+4])
				end												
				count20_row.push(count_min_to_max(tmp_row,0,20))				
				count40_row.push(count_min_to_max(tmp_row,21,40))
				count60_row.push(count_min_to_max(tmp_row,41,60))
				count80_row.push(count_min_to_max(tmp_row,61,80))
				count100_row.push(count_min_to_max(tmp_row,81,100))
			end						
			@vgs_body.push(count20_row)			
			@vgs_body.push(count40_row)
			@vgs_body.push(count60_row)
			@vgs_body.push(count80_row)
			@vgs_body.push(count100_row)
			@vgs_header.unshift('Statistical Data Point')
		end
	end

	def vgs
		@map = Map.find(params[:id])	

		@trait = Trait.find(@map.trait_id)
		group_ids = @map.traitgroups_id.split(',')
		@traitgroups = Traitgroup.find(group_ids)		
		@group_array = Array.new
		@traitgroups.each do |group|
			@group_array.push(group.trait_group_name)
		end

		unless @map.sourcefile.nil?
			open_file_name = Rails.root.join('public', 'uploads', @map.sourcefile)
			@csv_table = CSV.open(open_file_name, :headers => true).read	
			
			@vgs_header = CSV.read(Rails.root.join('public', 'uploads', open_file_name), headers: true).headers			
			@vgs_header.shift(4)	
			@vgs_body = Array.new
			tmp_row   = Array.new
			vgs_row   = Array.new

			#Statistics Array
			min_row    = Array.new
			max_row    = Array.new
			range_row  = Array.new
			mean_row   = Array.new
			median_row = Array.new
			count80_row = Array.new
			count20_row = Array.new
			count40_row = Array.new
			count60_row = Array.new
			count100_row = Array.new

			min_row.push('Minimum Score')
			max_row.push('Maximum Score')			
			count20_row.push('Count 0-20')
			count40_row.push('Count 21-40')
			count60_row.push('Count 41-60')
			count80_row.push('Count 61-80')
			count100_row.push('Count 81-100')
			@vgs_header.each_with_index do |row, i| 
				vgs_row = []
				tmp_row = []
				@csv_table.each do |row1|
					tmp_row.push(row1[i+4])
				end								
				min_row.push(tmp_row.min)				
				max_row.push(tmp_row.max)
				count20_row.push(count_min_to_max(tmp_row,0,20))				
				count40_row.push(count_min_to_max(tmp_row,21,40))
				count60_row.push(count_min_to_max(tmp_row,41,60))
				count80_row.push(count_min_to_max(tmp_row,61,80))
				count100_row.push(count_min_to_max(tmp_row,81,100))
			end			
			@vgs_body.push(min_row)
			@vgs_body.push(max_row)			
			@vgs_body.push(count20_row)			
			@vgs_body.push(count40_row)
			@vgs_body.push(count60_row)
			@vgs_body.push(count80_row)
			@vgs_body.push(count100_row)
			@vgs_header.unshift('Statistical Data Point')
		end
	end
	def moremaps
		@map = Map.all
	end

	def import		
		uploaded_io = params[:sourcefile]
		
		uploaded_file_name = Time.now.strftime("%d%m%y%H%M%S").to_s + uploaded_io.original_filename.to_s
		
		File.open(Rails.root.join('public', 'uploads', uploaded_file_name), 'wb') do |file|
		  file.write(uploaded_io.read)
		end					
		
		headers = CSV.read(Rails.root.join('public', 'uploads', uploaded_file_name), headers: true).headers
		headers.shift(4)	
		
		trait = Trait.new(trait: headers)
		trait.save
		
		@map = Map.find(params[:id])	
		if @map.update(sourcefile: uploaded_file_name,trait_id: trait.id)		
		  redirect_to @map		
		end
	end

	def ctg
		selected_traits = params[:selected_traits]		
		traitgroup = Traitgroup.new(traitgroup: selected_traits, trait_group_name: params[:trait_group_name])
		traitgroup.save
		@map = Map.find(params[:id])		
		if @map.traitgroups_id.nil?
			if @map.update(traitgroups_id: traitgroup.id)		
		  	redirect_to @map		
			end
		else 
			ts = @map.traitgroups_id.to_s + ',' + traitgroup.id.to_s
			if @map.update(traitgroups_id: ts)		
		  	redirect_to @map		
			end
		end
	end
	private
	def map_params
		params.require(:map).permit(:datapoints, :maptitle)
	end	  
	def stats_min(data)
	    data.min
  	end
  	def stats_max(data)
    	data.max
  	end
  	def stats_average(data)
    	total = data.inject(:+)
    	len = data.length
    	average = data.to_f / len 
  	end
  	def stats_mode(data)
    	data = [1, 1, 1, 2, 3]
    	freq = data.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    	data.max_by { |v| freq[v] }
  	end

  	def sum
    	self.inject(0){|accum, i| accum + i }
  	end

	def mean
    	self.sum/self.length.to_f
  	end

  	def sample_variance
    	m = self.mean
    	sum = self.inject(0){|accum, i| accum +(i-m)**2 }
    	sum/(self.length - 1).to_f
  	end

  	def standard_deviation
    	return Math.sqrt(self.sample_variance)
  	end
  
  	def percentile(values, percentile)
    	values_sorted = values.sort
    	k = (percentile*(values_sorted.length-1)+1).floor - 1
    	f = (percentile*(values_sorted.length-1)+1).modulo(1)
		return values_sorted[k] + (f * (values_sorted[k+1] - values_sorted[k]))
	end
	def count_min_to_max(arr,min,max)
  		cnt = 0
  		arr.each do |element|  		
  			if ( element.to_f >= min.to_f && element.to_f <=max.to_f)
				  cnt +=1
				end		
  		end  	
  		cnt
 	end
 end

  	
  
