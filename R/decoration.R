decorate = function(x, ...){
	UseMethod("decorate")
}

decorate.earth = function(x, dataset, ...){

	if(is.null(x$xlevels)){
		x$xlevels = .getFactorLevels(dataset)
	}

	decorate.default(x, ...)
}

decorate.elmNN = function(x, dataset, ...){

	if(is.null(x$model)){
		x$model = model.frame(x$formula, data = dataset)

		mmat = model.matrix(x$model, data = x$model)
		attr(attr(x$model, "terms"), "columns") = colnames(mmat)
	}

	decorate.default(x, ...)
}

decorate.ranger = function(x, dataset, ...){

	if(is.null(x$variable.levels)){
		x$variable.levels = .getFactorLevels(dataset)
	}

	decorate.default(x, ...)
}

decorate.svm.formula = function(x, dataset, ...){

	if(is.null(x$xlevels)){
		x$xlevels = .getFactorLevels(dataset)
	}

	decorate.default(x, ...)
}

decorate.train = function(x, ...){
	decorate(x$finalModel, preProcess = NULL, ...)
}

decorate.xgb.Booster = function(x, fmap, response_name = NULL, response_levels = c(), missing = NULL, ntreelimit = NULL, compact = FALSE, ...){
	x$fmap = fmap

	schema = list()

	if(!is.null(response_name)){
		schema$response_name = response_name
	}

	if(length(response_levels) > 0){
		schema$response_levels = response_levels
	}

	if(!is.null(missing)){
		schema$missing = missing
	}

	if(length(schema) > 0){
		x$schema = schema
	}

	if(is.null(x$ntreelimit)){
		x$ntreelimit = ntreelimit
	}

	if(is.null(x$compact)){
		x$compact = compact
	}

	decorate.default(x, ...)
}

decorate.default = function(x, preProcess = NULL){

	if(!is.null(preProcess)){
		x$preProcess = preProcess
	}

	return (x)
}

.getFactorLevels = function(dataset){
	levels = lapply(dataset, function(x){ if(is.factor(x)) { levels(x) } else { NULL }})

	return (levels[!vapply(levels, is.null, NA)])
}
