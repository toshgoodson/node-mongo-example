
# 
# GET home page.
# 

exports.index = (req, res) -> 
	

	# render the page
	res.render 'index', { title: 'Express' }
