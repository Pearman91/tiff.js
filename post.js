var loadModule = function (options) {
	if ('TOTAL_MEMORY' in options) {
		Module['TOTAL_MEMORY'] = options['TOTAL_MEMORY'];
	}
	// Kind of patch things together here...

	Module.ccall = ccall;
	Module.cwrap = cwrap;
	Module.setValue = setValue;
	Module.getValue = getValue;
	Module.Pointer_stringify = Pointer_stringify;
	return Module;
};
