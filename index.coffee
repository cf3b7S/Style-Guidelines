fs = require('fs')
async = require('async')
request = require('request')
cheerio = require('cheerio')
config = require('./config')




fileData = '# Style-Guidelines\ncollection of style guidelines\n\n'

count = 0

async.whilst(
	()->
		return count < config.length
	(cb)->
		request.get config[count], (error, response, body)->
			if error
				console.log error
				return

			$ = cheerio.load(body)
			title = $('title').text()

			if title
				fileData += "[#{title}](#{config[count]})\n\n"

			count++
			cb()
			return
	(err, data)->
		fs.writeFile 'README.MD', fileData, (err)->
			if err
				console.log 'write file error'
			else
				console.log 'file generated'
)
