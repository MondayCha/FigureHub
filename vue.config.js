const name = 'Fate Ahhhhhhh' // page title
const path = require('path')

function resolve(dir) {
	return path.join(__dirname, dir)
}

module.exports = {
	runtimeCompiler: true,
	lintOnSave: false,
	publicPath: './',
	outputDir: 'dist',
	assetsDir: 'static',
	configureWebpack: {
		// provide the app's title in webpack's name field, so that
		// it can be accessed in index.html to inject the correct title.
		name: name,
		resolve: {
			alias: {
				'@': resolve('src')
			}
		}
	},
	css: {
		loaderOptions: {
			less: {
				lessOptions: {
					modifyVars: {
						'primary-color': '#fb7299',
						'link-color': '#fb7299',
						// 'border-radius-base': '2px',
					},
					javascriptEnabled: true,
				},
			},
		},
	},
}
